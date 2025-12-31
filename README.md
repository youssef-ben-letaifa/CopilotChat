<div align="center">

# 🤖 Copilot Chat

### AI-Powered Conversational Assistant with Gemini API

[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Flutter](https://img.shields.io/badge/Flutter-3.0%2B-02569B.svg?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0%2B-0175C2.svg?logo=dart&logoColor=white)](https://dart.dev/)
[![Powered by Gemini](https://img.shields.io/badge/Powered%20by-Gemini%20API-4285F4.svg?logo=google&logoColor=white)](https://ai.google.dev/gemini-api)

**Copilot Chat** is a sophisticated mobile application featuring an AI-powered conversational assistant. Built with Flutter and Dart, it seamlessly integrates with Google's Gemini API to deliver intelligent, context-aware conversations with modern UI/UX design optimized for both Android and iOS platforms.

[Features](#-features) • [Installation](#-installation) • [Usage](#️-usage)  • [Contributing](#-contributing)

<img src="https://user-images.githubusercontent.com/74038190/212284100-561aa473-3905-4a80-b561-0d28506553ee.gif" width="100%">

</div>

---

## ✨ Features

### 🧠 Intelligent Conversations

Advanced AI-powered chat system utilizing **Google Gemini API** for natural language understanding:

**Core Capabilities:**
- **Multi-turn Dialogues**: Maintains conversation context across multiple exchanges
- **Fast Response Time**: Real-time processing with minimal latency
- **Contextual Understanding**: Remembers previous messages for coherent conversations
- **Natural Language**: Human-like responses with proper grammar and tone
- **Smart Suggestions**: Provides relevant follow-up questions

**Benefits:**
- Seamless conversation flow
- Accurate context retention
- Relevant and helpful responses
- Adaptive to user's communication style

### 🎨 Modern User Interface

Professional mobile-first design following Material Design 3 principles:

#### Cross-Platform Excellence
- **Android Support**: Material Design components with native Android feel
- **iOS Compatibility**: Cupertino widgets for authentic iOS experience
- **Responsive Layout**: Adapts to different screen sizes and orientations
- **Smooth Animations**: 60+ FPS fluid transitions and interactions

#### Visual Features
- **Dark & Light Themes**: System-adaptive or manual theme selection
- **Custom Typography**: Readable fonts optimized for mobile screens
- **Color Schemes**: Professionally designed color palettes
- **Touch Optimization**: Large tap targets and gesture-friendly interface

#### Professional Design Elements
- **Chat Bubbles**: Distinct user and AI message styles
- **Loading Indicators**: Elegant animations during API calls
- **Message Actions**: Copy, share, and delete functionality
- **Smooth Scrolling**: Optimized chat list performance

### 🖼️ Multimodal Support

Comprehensive input options for enhanced user experience:

- **Text Input**: Multi-line text field with character counter
- **Image Upload**: 
  - Camera integration for instant photo capture
  - Gallery access for existing images
  - Image preview before sending
  - AI image analysis with Gemini Vision
- **Voice Input**: (Optional) Speech-to-text integration
- **File Attachments**: (Optional) Document support

### 📱 Mobile-First Features

Optimized specifically for mobile devices:

- **Offline Mode**: Cache conversations for offline viewing
- **Push Notifications**: Real-time alerts for responses
- **Biometric Security**: Fingerprint/Face ID protection
- **Auto-save**: Automatic conversation backup
- **Search Function**: Find previous messages quickly
- **Export Options**: Share or export chat history

### 🔒 Security & Privacy

Built with privacy and security as core principles:

- **Encrypted Communication**: Secure HTTPS API calls
- **Local Data Protection**: Encrypted local storage
- **No Tracking**: Privacy-first approach with no analytics
- **Secure API Keys**: Environment-based key management
- **Session Management**: Automatic logout and data clearing
- **Permission Controls**: Minimal required permissions

### ⚡ Performance Optimization

Engineered for speed and efficiency:

- **Lazy Loading**: Load messages on-demand for better performance
- **Image Caching**: Efficient image storage and retrieval
- **Memory Management**: Optimized resource usage
- **Fast Startup**: Quick app launch time
- **Smooth Scrolling**: Optimized list rendering
- **Battery Efficient**: Minimal background processing

---

## 🛠️ Technology Stack

<div align="center">

### Core Technologies

<p>
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/flutter/flutter-original.svg" alt="Flutter" width="60" height="60"/>
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/dart/dart-original.svg" alt="Dart" width="60" height="60"/>
  <img src="https://www.gstatic.com/lamda/images/gemini_sparkle_v002_d4735304ff6292a690345.svg" alt="Gemini" width="60" height="60"/>
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/materialui/materialui-original.svg" alt="Material" width="60" height="60"/>
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/android/android-original.svg" alt="Android" width="60" height="60"/>
  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/apple/apple-original.svg" alt="iOS" width="60" height="60"/>
</p>

</div>

| Component | Technology | Purpose |
|-----------|-----------|---------|
| **Framework** | Flutter 3.0+ | Cross-platform UI development |
| **Language** | Dart 3.0+ | Application programming language |
| **AI Engine** | Gemini API | Natural language processing |
| **State Management** | Provider/Riverpod/BLoC | App state handling |
| **Storage** | SharedPreferences/Hive | Local data persistence |
| **Networking** | HTTP/Dio | API communication |
| **Image Handling** | ImagePicker | Camera and gallery access |

---

## 📦 Installation

### Prerequisites

Ensure you have the following installed:

- **Flutter SDK 3.0 or higher** ([Download](https://flutter.dev/docs/get-started/install))
- **Dart SDK 3.0+** (Included with Flutter)
- **Android Studio or Xcode** (For platform-specific development)
- **Gemini API Key** ([Get API Key](https://ai.google.dev/gemini-api/docs/api-key))

### Step-by-Step Installation

1. **Clone the Repository**
```bash
   git clone https://github.com/youssef-ben-letaifa/copilot-chat-dart.git
   cd copilot-chat-dart
```

2. **Install Flutter Dependencies**
```bash
   flutter pub get
```

3. **Setup Environment Variables**

   Create a `.env` file in the root directory:
```env
   GEMINI_API_KEY=your_api_key_here
```

   Add to `pubspec.yaml`:
```yaml
   flutter:
     assets:
       - .env
```

4. **Verify Installation**
```bash
   flutter doctor
   flutter devices
```

5. **Platform-Specific Setup**

   **For Android:**
```bash
   cd android
   ./gradlew clean
   cd ..
```

   **For iOS:**
```bash
   cd ios
   pod install
   cd ..
```

---

## 🖥️ Usage

### Starting the Application

Run the application on your preferred platform:
```bash
flutter run
```

### First Launch

1. **Splash Screen**: Displays app logo and initializes components
2. **API Verification**: Validates Gemini API key configuration
3. **Permission Requests**: Camera and storage permissions if needed
4. **Welcome Tutorial**: Brief introduction to app features

### Navigation

**Main Features:**
- **Chat Interface**: Primary conversation screen
- **Image Upload**: Tap camera icon to add images
- **Message Actions**: Long-press messages for options
- **Settings**: Access app preferences and configurations

**Gestures:**
- **Swipe Right**: Return to previous screen
- **Long Press**: Show message options menu
- **Pull to Refresh**: Reload conversation
- **Double Tap**: Quick actions

### Configuration

Edit `lib/config/app_config.dart`:
```dart
class AppConfig {
  static const String apiEndpoint = 'https://generativelanguage.googleapis.com';
  static const String geminiModel = 'gemini-pro';
  static const int maxTokens = 2048;
  static const double temperature = 0.7;
}
```


---

## 🎯 Roadmap

- [x] Basic chat functionality
- [x] Gemini API integration
- [x] Image input support
- [x] Dark/Light themes
- [x] Cross-platform support
- [ ] Voice input/output
- [ ] Multi-language support (Arabic, French, English)
- [ ] Chat export functionality
- [ ] Conversation categorization
- [ ] Custom AI personalities
- [ ] Offline mode with caching
- [ ] Cloud synchronization
- [ ] Widget support
- [ ] Advanced formatting (tables, code blocks)
- [ ] Plugin system

---

## 🔧 Configuration

### API Settings

Update `.env` file:
```env
GEMINI_API_KEY=your_api_key_here
GEMINI_MODEL=gemini-pro
GEMINI_VISION_MODEL=gemini-pro-vision
MAX_TOKENS=2048
TEMPERATURE=0.7
```

### Theme Customization

Modify `lib/config/theme_config.dart`:
```dart
static ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.light,
  ),
);
```

### State Management

Configure provider in `lib/main.dart`:
```dart
MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (_) => ChatProvider()),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ],
  child: MyApp(),
);
```

---

## 🐛 Troubleshooting

### Common Issues

**Flutter Doctor Issues:**
```bash
flutter doctor -v
flutter clean
flutter pub get
```

**API Key Not Working:**
```bash
# Verify .env file exists and contains correct key
cat .env

# Reload environment variables
flutter run --dart-define=GEMINI_API_KEY=your_key
```

**Build Errors:**
```bash
# Android
cd android && ./gradlew clean && cd ..
flutter build apk

# iOS
cd ios && pod install && cd ..
flutter build ios
```

**Performance Issues:**
- Enable release mode: `flutter run --release`
- Reduce image quality before uploading
- Clear app cache and rebuild
- Check device specifications

---

## 🤝 Contributing

We welcome contributions from the community! Here's how you can help:

### How to Contribute

1. **Fork the Repository**
```bash
   git clone https://github.com/youssef-ben-letaifa/copilot-chat-dart.git
```

2. **Create Feature Branch**
```bash
   git checkout -b feature/YourFeatureName
```

3. **Make Your Changes**
   - Follow Dart style guidelines
   - Add comments for complex logic
   - Update documentation

4. **Test Your Changes**
```bash
   flutter test
   flutter analyze
   dart format lib/
```

5. **Commit and Push**
```bash
   git commit -m "feat: Add your feature description"
   git push origin feature/YourFeatureName
```

6. **Create Pull Request**

### Development Guidelines

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) style guide
- Write unit tests for new features
- Update documentation as needed
- Maintain code consistency
- Test on both Android and iOS

### Areas for Contribution

- 🐛 Bug fixes
- ✨ New features
- 📝 Documentation improvements
- 🌍 Translations
- 🎨 UI/UX enhancements
- ⚡ Performance optimizations

---

## 📜 License

MIT License

Copyright (c) 2025 Youssef BEN LETAIFA

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

---

## 👨‍💻 Author

**Youssef BEN LETAIFA**

- GitHub: [@youssef-ben-letaifa](https://github.com/youssef-ben-letaifa)
- LinkedIn: [Youssef Ben Letaifa](https://www.linkedin.com/in/youssefbenletaifa/)
- Portfolio: [youssef-ben-letaifa.github.io](https://youssef-ben-letaifa.github.io/ben.letaifa.youssef/)
- Email: youssef.benletaifa@intek.u-jendouba.tn

---


## ⚠️ Disclaimer

This application is designed for **educational and demonstration purposes**. While it integrates with production APIs, users should:

- Review and comply with Gemini API Terms of Service
- Implement appropriate rate limiting for production use
- Handle sensitive data according to privacy regulations
- Monitor API usage and associated costs

Always test thoroughly before deploying to production environments.

---

<div align="center">

### 💙 If you find this project useful, please give it a ⭐!

**Built with Flutter for the Mobile-First Future**

![GitHub stars](https://img.shields.io/github/stars/youssef-ben-letaifa/copilot-chat-dart?style=social)
![GitHub forks](https://img.shields.io/github/forks/youssef-ben-letaifa/copilot-chat-dart?style=social)
![GitHub watchers](https://img.shields.io/github/watchers/youssef-ben-letaifa/copilot-chat-dart?style=social)

**Version 1.0.0** | Last Updated: December 2025

</div>
