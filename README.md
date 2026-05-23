# Music App

Music player app for Android — dark purple UI, inspired by Aetherfin.

## Screens
- **Home** — greeting, recently played, top mixes
- **Search** — browse genres + your library
- **Now Playing** — album art, controls, progress slider
- **Profile** — account, audio settings, display settings

## Stack
- Flutter 3.19 / Dart 3
- `just_audio` — audio playback
- `audio_service` — lock screen & notification controls
- `provider` — state management
- `cached_network_image` — album art caching

## Getting Started

```bash
# Install dependencies
flutter pub get

# Run on connected device or emulator
flutter run

# Build debug APK
flutter build apk --debug

# Build release APK (split per ABI = smaller file)
flutter build apk --release --split-per-abi
```

## GitHub Actions
Push to `main` and the workflow automatically:
1. Runs `flutter analyze` + `flutter test`
2. Builds debug & release APKs
3. Creates a GitHub Release with the APKs attached

APKs available in **Actions → latest run → Artifacts**.

## Customization

### Change accent color
Edit `lib/theme/app_theme.dart`:
```dart
static const Color primary = Color(0xFF8B5CF6); // change this
```

### Connect to Jellyfin/Navidrome
Add server URL + auth logic in `lib/services/` — the `Song.fromJson` and `Album.fromJson` factories in `lib/models/models.dart` already follow the Jellyfin API shape.

## Project Structure
```
lib/
  main.dart               # Entry point
  theme/
    app_theme.dart        # Colors, typography, component themes
  models/
    models.dart           # Song, Album, Mix, UserProfile
  services/
    player_provider.dart  # Audio playback state (ChangeNotifier)
  screens/
    main_scaffold.dart    # Bottom nav + mini player
    home_screen.dart      # Home tab
    search_screen.dart    # Search + Library tabs
    now_playing_screen.dart
    profile_screen.dart
  widgets/
    mini_player.dart      # Persistent mini player bar
```
