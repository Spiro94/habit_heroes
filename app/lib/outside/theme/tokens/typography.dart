part of '../theme.dart';

class ThemeTypographyTokens extends ThemeExtension<ThemeTypographyTokens>
    with EquatableMixin {
  const ThemeTypographyTokens({
    required this.textTheme,
    required this.primaryTextTheme,
  });

  final TextTheme textTheme;
  final TextTheme primaryTextTheme;

  TextStyle? get hero => textTheme.displayLarge;
  TextStyle? get pageTitle => textTheme.headlineSmall;
  TextStyle? get sectionHeader => textTheme.titleLarge;
  TextStyle? get bodyLarge => textTheme.bodyLarge;
  TextStyle? get body => textTheme.bodyMedium;
  TextStyle? get bodySmall => textTheme.bodySmall;
  TextStyle? get caption => textTheme.labelSmall;
  TextStyle? get button => textTheme.labelLarge;

  @override
  ThemeTypographyTokens copyWith({
    TextTheme? textTheme,
    TextTheme? primaryTextTheme,
  }) {
    return ThemeTypographyTokens(
      textTheme: textTheme ?? this.textTheme,
      primaryTextTheme: primaryTextTheme ?? this.primaryTextTheme,
    );
  }

  @override
  ThemeTypographyTokens lerp(
    covariant ThemeExtension<ThemeTypographyTokens>? other,
    double t,
  ) {
    if (other is! ThemeTypographyTokens) return this;
    return ThemeTypographyTokens(
      textTheme: TextTheme.lerp(textTheme, other.textTheme, t),
      primaryTextTheme: TextTheme.lerp(
        primaryTextTheme,
        other.primaryTextTheme,
        t,
      ),
    );
  }

  @override
  List<Object?> get props => [textTheme, primaryTextTheme];
}

ThemeTypographyTokens _buildTypographyTokens({
  required Brightness brightness,
  required ThemeColorTokens colorTokens,
}) {
  final base = ThemeData(brightness: brightness).textTheme;
  final interTextTheme = GoogleFonts.interTextTheme(base);

  var textTheme = interTextTheme.copyWith(
    displayLarge: GoogleFonts.poppins(
      textStyle: base.displayLarge,
      fontSize: 36,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
    ),
    headlineMedium: GoogleFonts.poppins(
      textStyle: base.headlineMedium,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: GoogleFonts.poppins(
      textStyle: base.headlineSmall,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    titleLarge: GoogleFonts.poppins(
      textStyle: base.titleLarge,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.poppins(
      textStyle: base.titleMedium,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: GoogleFonts.poppins(
      textStyle: base.titleSmall,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: GoogleFonts.poppins(
      textStyle: base.labelLarge,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    labelMedium: GoogleFonts.inter(
      textStyle: base.labelMedium,
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: GoogleFonts.inter(
      textStyle: base.bodyLarge,
      fontSize: 18,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: GoogleFonts.inter(
      textStyle: base.bodyMedium,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: GoogleFonts.inter(
      textStyle: base.bodySmall,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: GoogleFonts.inter(
      textStyle: base.labelSmall,
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  );

  textTheme = textTheme.apply(
    bodyColor: colorTokens.solidColors.onBackground,
    displayColor: colorTokens.solidColors.onBackground,
  );

  final primaryTextTheme = textTheme.apply(
    bodyColor: colorTokens.solidColors.onPrimary,
    displayColor: colorTokens.solidColors.onPrimary,
  );

  return ThemeTypographyTokens(
    textTheme: textTheme,
    primaryTextTheme: primaryTextTheme,
  );
}
