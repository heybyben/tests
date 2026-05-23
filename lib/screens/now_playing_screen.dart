import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:just_audio/just_audio.dart';
import '../theme/app_theme.dart';
import '../services/player_provider.dart';

class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Consumer<PlayerProvider>(
        builder: (context, player, _) {
          final song = player.currentSong;

          return SafeArea(
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_down_rounded,
                            size: 30),
                        color: AppTheme.textSecondary,
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      const Text(
                        'Now Playing',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.more_vert_rounded),
                        color: AppTheme.textSecondary,
                        onPressed: () => _showOptions(context),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),

                        // Album art
                        Expanded(
                          flex: 5,
                          child: Center(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.card,
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppTheme.primary.withOpacity(0.15),
                                      blurRadius: 40,
                                      offset: const Offset(0, 20),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: song?.albumArtUrl != null
                                      ? CachedNetworkImage(
                                          imageUrl: song!.albumArtUrl!,
                                          fit: BoxFit.cover,
                                          errorWidget: (_, __, ___) =>
                                              _artPlaceholder(),
                                        )
                                      : _artPlaceholder(),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // Title + favorite
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    song?.title ?? 'Nothing playing',
                                    style: const TextStyle(
                                      color: AppTheme.textPrimary,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    song != null
                                        ? '${song.artist} · ${song.album}'
                                        : '',
                                    style: const TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            IconButton(
                              icon: Icon(
                                song?.isFavorite == true
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: song?.isFavorite == true
                                    ? AppTheme.primary
                                    : AppTheme.textSecondary,
                              ),
                              onPressed: player.toggleFavorite,
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Progress slider
                        Column(
                          children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 3,
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 6),
                                overlayShape: const RoundSliderOverlayShape(
                                    overlayRadius: 14),
                                activeTrackColor: AppTheme.primary,
                                inactiveTrackColor: AppTheme.surfaceVariant,
                                thumbColor: Colors.white,
                              ),
                              child: Slider(
                                value: player.progress.clamp(0.0, 1.0),
                                onChanged: player.seek,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(_fmt(player.position),
                                      style: const TextStyle(
                                          color: AppTheme.textTertiary,
                                          fontSize: 12)),
                                  Text(_fmt(player.duration),
                                      style: const TextStyle(
                                          color: AppTheme.textTertiary,
                                          fontSize: 12)),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Controls
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Shuffle
                            IconButton(
                              icon: Icon(
                                Icons.shuffle_rounded,
                                color: player.shuffle
                                    ? AppTheme.primary
                                    : AppTheme.textSecondary,
                              ),
                              onPressed: player.toggleShuffle,
                            ),
                            // Previous
                            IconButton(
                              icon: const Icon(Icons.skip_previous_rounded,
                                  size: 32, color: AppTheme.textPrimary),
                              onPressed: player.previous,
                            ),
                            // Play/Pause
                            GestureDetector(
                              onTap: player.togglePlay,
                              child: Container(
                                width: 64,
                                height: 64,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  player.isPlaying
                                      ? Icons.pause_rounded
                                      : Icons.play_arrow_rounded,
                                  color: AppTheme.background,
                                  size: 34,
                                ),
                              ),
                            ),
                            // Next
                            IconButton(
                              icon: const Icon(Icons.skip_next_rounded,
                                  size: 32, color: AppTheme.textPrimary),
                              onPressed: player.next,
                            ),
                            // Loop
                            IconButton(
                              icon: Icon(
                                player.loopMode == LoopMode.one
                                    ? Icons.repeat_one_rounded
                                    : Icons.repeat_rounded,
                                color: player.loopMode != LoopMode.off
                                    ? AppTheme.primary
                                    : AppTheme.textSecondary,
                              ),
                              onPressed: player.toggleLoop,
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _artPlaceholder() => Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2D1B4E), Color(0xFF0D0D14)],
          ),
        ),
        child: const Center(
          child: Icon(Icons.album_rounded, color: AppTheme.primary, size: 80),
        ),
      );

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppTheme.border,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            _OptionTile(icon: Icons.playlist_add_rounded, label: 'Add to Playlist'),
            _OptionTile(icon: Icons.share_rounded, label: 'Share'),
            _OptionTile(icon: Icons.info_outline_rounded, label: 'Song Info'),
            _OptionTile(icon: Icons.equalizer_rounded, label: 'Equalizer'),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  const _OptionTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.textSecondary),
      title: Text(label,
          style: const TextStyle(color: AppTheme.textPrimary, fontSize: 15)),
      onTap: () => Navigator.pop(context),
    );
  }
}
