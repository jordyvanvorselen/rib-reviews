# Rib Reviews Frontend

This Flutter mobile app uses the Next.js backend from the `../backend` folder.

## Getting Started

To contribute to this Flutter app, I recommend installing either [Visual Studio Code](https://code.visualstudio.com/) with the [Flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter) and [Dart](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code) plugins, or installing `Android Studio`.

### Prerequisites

To set up this project you will need Flutter `3.10.1`. You can follow the install instructions found [here](https://docs.flutter.dev/get-started/install).

You can also use `asdf` for `flutter` and `java`:

```sh
asdf plugin add flutter
asdf plugin add java

asdf install
```

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/jordyvanvorselen/rib-reviews.git
   ```
2. Change into the frontend directory
   ```sh
   cd frontend
   ```
3. Install the dependencies
   ```sh
   flutter pub get
   ```
4. Copy the `env.example` file
   ```sh
   cp env.example .env
   ```
5. Fill in the secrets
   ```
   If you are using the android emulator, make sure to use `10.0.2.2:3000` instead of `localhost:3000` to connect to the backend.
   ```
6. Run the code generator to generate the secret constants
   ```sh
   flutter pub run build_runner build
   ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Running the project

1. Install chromedriver and add it to your PATH
   ```sh
   yay chromedriver
   ```
2. Run chromedriver on port 4444
   ```sh
   chromedriver --port=4444
   ```
2. Run the following command
   ```sh
   flutter run --debug
   ```

### Running the tests

1. Run the following command
   ```sh
   flutter drive --driver=test_driver/integration_test.dart --target=integration_test/main.dart -d chrome
   ```

<!-- ROADMAP -->

## Learn more about Flutter

To learn more about Flutter, take a look at the following resources:

- [Flutter Documentation](https://docs.flutter.dev/) - learn about Flutter features and API.
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

You can check out [the Flutter GitHub repository](https://github.com/flutter/flutter).

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
