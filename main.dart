import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

const String kGeminiApiKey = ' use your API KEY ';    <--- use your API key --> 
const String kGeminiModelEndpoint =
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

class ChatMessage {
  final String role;
  final String text;
  final Uint8List? imageBytes;

  ChatMessage({required this.role, required this.text, this.imageBytes});
}

class GeminiApi {
  final String apiKey;
  final String endpoint;

  const GeminiApi({required this.apiKey, required this.endpoint});

  Future<String> generateText({
    required List<ChatMessage> history,
    required String userText,
    Uint8List? imageBytes,
  }) async {
    if (apiKey.isEmpty) {
      throw Exception('No API key configured in kGeminiApiKey.');
    }

    final contents = <Map<String, dynamic>>[];

    for (final m in history) {
      final parts = <Map<String, dynamic>>[];
      if (m.text.isNotEmpty) {
        parts.add({'text': m.text});
      }
      if (m.imageBytes != null) {
        parts.add({
          'inlineData': {
            'mimeType': 'image/jpeg',
            'data': base64Encode(m.imageBytes!),
          },
        });
      }
      contents.add({
        'role': m.role == 'assistant' ? 'model' : 'user',
        'parts': parts,
      });
    }

    final currentParts = <Map<String, dynamic>>[];
    if (userText.isNotEmpty) {
      currentParts.add({'text': userText});
    }
    if (imageBytes != null) {
      currentParts.add({
        'inlineData': {
          'mimeType': 'image/jpeg',
          'data': base64Encode(imageBytes),
        },
      });
    }

    contents.add({'role': 'user', 'parts': currentParts});

    final body = jsonEncode({'contents': contents});

    final resp = await http
        .post(
          Uri.parse(endpoint),
          headers: {
            'Content-Type': 'application/json',
            'X-goog-api-key': apiKey,
          },
          body: body,
        )
        .timeout(const Duration(seconds: 30));

    if (resp.statusCode != 200) {
      throw Exception('Gemini error ${resp.statusCode}: ${resp.body}');
    }

    final data = jsonDecode(resp.body);
    final candidates = data['candidates'];
    if (candidates == null || (candidates is List && candidates.isEmpty)) {
      throw Exception('No candidates returned by Gemini.');
    }

    final text = (candidates[0]['content']?['parts']?[0]?['text'] ?? '')
        .toString();

    return text.trim();
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(
      colorSchemeSeed: const Color(0xFF6750A4),
      useMaterial3: true,
      brightness: Brightness.dark,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(
        textTheme: GoogleFonts.interTextTheme(base.textTheme),
        scaffoldBackgroundColor: const Color(0xFF0B0F14),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0B0F14),
          elevation: 0,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _opacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward().then((_) {
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const ChatPage()),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F14),
      body: Center(
        child: FadeTransition(
          opacity: _opacity,
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.black, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: const Text(
              'Copilot Chat',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Required for ShaderMask
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  final _scrollCtrl = ScrollController();
  final ImagePicker _picker = ImagePicker();

  final List<ChatMessage> _messages = [];
  bool _isSending = false;
  String? _error;
  Uint8List? _selectedImageBytes;

  late final GeminiApi _api;

  @override
  void initState() {
    super.initState();
    _api = const GeminiApi(
      apiKey: kGeminiApiKey,
      endpoint: kGeminiModelEndpoint,
    );
    _messages.add(
      ChatMessage(
        role: 'assistant',
        text: 'Hi! I’m your AI copilot. Ask me anything or share an image.',
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _selectedImageBytes = bytes;
        });
      }
    } catch (e) {
      setState(() => _error = 'Error picking image: $e');
    }
  }

  Future<void> _send() async {
    final text = _controller.text.trim();
    final imageBytes = _selectedImageBytes;

    if ((text.isEmpty && imageBytes == null) || _isSending) return;

    setState(() {
      _error = null;
      _messages.add(
        ChatMessage(role: 'user', text: text, imageBytes: imageBytes),
      );
      _isSending = true;
      _controller.clear();
      _selectedImageBytes = null;
    });
    _scrollToBottom();

    try {
      final history = _messages.sublist(0, _messages.length - 1);
      final reply = await _api.generateText(
        history: history,
        userText: text,
        imageBytes: imageBytes,
      );

      setState(() {
        _messages.add(ChatMessage(role: 'assistant', text: reply));
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _messages.add(
          ChatMessage(
            role: 'assistant',
            text:
                'Oops, I hit a snag processing that. You can try again in a moment.',
          ),
        );
      });
    } finally {
      setState(() => _isSending = false);
      _scrollToBottom();
    }
  }

  void _newChat() {
    setState(() {
      _messages
        ..clear()
        ..add(
          ChatMessage(
            role: 'assistant',
            text: 'New chat started. How can I help?',
          ),
        );
      _error = null;
      _selectedImageBytes = null;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollCtrl.hasClients) return;
      _scrollCtrl.animateTo(
        _scrollCtrl.position.maxScrollExtent + 160,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const Text('Copilot Chat'),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'New chat',
            onPressed: _isSending ? null : _newChat,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_error != null)
              _ErrorBanner(
                text: _error!,
                onClose: () => setState(() => _error = null),
              ),
            Expanded(
              child: ListView.builder(
                controller: _scrollCtrl,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                itemCount: _messages.length + (_isSending ? 1 : 0),
                itemBuilder: (context, index) {
                  if (_isSending && index == _messages.length) {
                    return const _TypingBubble();
                  }
                  final msg = _messages[index];
                  return _MessageBubble(message: msg);
                },
              ),
            ),
            _InputBar(
              controller: _controller,
              onSend: _send,
              isBusy: _isSending,
              hint: 'Message Copilot…',
              onPickImage: _pickImage,
              selectedImageBytes: _selectedImageBytes,
              onRemoveImage: () => setState(() => _selectedImageBytes = null),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String text;
  final VoidCallback onClose;
  const _ErrorBanner({required this.text, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cs.errorContainer.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error_outline, color: cs.error),
          const SizedBox(width: 8),
          Expanded(
            child: SelectableText(
              text,
              style: TextStyle(color: cs.onErrorContainer),
            ),
          ),
          IconButton(onPressed: onClose, icon: const Icon(Icons.close)),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == 'user';

    final userBg = const LinearGradient(
      colors: [Color(0xFF1C2530), Color(0xFF12171D)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final aiBg = const LinearGradient(
      colors: [Color(0xFF24364D), Color(0xFF1A2431)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 820),
        margin: EdgeInsets.fromLTRB(isUser ? 64 : 12, 6, isUser ? 12 : 64, 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          gradient: isUser ? userBg : aiBg,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
          border: Border.all(color: Colors.white.withOpacity(0.06), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.imageBytes != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.memory(
                    message.imageBytes!,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (message.text.isNotEmpty)
              SelectableText(
                message.text,
                style: const TextStyle(fontSize: 15.5, height: 1.35),
              ),
          ],
        ),
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    final aiBg = const LinearGradient(
      colors: [Color(0xFF24364D), Color(0xFF1A2431)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        margin: const EdgeInsets.fromLTRB(12, 6, 64, 6),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          gradient: aiBg,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
            bottomLeft: Radius.circular(4),
          ),
          border: Border.all(color: Colors.white.withOpacity(0.06), width: 1),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [_Dot(delayMs: 0), _Dot(delayMs: 200), _Dot(delayMs: 400)],
        ),
      ),
    );
  }
}

class _Dot extends StatefulWidget {
  final int delayMs;
  const _Dot({required this.delayMs});

  @override
  State<_Dot> createState() => _DotState();
}

class _DotState extends State<_Dot> with SingleTickerProviderStateMixin {
  late final AnimationController _ac;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ac = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
    _anim = Tween(
      begin: 0.2,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _ac, curve: Curves.easeInOut));
    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) _ac.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Colors.white70,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isBusy;
  final String hint;
  final VoidCallback onPickImage;
  final Uint8List? selectedImageBytes;
  final VoidCallback onRemoveImage;

  const _InputBar({
    required this.controller,
    required this.onSend,
    required this.isBusy,
    required this.hint,
    required this.onPickImage,
    this.selectedImageBytes,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
        decoration: BoxDecoration(
          color: const Color(0xFF0B0F14),
          border: Border(
            top: BorderSide(color: Colors.white.withOpacity(0.06)),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (selectedImageBytes != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, left: 14),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        selectedImageBytes!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: onRemoveImage,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Row(
              children: [
                IconButton(
                  onPressed: isBusy ? null : onPickImage,
                  icon: const Icon(Icons.image_outlined, color: Colors.white70),
                  tooltip: 'Add image',
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF12171D),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.white.withOpacity(0.06)),
                    ),
                    child: TextField(
                      controller: controller,
                      minLines: 1,
                      maxLines: 5,
                      textInputAction: TextInputAction.newline,
                      style: const TextStyle(fontSize: 15.5),
                      decoration: InputDecoration(
                        hintText: hint,
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => onSend(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FilledButton.icon(
                  onPressed: isBusy ? null : onSend,
                  icon: const Icon(Icons.send_rounded, size: 18),
                  label: const Text('Send'),
                  style: FilledButton.styleFrom(
                    backgroundColor: isBusy ? cs.surfaceVariant : cs.primary,
                    foregroundColor: isBusy
                        ? cs.onSurfaceVariant
                        : cs.onPrimary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    textStyle: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
