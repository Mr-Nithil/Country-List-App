# Country List App

A Flutter app that fetches countries, shows a list with flags, and displays a
clean detail view with basic stats.

## Tech Stack

- Flutter
- Riverpod (state management)
- HTTP (REST API)

## Architecture

The project follows a simple feature-first, layered structure:

- data: remote datasource, models, repositories
- presentation: screens and viewmodels
- core: shared widgets and error handling

This keeps data access and UI concerns separated while still staying lightweight.

## Setup

1. Install Flutter and Dart.
2. Run `flutter pub get`.
3. Run `dart run build_runner build --delete-conflicting-outputs`.
4. Start the app with `flutter run`.

## What This Demonstrates

- Riverpod async state with repository pattern
- Client-side search on already loaded data
- Simple list/detail navigation
