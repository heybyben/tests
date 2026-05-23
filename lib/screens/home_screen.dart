import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import '../models/models.dart';
import '../services/player_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Demo data
  static final List<Song> _recent = [
    Song(
      id: '1', title: 'Midnight Pulse', artist: 'Neon Architect',
      album: 'Dark Sessions', duration: const Duration(minutes: 3, seconds: 42),
      streamUrl: '', albumArtUrl: null,
    ),
    Song(
      id: '2', title: 'Silver Mist', artist: 'Luna Ray',
      album: 'Dreamscape', duration: const Duration(minutes: 4, seconds: 11),
      streamUrl: '', albumArtUrl: null,
    ),
    Song(
      id: '3', title: 'Neon Wave', artist: 'Synthetix',
      album: 'Future Bass', duration: const Duration(minutes: 3, seconds: 58),
      streamUrl: '', albumArtUrl: null,
    ),
  ];

  static final List<Mix> _mixes = [
    Mix(id: 'm1', label: 'DAILY MIX', title: 'Electronic\nFoundations',
        subtitle: 'Aphex Twin, Bicep, Bonobo\nand more', type: MixType.daily),
    Mix(id: 'm2', label: 'CHILL MIX', title: 'Midnight\nJazz',
        subtitle: 'Lo-fi beats to relax', type: MixType.chill),
    Mix(id: 'm3', label: 'FOCUS MIX', title: 'Deep\nLo-Fi',
        subtitle: 'Stay in the zone', type: MixType.focus),
    Mix(id: 'm4', label: 'NEW MIX', title: 'The\nDiscovery',
        subtitle: 'Fresh finds', type: MixType.newMix),
    Mix(id: 'm5', label: 'ENERGY MIX', title: 'Hyper\nPop',
        subtitle: 'High energy bangers', type: MixType.energy),
  ];

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
  }

  String _subgreeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Start your day with music';
    if (h < 17) return 'Keep the vibe going';
    return 'Ready for tonight\'s session?';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              _buildHeader(),
              const SizedBox(height: 28),
              _buildRecentlyPlayed(context),
              const SizedBox(height: 28),
              _buildTopMixes(context),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _greeting(),
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          _subgreeting(),
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildRecentlyPlayed(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recently Played',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'See All',
                style: TextStyle(color: AppTheme.primary, fontSize: 13),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _recent.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, i) => _RecentCard(song: _recent[i]),
          ),
        ),
      ],
    );
  }

  Widget _buildTopMixes(BuildContext context) {
    final featured = _mixes.first;
    final rest = _mixes.sublist(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Top Mixes',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),
        // Featured mix
        _FeaturedMixCard(mix: featured),
        const SizedBox(height: 12),
        // Grid of smaller mixes
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.3,
          ),
          itemCount: rest.length,
          itemBuilder: (context, i) => _SmallMixCard(mix: rest[i]),
        ),
      ],
    );
  }
}

class _RecentCard extends StatelessWidget {
  final Song song;
  const _RecentCard({required this.song});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<PlayerProvider>().playSong(song),
      child: SizedBox(
        width: 110,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: AppTheme.card,
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2D1B4E), Color(0xFF1A0D30)],
                ),
              ),
              child: song.albumArtUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: CachedNetworkImage(
                        imageUrl: song.albumArtUrl!,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) =>
                            const Icon(Icons.music_note_rounded,
                                color: AppTheme.primary, size: 36),
                      ),
                    )
                  : const Icon(Icons.album_rounded,
                      color: AppTheme.primary, size: 40),
            ),
            const SizedBox(height: 8),
            Text(
              song.title,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              song.artist,
              style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedMixCard extends StatelessWidget {
  final Mix mix;
  const _FeaturedMixCard({required this.mix});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border, width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGlow,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    mix.label,
                    style: const TextStyle(
                      color: AppTheme.primaryLight,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  mix.title,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  mix.subtitle,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppTheme.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow_rounded,
                color: Colors.white, size: 26),
          ),
        ],
      ),
    );
  }
}

class _SmallMixCard extends StatelessWidget {
  final Mix mix;
  const _SmallMixCard({required this.mix});

  IconData get _icon {
    switch (mix.type) {
      case MixType.chill: return Icons.graphic_eq_rounded;
      case MixType.focus: return Icons.tune_rounded;
      case MixType.newMix: return Icons.explore_rounded;
      case MixType.energy: return Icons.bolt_rounded;
      default: return Icons.queue_music_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.border, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppTheme.primaryGlow,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              mix.label,
              style: const TextStyle(
                color: AppTheme.primaryLight,
                fontSize: 9,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mix.title,
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 6),
              Icon(_icon, color: AppTheme.primary, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}
