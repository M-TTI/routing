# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Routing is a Flutter application for managing osu! skins. It uses Drift (SQLite) for local database storage and targets desktop (Linux and Windows) platforms.

The project has an associated Lunacy design file at `~/dev/routing/Design.free` (ZIP archive containing JSON) that defines the UI components and color palette.

## Common Commands

```bash
# Run the app
flutter run -d linux

# Analyze code
flutter analyze

# Install dependencies
flutter pub get

# Regenerate Drift database code after modifying table definitions in lib/databases/database.dart
dart run build_runner build
```

## Architecture — MVVM

The app follows MVVM with the `provider` package for dependency injection.

- **lib/main.dart** — App entry point; initializes `SettingsService`, `AppDataBase`, `SettingsViewModel`, `HomeViewModel` and provides them via `MultiProvider`
- **lib/themes/theme.dart** — Color constants, icon constants, button styles, and `buildTheme()` for light/dark themes
- **lib/databases/database.dart** — Drift database with `Skins` table. Generated code in `database.g.dart` (do not edit manually)
- **lib/viewmodels/home_viewmodel.dart** — Owns menu state, skin list stream, `importFiles()`, `openWithOsu()`, `openAllWithOsu()`, `deleteSkin()`, `downloadSkin()`
- **lib/viewmodels/settings_viewmodel.dart** — Owns theme mode and osu path; reads/writes via `SettingsService`
- **lib/services/skin_service.dart** — `SkinService` — all skin file operations: import, extract, preview generation, open, download, delete
- **lib/services/settings_service.dart** — `SettingsService` — wraps `SharedPreferences` for persistent settings
- **lib/pages/home_page.dart** — `HomePage` (StatefulWidget); responsive layout (breakpoint: width < 600 = `isSmall`); checks `osuPathConfigured` on first frame
- **lib/pages/dialogs/settings_dialog.dart** — Settings dialog (theme mode dropdown + osu path field with browse button)
- **lib/pages/dialogs/osu_path_dialog.dart** — Startup dialog shown when osu path is not configured
- **lib/components/nav_bar.dart** — `NavBar(title, isSmall)` — top bar with theme toggle, "Add a skin", and "Menu" buttons
- **lib/components/side_menu.dart** — Slide-in menu with "Add a skin", "Open all with Osu!", and "Settings" buttons
- **lib/components/base_button.dart** — `BaseButton(icon, label?, onPressed)` — wraps `FilledButton`; icon-only when `label` is null
- **lib/components/skin_card.dart** — `SkinCard(skin, isSmall)` — card showing skin preview image + open/download/delete buttons; 160×240 (small) or 280×400 (large)
- **lib/components/skeleton_card.dart** — `SkeletonCard(isSmall)` — loading placeholder matching `SkinCard` dimensions

## Key Dependencies

- **drift** + **sqlite3_flutter_libs** — Local SQLite database with type-safe queries
- **provider** — MVVM dependency injection
- **shared_preferences** — Persistent key-value settings storage
- **file_picker** — File/directory selection dialogs
- **path_provider** — Platform-specific app support/temp directory access
- **path** — Path manipulation utilities
- **archive** — ZIP extraction for `.osk`/`.zip` skin files
- **local_notifier** — Native OS notification tray notifications (platform API feature)

## Linux System Requirements

The following packages must be installed to build on Linux (Fedora):
```bash
sudo dnf install libnotify libnotify-devel
```
`libnotify-devel` is required to compile `local_notifier`.

## Design System Colors

Defined in `lib/themes/theme.dart`:

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
- `assetsPath` (text — path to `{id}/` skin folder in app support dir)
- `size` (real — archive size in MB)

After changing table definitions, regenerate with `dart run build_runner build`.

## Skin Storage Structure

Each imported skin is stored under `{appSupportDir}/{id}/`:
```
{id}/
├── archive.osk       ← original skin archive
├── preview.png       ← generated composite preview (260×260)
└── sm_preview.png    ← generated composite preview (140×140)
```

Extracted assets are deleted after import — only the archive and previews are kept.

## Skin Import Flow

Implemented in `lib/services/skin_service.dart`:

1. User selects one or more `.osk`/`.zip` archives via file picker
2. Archive is copied to `tmpRoutingDir` (temp directory)
3. Archive is extracted to a per-file sub-directory
4. `skin.ini` is parsed to validate the skin and extract: `name`, `author`, `HitCirclePrefix`, `ComboPrefix`
5. Preview images are generated by compositing `hitcircle`, `hitcircleoverlay`, and the number `1` image (using `HitCirclePrefix`, falling back to `ComboPrefix` if no number files found)
6. `archive.osk`, `preview.png`, and `sm_preview.png` are saved to the final skin folder
7. Metadata saved to the `Skins` database table
8. `tmpRoutingDir` is cleaned up
9. Success/failure notification shown via `local_notifier`

## Settings

Stored via `SharedPreferences`:
- `osu_path` (String) — path to osu! executable; required to open skins
- `theme_mode` (int) — `0`=system, `1`=light, `2`=dark

On first launch, if `osu_path` is not set, `OsuPathDialog` is shown automatically.

osu! on Linux is typically an AppImage whose filename changes on updates — the app warns the user about this in the path text field.

## Workflow Preferences

- **Never edit files without explicit permission.** When asked about code changes, show what to change and explain it. Only apply edits when the user explicitly asks you to make the change.
