# Copilot Chat (Dart/Flutter + Gemini API)

[![GitHub license](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Built with Dart](https://img.shields.io/badge/Built%20with-Dart-0175C2.svg)](https://dart.dev/)
[![Powered by Gemini](https://img.shields.io/badge/Powered%20by-Gemini%20API-4285F4.svg)](https://ai.google.dev/gemini-api)

A mobile application prototype of an AI-powered conversational assistant, built using **Dart/Flutter**. This project focuses on modern UI/UX design and demonstrates seamless integration with the **Gemini API** for advanced, multi-turn chat capabilities.

---

## Features

* **Intelligent Chat:** Utilizes the **Gemini API** for fast, relevant, and contextual responses.
* **Modern Interface:** A clean, intuitive, and modern UI/UX designed with mobile best practices.
* **Mobile-First Design:** Optimized for a smooth experience on both Android and iOS devices.
* **Multimodal Ready:** (If applicable, based on your implementation) Designed to handle and process both text and image input.
* **State Management:** (Optional: Add your specific state management, e.g., Provider, Riverpod, BLoC).

## Getting Started

Follow these steps to set up the project locally on your machine.

### Prerequisites

You will need the following installed:

* **Flutter SDK:** [Installation Guide](https://flutter.dev/docs/get-started/install)
* **Dart SDK:** (Included with Flutter)
* **Gemini API Key:** Get your key from [Google AI Studio](https://ai.google.dev/gemini-api/docs/api-key).

### Installation

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/YourUsername/copilot-chat-dart.git](https://github.com/YourUsername/copilot-chat-dart.git)
    cd copilot-chat-dart
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Set up your API Key:**
    Create a file named `.env` in the root directory (or use a secure method like build environments) and add your Gemini API key:

    **.env**
    ```
    GEMINI_API_KEY="YOUR_API_KEY_HERE"
    ```
    *(Note: Ensure this file is added to your `.gitignore` to prevent committing your secret key.)*

4.  **Run the app:**
    ```bash
    flutter run
    ```

## Built With

* **Dart:** The fast, object-oriented language for Flutter.
* **Flutter:** Google's UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
* **Gemini API:** Used for powering the conversational AI capabilities of the chat agent.
* **Package Name** (e.g., `google_generative_ai`): The specific Dart package used for the API.

##  Contributing

This project is primarily a learning exercise. However, suggestions for improvements, especially around best practices for Dart/Flutter or API integration, are welcome!

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'feat: Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.

##  Contact

Youssef Ben Letaifa  | youssef.benletaifa@intek.u-jendouba.tn

 Link: [[https://github.com/YourUsername/copilot-chat-dart](https://github.com/YourUsername/copilot-chat-dart](https://youssef-ben-letaifa.github.io/ben.letaifa.youssef/#contact))

---

## Acknowledgements

* [Flutter Documentation](https://flutter.dev/docs)
* [Gemini API Documentation](https://ai.google.dev/gemini-api/docs)
* [Google Antigravity](https://ai.google.dev/antigravity) (The tool used for advanced development/analysis during the prototype phase)
