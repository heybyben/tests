import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/mini_player.dart';
import 'home_screen.dart';
import 'search_screen.dart';
import 'profile_screen.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _index = 0;

  static const _screens = [
    HomeScreen(),
    SearchScreen(),
    _QueuePlaceholder(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppTheme.divider, width: 0.5)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const MiniPlayer(),
            BottomNavigationBar(
              currentIndex: _index,
              onTap: (i) => setState(() => _index = i),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_rounded),
                  activeIcon: Icon(Icons.search_rounded),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.queue_music_outlined),
                  activeIcon: Icon(Icons.queue_music_rounded),
                  label: 'Queue',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded),
                  activeIcon: Icon(Icons.person_rounded),
                  label: 'Profile',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QueuePlaceholder extends StatelessWidget {
  const _QueuePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.queue_music_rounded, color: AppTheme.primary, size: 48),
            SizedBox(height: 12),
            Text('Queue', style: TextStyle(color: AppTheme.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text('Nothing in queue yet', style: TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
