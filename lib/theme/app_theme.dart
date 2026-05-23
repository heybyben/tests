import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color background = Color(0xFF0D0D14);
  static const Color surface = Color(0xFF16161F);
  static const Color surfaceVariant = Color(0xFF1E1E2A);
  static const Color card = Color(0xFF1A1A26);
  static const Color cardDark = Color(0xFF13131C);

  static const Color primary = Color(0xFF8B5CF6);
  static const Color primaryLight = Color(0xFFA78BFA);
  static const Color primaryDark = Color(0xFF6D28D9);
  static const Color primaryGlow = Color(0x338B5CF6);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textTertiary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF4B5563);

  static const Color divider = Color(0xFF1F1F2E);
  static const Color border = Color(0xFF2A2A3A);

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(
        background: background,
        surface: surface,
        primary: primary,
        secondary: primaryLight,
        onBackground: textPrimary,
        onSurface: textPrimary,
        onPrimary: textPrimary,
      ),
      textTheme: GoogleFonts.interTextTheme(
        const TextTheme(
          displayLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold, fontSize: 24),
          headlineMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.w600, fontSize: 20),
          headlineSmall: TextStyle(color: textPrimary, fontWeight: FontWeight.w600, fontSize: 18),
          titleLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.w600, fontSize: 16),
          titleMedium: TextStyle(color: textPrimary, fontWeight: FontWeight.w500, fontSize: 14),
          titleSmall: TextStyle(color: textSecondary, fontWeight: FontWeight.w500, fontSize: 13),
          bodyLarge: TextStyle(color: textPrimary, fontSize: 16),
          bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
          bodySmall: TextStyle(color: textTertiary, fontSize: 12),
          labelLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.w600, fontSize: 14),
          labelMedium: TextStyle(color: textSecondary, fontSize: 12),
          labelSmall: TextStyle(color: textTertiary, fontSize: 11),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: surface,
        selectedItemColor: primary,
        unselectedItemColor: textTertiary,
        type: BottomNavigationBarType.fixed,
        showLabels: false,
        elevation: 0,
      ),
      cardTheme: const CardTheme(
        color: card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: primary,
        inactiveTrackColor: surfaceVariant,
        thumbColor: Colors.white,
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
        trackHeight: 3,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((s) =>
            s.contains(MaterialState.selected) ? Colors.white : textTertiary),
        trackColor: MaterialStateProperty.resolveWith((s) =>
            s.contains(MaterialState.selected) ? primary : surfaceVariant),
      ),
      dividerTheme: const DividerThemeData(
        color: divider,
        thickness: 1,
        space: 0,
      ),
      iconTheme: const IconThemeData(color: textSecondary, size: 22),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: textTertiary, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        prefixIconColor: textTertiary,
      ),
    );
  }
}
