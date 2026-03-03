# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Routing is a Flutter application for managing osu! skins. It uses Drift (SQLite) for local database storage and targets desktop (Linux, Windows, macOS) and mobile (Android, iOS) platforms.

The project has an associated Lunacy design file at `~/dev/routing/Design.free` (ZIP archive containing JSON) that defines the UI components and color palette.

## Common Commands

```bash
# Run the app
flutter run

# Run on specific platform
flutter run -d linux
flutter run -d chrome

# Run tests
flutter test
flutter test test/widget_test.dart    # single test file

# Analyze code
flutter analyze

# Install dependencies
flutter pub get

# Regenerate Drift database code after modifying table definitions in lib/databases/database.dart
dart run build_runner build
```

## Architecture

- **lib/main.dart** — App entry point and root widget
- **lib/themes/theme.dart** — Color constants, button styles, and `buildTheme()` for light/dark themes
- **lib/databases/database.dart** — Drift database definition with `Skins` table schema and `AppDataBase` class containing query methods. Generated code lives in `database.g.dart` (do not edit manually)
- **lib/components/** — Reusable UI widgets (e.g., `NavBar`)

## Key Dependencies

- **drift** + **sqlite3_flutter_libs** — Local SQLite database with type-safe queries
- **file_picker** — File selection dialogs (for importing skins)
- **path_provider** — Platform-specific document directory access

## Design System Colors

Defined in `lib/themes/theme.dart`. Colors used on actual components:

| Constant | Hex | Usage |
|----------|-----|-------|
| `pink` | `#FF2E7E` | Buttons/CTA |
| `pinkHover` | `#E02870` | Button hover |
| `pinkPressed` | `#FF6BA3` | Button pressed |
| `lightPrimary` | `#F5CEDB` | Cards, NavBar, surfaces (light) |
| `darkPrimary` | `#433D56` | Cards, NavBar, surfaces (dark) |
| `error` | `#E12D39` | Error states |
| `skeleton` | `#C7B9B9` | Skeleton loading (light) |
| `skeletonDark` | `#524A5C` | Skeleton loading (dark) |
| `placeholder` | `#969286` | Image placeholders |
| `shadow` | `#40000000` | Drop shadows (25% black) |

Font: **Inter** (Bold and Regular weights)

## Database Schema

The `Skins` table stores imported skin metadata:
- `id` (int, auto-increment PK)
- `name`, `author` (text)
- `assetsPath` (text — filesystem path to skin assets)
- `size` (real — file size)

After changing table definitions, regenerate with `dart run build_runner build`.
