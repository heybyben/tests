import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  final _searchController = TextEditingController();
  bool _searching = false;

  static const _genres = [
    _Genre('Pop', Color(0xFF9B2335)),
    _Genre('Hip-Hop', Color(0xFF1A1A1A)),
    _Genre('Rock', Color(0xFF2C3E50)),
    _Genre('Electronic', Color(0xFF1B2A4A)),
    _Genre('Jazz', Color(0xFF3D2B1F)),
    _Genre('R&B', Color(0xFF2D1B4E)),
    _Genre('Classical', Color(0xFF1A2F1A)),
    _Genre('Metal', Color(0xFF1C1C1C)),
  ];

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TabBar(
                controller: _tab,
                isScrollable: false,
                labelColor: AppTheme.textPrimary,
                unselectedLabelColor: AppTheme.textTertiary,
                labelStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                indicator: const UnderlineTabIndicator(
                  borderSide: BorderSide(color: AppTheme.primary, width: 3),
                  insets: EdgeInsets.symmetric(horizontal: 0),
                ),
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: 'Search'),
                  Tab(text: 'Your Library'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tab,
                children: [
                  _SearchTab(
                    controller: _searchController,
                    genres: _genres,
                    searching: _searching,
                    onSearchChanged: (v) =>
                        setState(() => _searching = v.isNotEmpty),
                  ),
                  const _LibraryTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchTab extends StatelessWidget {
  final TextEditingController controller;
  final List<_Genre> genres;
  final bool searching;
  final ValueChanged<String> onSearchChanged;

  const _SearchTab({
    required this.controller,
    required this.genres,
    required this.searching,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // Search bar
          TextField(
            controller: controller,
            onChanged: onSearchChanged,
            style: const TextStyle(color: AppTheme.textPrimary),
            decoration: InputDecoration(
              hintText: 'Artists, songs, or podcasts',
              prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.textTertiary),
              suffixIcon: searching
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded,
                          color: AppTheme.textTertiary),
                      onPressed: () {
                        controller.clear();
                        onSearchChanged('');
                      },
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Browse All',
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.55,
            ),
            itemCount: genres.length,
            itemBuilder: (_, i) => _GenreCard(genre: genres[i]),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

class _GenreCard extends StatelessWidget {
  final _Genre genre;
  const _GenreCard({required this.genre});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: genre.color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Decorative element
            Positioned(
              right: -10,
              bottom: -10,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                genre.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LibraryTab extends StatelessWidget {
  const _LibraryTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _sectionHeader('Playlists'),
          ..._demoPlaylists(),
          const SizedBox(height: 20),
          _sectionHeader('Albums'),
          ..._demoAlbums(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Text(
          title,
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  List<Widget> _demoPlaylists() => [
        'Liked Songs', 'Late Night Drive', 'Workout Bangers', 'Deep Focus'
      ].map((name) => _LibraryItem(title: name, subtitle: 'Playlist', icon: Icons.queue_music_rounded)).toList();

  List<Widget> _demoAlbums() => [
        'Dark Sessions', 'Dreamscape', 'Future Bass',
      ].map((name) => _LibraryItem(title: name, subtitle: 'Album', icon: Icons.album_rounded)).toList();
}

class _LibraryItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const _LibraryItem({required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppTheme.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.border, width: 0.5),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppTheme.primaryGlow,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppTheme.primary, size: 22),
        ),
        title: Text(title,
            style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle,
            style: const TextStyle(
                color: AppTheme.textSecondary, fontSize: 12)),
        trailing: const Icon(Icons.chevron_right_rounded,
            color: AppTheme.textTertiary, size: 18),
        onTap: () {},
      ),
    );
  }
}

class _Genre {
  final String name;
  final Color color;
  const _Genre(this.name, this.color);
}
