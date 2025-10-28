import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:google_fonts/google_fonts.dart';

part 'tokens/colors.dart';
part 'tokens/icon_size.dart';
part 'tokens/extensions.dart';
part 'tokens/radius.dart';
part 'tokens/spacing.dart';

class OutsideTheme {
  OutsideTheme({required this.materialThemeData, required this.foruiThemeData});

  final ThemeData materialThemeData;
  final FThemeData foruiThemeData;
}

class OutsideThemes {
  static OutsideTheme get lightTheme => OutsideTheme(
    materialThemeData: _buildMaterialThemeDataLight(),
    foruiThemeData: _foruiThemeData_light,
  );

  static OutsideTheme get darkTheme => OutsideTheme(
    materialThemeData: _buildMaterialThemeDataDark(),
    foruiThemeData: _foruiThemeData_dark,
  );
}

// Build ThemeData lazily to avoid calling GoogleFonts at import time
ThemeData _buildMaterialThemeDataLight() {
  return ThemeData(
    useMaterial3: true,
    extensions: const [_tokenExtensions],
    scaffoldBackgroundColor:
        _foruiThemeData_light.scaffoldStyle.backgroundColor,
    // Primary typography: Poppins for headings (hero/page/section),
    // Inter for body/captions, and Poppins for button labels.
    textTheme: TextTheme(
      // Hero Title
      displayLarge: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
      // Page Title
      headlineSmall: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      // Section Header
      titleLarge: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      // Large Body
      bodyLarge: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w400),
      // Standard Body
      bodyMedium: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400),
      // Small Body
      bodySmall: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),
      // Caption / small label
      labelSmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400),
      // Buttons (use Poppins for emphasis)
      labelLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      // fallback sensible mappings for other slots
      headlineMedium: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      titleMedium: GoogleFonts.poppins(fontWeight: FontWeight.w500),
      titleSmall: GoogleFonts.poppins(fontWeight: FontWeight.w500),
      labelMedium: GoogleFonts.inter(fontWeight: FontWeight.w500),
    ),
  );
}

ThemeData _buildMaterialThemeDataDark() {
  return _buildMaterialThemeDataLight().copyWith(
    extensions: const [_tokenExtensions_dark],
    scaffoldBackgroundColor: _foruiThemeData_dark.scaffoldStyle.backgroundColor,
  );
}

const _tokenExtensions_dark = ThemeTokenExtensions(
  colors: _colorTokens_dark,
  iconSize: _iconSizeTokens,
  radius: _radiusTokens,
  spacing: _spacingTokens,
);

final _foruiThemeData_light = FThemes.zinc.light.copyWith(
  textFieldStyle: FThemes.zinc.light.textFieldStyle.copyWith().call,
);

final _foruiThemeData_dark = FThemes.zinc.dark.copyWith(
  textFieldStyle: FThemes.zinc.dark.textFieldStyle.copyWith().call,
);
