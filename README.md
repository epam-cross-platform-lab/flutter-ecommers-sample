# ecommers Flutter App

## About

This repository serves the source code for the Ecommers sample mobile app for iOS and Android.

## Getting Started

1. Ensure Flutter SDK is installed correctly, ``flutter doctor``
2. Fetch dependent Dart/Flutter packages, ``flutter pub get``
3. Due to we use compile-time JSON serialization and API client *code generation*, run ``flutter packages pub run build_runner build --delete-conflicting-outputs`` which recreates all necessary files
4. Install https://marketplace.visualstudio.com/items?itemName=esskar.vscode-flutter-i18n-json extension for updating json strings
