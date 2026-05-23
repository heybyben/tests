import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../services/player_provider.dart';
import '../theme/app_theme.dart';
import '../screens/now_playing_screen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(
      builder: (context, player, _) {
        final song = player.currentSong;
        if (song == null) return const SizedBox.shrink();

        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (_, a, __) => const NowPlayingScreen(),
              transitionsBuilder: (_, anim, __, child) => SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
                child: child,
              ),
            ),
          ),
          child: Container(
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.surfaceVariant,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.border, width: 0.5),
            ),
            child: Stack(
              children: [
                // Progress bar at bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: LinearProgressIndicator(
                      value: player.progress,
                      backgroundColor: Colors.transparent,
                      valueColor: const AlwaysStoppedAnimation(AppTheme.primary),
                      minHeight: 2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      // Album art
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: song.albumArtUrl != null
                            ? CachedNetworkImage(
                                imageUrl: song.albumArtUrl!,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                                errorWidget: (_, __, ___) => _placeholder(),
                              )
                            : _placeholder(),
                      ),
                      const SizedBox(width: 12),
                      // Title / artist
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              song.title,
                              style: const TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              song.artist,
                              style: const TextStyle(
                                color: AppTheme.textSecondary,
                                fontSize: 11,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      // Controls
                      IconButton(
                        icon: const Icon(Icons.skip_previous_rounded),
                        iconSize: 22,
                        color: AppTheme.textSecondary,
                        onPressed: player.previous,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                      ),
                      IconButton(
                        icon: Icon(
                          player.isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                        ),
                        iconSize: 26,
                        color: AppTheme.textPrimary,
                        onPressed: player.togglePlay,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                      ),
                      IconButton(
                        icon: const Icon(Icons.skip_next_rounded),
                        iconSize: 22,
                        color: AppTheme.textSecondary,
                        onPressed: player.next,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _placeholder() => Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.card,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.music_note_rounded, color: AppTheme.primary, size: 20),
      );
}
