import 'dart:ui';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'tokens/colors.dart';
part 'tokens/icon_size.dart';
part 'tokens/extensions.dart';
part 'tokens/radius.dart';
part 'tokens/spacing.dart';
part 'tokens/typography.dart';

class OutsideTheme {
  OutsideTheme._({required ThemeData Function() materialThemeBuilder})
    : _materialThemeBuilder = materialThemeBuilder;

  final ThemeData Function() _materialThemeBuilder;
  ThemeData? _cachedMaterialThemeData;

  ThemeData get materialThemeData =>
      _cachedMaterialThemeData ??= _materialThemeBuilder();
}

class OutsideThemes {
  static OutsideTheme get lightTheme =>
      _buildOutsideTheme(brightness: Brightness.light);

  static OutsideTheme get darkTheme =>
      _buildOutsideTheme(brightness: Brightness.dark);
}

OutsideTheme _buildOutsideTheme({required Brightness brightness}) {
  return OutsideTheme._(
    materialThemeBuilder: () {
      final colorTokens =
          brightness == Brightness.dark
              ? _colorTokens_dark
              : _colorTokens_light;

      final tokenExtensions = _buildThemeTokenExtensions(
        brightness: brightness,
        colorTokens: colorTokens,
      );

      final colorScheme = _buildColorScheme(
        brightness: brightness,
        colorTokens: colorTokens,
      );

      return _buildMaterialThemeData(
        brightness: brightness,
        colorScheme: colorScheme,
        tokens: tokenExtensions,
      );
    },
  );
}

ThemeTokenExtensions _buildThemeTokenExtensions({
  required Brightness brightness,
  required ThemeColorTokens colorTokens,
}) {
  return ThemeTokenExtensions(
    colors: colorTokens,
    iconSize: _iconSizeTokens,
    radius: _radiusTokens,
    spacing: _spacingTokens,
    typography: _buildTypographyTokens(
      brightness: brightness,
      colorTokens: colorTokens,
    ),
  );
}

ColorScheme _buildColorScheme({
  required Brightness brightness,
  required ThemeColorTokens colorTokens,
}) {
  final solid = colorTokens.solidColors;

  final base = ColorScheme.fromSeed(
    seedColor: solid.primary,
    brightness: brightness,
    background: solid.background,
    primary: solid.primary,
  );

  return base.copyWith(
    primary: solid.primary,
    onPrimary: solid.onPrimary,
    secondary: solid.secondary,
    onSecondary: solid.onSecondary,
    error: solid.error,
    onError: solid.onError,
    background: solid.background,
    onBackground: solid.onBackground,
    surface: solid.surface,
    onSurface: solid.onSurface,
    surfaceVariant: solid.surfaceVariant,
    onSurfaceVariant: solid.onSurfaceVariant,
    outline: solid.border,
    outlineVariant: solid.divider,
    surfaceTint: solid.primary,
  );
}

ThemeData _buildMaterialThemeData({
  required Brightness brightness,
  required ColorScheme colorScheme,
  required ThemeTokenExtensions tokens,
}) {
  final solid = tokens.colors.solidColors;
  final typography = tokens.typography;
  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,
    textTheme: typography.textTheme,
    primaryTextTheme: typography.primaryTextTheme,
    scaffoldBackgroundColor: solid.background,
    canvasColor: solid.surface,
    dividerColor: solid.divider,
    extensions: <ThemeExtension<dynamic>>[tokens],
  );

  final buttonTextStyle =
      typography.textTheme.labelLarge ?? typography.textTheme.bodyMedium;

  return base.copyWith(
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: colorScheme.surface,
      foregroundColor: Colors.white,
      titleTextStyle: typography.textTheme.titleLarge?.copyWith(
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: buttonTextStyle,
        foregroundColor: colorScheme.onPrimary,
        backgroundColor: colorScheme.primary,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(textStyle: buttonTextStyle),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: buttonTextStyle,
        side: BorderSide(color: solid.border),
      ),
    ),
    chipTheme: base.chipTheme.copyWith(
      backgroundColor: solid.surfaceVariant,
      selectedColor: colorScheme.primary.withOpacity(0.12),
      secondarySelectedColor: colorScheme.primary.withOpacity(0.12),
      disabledColor: solid.disabled,
      labelStyle: typography.textTheme.labelSmall?.copyWith(
        color: colorScheme.onSurface,
      ),
      secondaryLabelStyle: typography.textTheme.labelSmall?.copyWith(
        color: colorScheme.primary,
      ),
    ),
    inputDecorationTheme: base.inputDecorationTheme.copyWith(
      labelStyle: typography.textTheme.labelMedium,
      hintStyle: typography.textTheme.bodySmall,
      helperStyle: typography.textTheme.bodySmall,
    ),
  );
}
