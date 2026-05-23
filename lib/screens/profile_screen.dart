import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _dolbyAtmos = true;
  bool _darkMode = true;
  String _streamingQuality = 'High (320kbps)';
  String _downloadQuality = 'Extreme (Lossless)';
  String _themeColor = 'Purple';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 28),
              _buildSection('Account', [
                _RowTile(icon: Icons.person_outline_rounded, label: 'Personal Info',
                    onTap: () {}),
                _RowTile(icon: Icons.security_rounded, label: 'Security',
                    onTap: () {}),
                _RowTile(icon: Icons.card_membership_rounded, label: 'Subscription',
                    trailing: const Text('Yearly',
                        style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
                    onTap: () {}),
              ]),
              const SizedBox(height: 24),
              _buildSection('Audio', [
                _DropdownTile(
                  icon: Icons.graphic_eq_rounded,
                  label: 'Streaming Quality',
                  value: _streamingQuality,
                  options: const ['Low (96kbps)', 'Normal (160kbps)', 'High (320kbps)', 'Extreme (Lossless)'],
                  onChanged: (v) => setState(() => _streamingQuality = v),
                ),
                _DropdownTile(
                  icon: Icons.download_rounded,
                  label: 'Download Quality',
                  value: _downloadQuality,
                  options: const ['Normal (160kbps)', 'High (320kbps)', 'Extreme (Lossless)'],
                  onChanged: (v) => setState(() => _downloadQuality = v),
                ),
                _RowTile(icon: Icons.equalizer_rounded, label: 'Equalizer', onTap: () {}),
                _SwitchTile(
                  icon: Icons.spatial_audio_rounded,
                  label: 'Dolby Atmos',
                  value: _dolbyAtmos,
                  onChanged: (v) => setState(() => _dolbyAtmos = v),
                ),
              ]),
              const SizedBox(height: 24),
              _buildSection('Display', [
                _SwitchTile(
                  icon: Icons.dark_mode_rounded,
                  label: 'Dark Mode',
                  subtitle: 'Always On',
                  value: _darkMode,
                  onChanged: (v) => setState(() => _darkMode = v),
                ),
                _RowTile(
                  icon: Icons.palette_outlined,
                  label: 'Theme Color',
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        margin: const EdgeInsets.only(right: 6),
                        decoration: const BoxDecoration(
                          color: AppTheme.primary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(_themeColor,
                          style: const TextStyle(
                              color: AppTheme.textSecondary, fontSize: 13)),
                    ],
                  ),
                  onTap: () => _showThemePicker(),
                ),
                _RowTile(icon: Icons.apps_rounded, label: 'App Icon', onTap: () {}),
              ]),
              const SizedBox(height: 24),
              _buildSection('About', [
                _RowTile(icon: Icons.info_outline_rounded, label: 'Version', trailing: const Text('1.0.0', style: TextStyle(color: AppTheme.textSecondary, fontSize: 13)), onTap: () {}),
                _RowTile(icon: Icons.bug_report_outlined, label: 'Report a Bug', onTap: () {}),
              ]),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.logout_rounded, color: Color(0xFFEF4444), size: 18),
                  label: const Text('Sign Out',
                      style: TextStyle(color: Color(0xFFEF4444), fontSize: 15)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0x33EF4444)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primary, AppTheme.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.person_rounded, color: Colors.white, size: 32),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.background, width: 2),
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 10),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Alex Rivers',
                    style: TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGlow,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('Premium Member',
                      style: TextStyle(
                          color: AppTheme.primaryLight,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppTheme.textSecondary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: AppTheme.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5)),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.card,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.border, width: 0.5),
            ),
            child: Column(
              children: List.generate(items.length, (i) {
                return Column(
                  children: [
                    items[i],
                    if (i < items.length - 1)
                      const Divider(height: 1, indent: 52),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  void _showThemePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Theme Color',
                style: TextStyle(
                    color: AppTheme.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                _ColorOption(label: 'Purple', color: Color(0xFF8B5CF6)),
                _ColorOption(label: 'Blue', color: Color(0xFF3B82F6)),
                _ColorOption(label: 'Pink', color: Color(0xFFEC4899)),
                _ColorOption(label: 'Green', color: Color(0xFF10B981)),
                _ColorOption(label: 'Orange', color: Color(0xFFF59E0B)),
                _ColorOption(label: 'Red', color: Color(0xFFEF4444)),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _RowTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback onTap;

  const _RowTile({required this.icon, required this.label, this.trailing, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: Icon(icon, color: AppTheme.textSecondary, size: 20),
      title: Text(label,
          style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14)),
      trailing: trailing ??
          const Icon(Icons.chevron_right_rounded,
              color: AppTheme.textTertiary, size: 18),
      onTap: onTap,
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.icon,
    required this.label,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      secondary: Icon(icon, color: AppTheme.textSecondary, size: 20),
      title: Text(label,
          style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14)),
      subtitle: subtitle != null
          ? Text(subtitle!,
              style: const TextStyle(color: AppTheme.textTertiary, fontSize: 12))
          : null,
      value: value,
      activeColor: AppTheme.primary,
      onChanged: onChanged,
    );
  }
}

class _DropdownTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const _DropdownTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: Icon(icon, color: AppTheme.textSecondary, size: 20),
      title: Text(label,
          style: const TextStyle(color: AppTheme.textPrimary, fontSize: 14)),
      subtitle: Text(value,
          style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
      trailing: PopupMenuButton<String>(
        icon: const Icon(Icons.expand_more_rounded,
            color: AppTheme.textTertiary, size: 18),
        color: AppTheme.surfaceVariant,
        itemBuilder: (_) => options
            .map((o) => PopupMenuItem(
                  value: o,
                  child: Text(o,
                      style: TextStyle(
                          color: o == value
                              ? AppTheme.primary
                              : AppTheme.textPrimary,
                          fontSize: 13)),
                ))
            .toList(),
        onSelected: onChanged,
      ),
    );
  }
}

class _ColorOption extends StatelessWidget {
  final String label;
  final Color color;
  const _ColorOption({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Column(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(height: 4),
          Text(label,
              style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
        ],
      ),
    );
  }
}
