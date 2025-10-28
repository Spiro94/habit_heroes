part of '../theme.dart';

extension ThemeTokensBuildContext on BuildContext {
  ThemeTokenExtensions get tokens =>
      Theme.of(this).extension<ThemeTokenExtensions>()!;

  ThemeColorTokens get colors => tokens.colors;

  AppSolidColors get solidColors => tokens.colors.solidColors;

  ThemeTypographyTokens get typography => tokens.typography;
}

class ThemeTokenExtensions extends ThemeExtension<ThemeTokenExtensions>
    with EquatableMixin {
  const ThemeTokenExtensions({
    required this.colors,
    required this.iconSize,
    required this.radius,
    required this.spacing,
    required this.typography,
  });

  final ThemeColorTokens colors;
  final ThemeIconSizeTokens iconSize;
  final ThemeRadiusTokens radius;
  final ThemeSpacingTokens spacing;
  final ThemeTypographyTokens typography;

  @override
  ThemeExtension<ThemeTokenExtensions> copyWith({
    ThemeColorTokens? colors,
    ThemeIconSizeTokens? iconSize,
    ThemeRadiusTokens? radius,
    ThemeSpacingTokens? spacing,
    ThemeTypographyTokens? typography,
  }) {
    return ThemeTokenExtensions(
      colors: colors ?? this.colors,
      iconSize: iconSize ?? this.iconSize,
      radius: radius ?? this.radius,
      spacing: spacing ?? this.spacing,
      typography: typography ?? this.typography,
    );
  }

  @override
  ThemeExtension<ThemeTokenExtensions> lerp(
    covariant ThemeExtension<ThemeTokenExtensions>? other,
    double t,
  ) {
    if (other is! ThemeTokenExtensions) return this;
    return ThemeTokenExtensions(
      colors: colors.lerp(other.colors, t) as ThemeColorTokens,
      iconSize: iconSize.lerp(other.iconSize, t),
      radius: radius.lerp(other.radius, t),
      spacing: spacing.lerp(other.spacing, t),
      typography: typography.lerp(other.typography, t),
    );
  }

  @override
  List<Object?> get props => [colors, iconSize, radius, spacing, typography];
}
