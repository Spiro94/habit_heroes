part of '../theme.dart';

/// Represents a gradient with start and end colors
class AppColorGradient {
  final Color start;
  final Color end;
  final Alignment begin;
  final Alignment alignment;

  const AppColorGradient({
    required this.start,
    required this.end,
    this.begin = Alignment.topLeft,
    this.alignment = Alignment.bottomRight,
  });

  /// Returns a LinearGradient using these colors
  LinearGradient toLinearGradient() => LinearGradient(
    colors: [start, end],
    begin: begin,
    end: alignment,
  );

  /// Returns a shadow color (start color with opacity)
  Color toShadowColor([double opacity = 0.3]) =>
      start.withValues(alpha: opacity);
}

/// Solid colors for the app's general color scheme
class AppSolidColors {
  const AppSolidColors({
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.onBackground,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.error,
    required this.onError,
    required this.success,
    required this.warning,
    required this.info,
    required this.border,
    required this.divider,
    required this.disabled,
    required this.disabledText,
  });

  /// Main background color
  final Color background;

  /// Surface color for cards, sheets, etc.
  final Color surface;

  /// Variant surface color
  final Color surfaceVariant;

  /// Text color on background
  final Color onBackground;

  /// Text color on surface
  final Color onSurface;

  /// Secondary text color on surface
  final Color onSurfaceVariant;

  /// Primary action color
  final Color primary;

  /// Text color on primary background
  final Color onPrimary;

  /// Secondary action color
  final Color secondary;

  /// Text color on secondary background
  final Color onSecondary;

  /// Error/destructive action color
  final Color error;

  /// Text color on error background
  final Color onError;

  /// Success state color
  final Color success;

  /// Warning state color
  final Color warning;

  /// Info state color
  final Color info;

  /// Border color
  final Color border;

  /// Divider color
  final Color divider;

  /// Disabled state color
  final Color disabled;

  /// Text color for disabled state
  final Color disabledText;
}

/// Color tokens for the app with semantic meaning
class ThemeColorTokens extends ThemeExtension<ThemeColorTokens>
    with EquatableMixin {
  const ThemeColorTokens({
    required this.solidColors,
    required this.parentsPrimary,
    required this.kidsPrimary,
    required this.tasksBlue,
    required this.kidsManagementGreen,
    required this.pointsGold,
    required this.datePickerCyan,
    required this.taskCompletedGreen,
  });

  /// Solid colors for general app theming
  final AppSolidColors solidColors;

  /// Purple/Indigo gradient for Parent dashboard and parent-related features
  final AppColorGradient parentsPrimary;

  /// Pink/Rose gradient for Kids dashboard and kids-related features
  final AppColorGradient kidsPrimary;

  /// Blue gradient for Tasks management
  final AppColorGradient tasksBlue;

  /// Green gradient for Kids management/group features
  final AppColorGradient kidsManagementGreen;

  /// Yellow/Gold for points and rewards badges
  final AppColorGradient pointsGold;

  /// Cyan gradient for date pickers and secondary elements
  final AppColorGradient datePickerCyan;

  /// Green for completed tasks
  final AppColorGradient taskCompletedGreen;

  @override
  ThemeExtension<ThemeColorTokens> copyWith({
    AppSolidColors? solidColors,
    AppColorGradient? parentsPrimary,
    AppColorGradient? kidsPrimary,
    AppColorGradient? tasksBlue,
    AppColorGradient? kidsManagementGreen,
    AppColorGradient? pointsGold,
    AppColorGradient? datePickerCyan,
    AppColorGradient? taskCompletedGreen,
  }) {
    return ThemeColorTokens(
      solidColors: solidColors ?? this.solidColors,
      parentsPrimary: parentsPrimary ?? this.parentsPrimary,
      kidsPrimary: kidsPrimary ?? this.kidsPrimary,
      tasksBlue: tasksBlue ?? this.tasksBlue,
      kidsManagementGreen: kidsManagementGreen ?? this.kidsManagementGreen,
      pointsGold: pointsGold ?? this.pointsGold,
      datePickerCyan: datePickerCyan ?? this.datePickerCyan,
      taskCompletedGreen: taskCompletedGreen ?? this.taskCompletedGreen,
    );
  }

  @override
  ThemeExtension<ThemeColorTokens> lerp(
    covariant ThemeExtension<ThemeColorTokens>? other,
    double t,
  ) {
    if (other is! ThemeColorTokens) return this;
    return ThemeColorTokens(
      solidColors: _lerpSolidColors(solidColors, other.solidColors, t),
      parentsPrimary: AppColorGradient(
        start: Color.lerp(parentsPrimary.start, other.parentsPrimary.start, t)!,
        end: Color.lerp(parentsPrimary.end, other.parentsPrimary.end, t)!,
      ),
      kidsPrimary: AppColorGradient(
        start: Color.lerp(kidsPrimary.start, other.kidsPrimary.start, t)!,
        end: Color.lerp(kidsPrimary.end, other.kidsPrimary.end, t)!,
      ),
      tasksBlue: AppColorGradient(
        start: Color.lerp(tasksBlue.start, other.tasksBlue.start, t)!,
        end: Color.lerp(tasksBlue.end, other.tasksBlue.end, t)!,
      ),
      kidsManagementGreen: AppColorGradient(
        start: Color.lerp(
          kidsManagementGreen.start,
          other.kidsManagementGreen.start,
          t,
        )!,
        end: Color.lerp(
          kidsManagementGreen.end,
          other.kidsManagementGreen.end,
          t,
        )!,
      ),
      pointsGold: AppColorGradient(
        start: Color.lerp(pointsGold.start, other.pointsGold.start, t)!,
        end: Color.lerp(pointsGold.end, other.pointsGold.end, t)!,
      ),
      datePickerCyan: AppColorGradient(
        start: Color.lerp(datePickerCyan.start, other.datePickerCyan.start, t)!,
        end: Color.lerp(datePickerCyan.end, other.datePickerCyan.end, t)!,
      ),
      taskCompletedGreen: AppColorGradient(
        start: Color.lerp(
          taskCompletedGreen.start,
          other.taskCompletedGreen.start,
          t,
        )!,
        end: Color.lerp(
          taskCompletedGreen.end,
          other.taskCompletedGreen.end,
          t,
        )!,
      ),
    );
  }

  @override
  List<Object?> get props => [
    solidColors,
    parentsPrimary,
    kidsPrimary,
    tasksBlue,
    kidsManagementGreen,
    pointsGold,
    datePickerCyan,
    taskCompletedGreen,
  ];
}

/// Helper function to lerp solid colors
AppSolidColors _lerpSolidColors(AppSolidColors a, AppSolidColors b, double t) {
  return AppSolidColors(
    background: Color.lerp(a.background, b.background, t)!,
    surface: Color.lerp(a.surface, b.surface, t)!,
    surfaceVariant: Color.lerp(a.surfaceVariant, b.surfaceVariant, t)!,
    onBackground: Color.lerp(a.onBackground, b.onBackground, t)!,
    onSurface: Color.lerp(a.onSurface, b.onSurface, t)!,
    onSurfaceVariant: Color.lerp(a.onSurfaceVariant, b.onSurfaceVariant, t)!,
    primary: Color.lerp(a.primary, b.primary, t)!,
    onPrimary: Color.lerp(a.onPrimary, b.onPrimary, t)!,
    secondary: Color.lerp(a.secondary, b.secondary, t)!,
    onSecondary: Color.lerp(a.onSecondary, b.onSecondary, t)!,
    error: Color.lerp(a.error, b.error, t)!,
    onError: Color.lerp(a.onError, b.onError, t)!,
    success: Color.lerp(a.success, b.success, t)!,
    warning: Color.lerp(a.warning, b.warning, t)!,
    info: Color.lerp(a.info, b.info, t)!,
    border: Color.lerp(a.border, b.border, t)!,
    divider: Color.lerp(a.divider, b.divider, t)!,
    disabled: Color.lerp(a.disabled, b.disabled, t)!,
    disabledText: Color.lerp(a.disabledText, b.disabledText, t)!,
  );
}

/// Solid colors for light mode
const _solidColors_light = AppSolidColors(
  background: Color(0xFFFAFAFA),
  surface: Color(0xFFFFFFFF),
  surfaceVariant: Color(0xFFF3F4F6),
  onBackground: Color(0xFF1F2937),
  onSurface: Color(0xFF111827),
  onSurfaceVariant: Color(0xFF6B7280),
  primary: Color(0xFF6366F1),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFFEC4899),
  onSecondary: Color(0xFFFFFFFF),
  error: Color(0xFFEF4444),
  onError: Color(0xFFFFFFFF),
  success: Color(0xFF10B981),
  warning: Color(0xFFF59E0B),
  info: Color(0xFF06B6D4),
  border: Color(0xFFE5E7EB),
  divider: Color(0xFFF3F4F6),
  disabled: Color(0xFFD1D5DB),
  disabledText: Color(0xFF9CA3AF),
);

/// Solid colors for dark mode
const _solidColors_dark = AppSolidColors(
  background: Color(0xFF0F172A),
  surface: Color(0xFF1E293B),
  surfaceVariant: Color(0xFF334155),
  onBackground: Color(0xFFF1F5F9),
  onSurface: Color(0xFFF8FAFC),
  onSurfaceVariant: Color(0xFFCBD5E1),
  primary: Color(0xFF818CF8),
  onPrimary: Color(0xFF111827),
  secondary: Color(0xFFF472B6),
  onSecondary: Color(0xFF111827),
  error: Color(0xFFFCA5A5),
  onError: Color(0xFF7F1D1D),
  success: Color(0xFF6EE7B7),
  warning: Color(0xFFFCD34D),
  info: Color(0xFF22D3EE),
  border: Color(0xFF475569),
  divider: Color(0xFF334155),
  disabled: Color(0xFF64748B),
  disabledText: Color(0xFF94A3B8),
);

/// Light mode color palette
const _colorTokens_light = ThemeColorTokens(
  solidColors: _solidColors_light,
  parentsPrimary: AppColorGradient(
    start: Color(0xFF6366F1),
    end: Color(0xFF8B5CF6),
  ),
  kidsPrimary: AppColorGradient(
    start: Color(0xFFEC4899),
    end: Color(0xFFF43F5E),
  ),
  tasksBlue: AppColorGradient(
    start: Color(0xFF3B82F6),
    end: Color(0xFF1E40AF),
  ),
  kidsManagementGreen: AppColorGradient(
    start: Color(0xFF10B981),
    end: Color(0xFF047857),
  ),
  pointsGold: AppColorGradient(
    start: Color(0xFFF59E0B),
    end: Color(0xFFD97706),
  ),
  datePickerCyan: AppColorGradient(
    start: Color(0xFF06B6D4),
    end: Color(0xFF0891B2),
  ),
  taskCompletedGreen: AppColorGradient(
    start: Color(0xFF34D399),
    end: Color(0xFF059669),
  ),
);

/// Dark mode color palette
const _colorTokens_dark = ThemeColorTokens(
  solidColors: _solidColors_dark,
  parentsPrimary: AppColorGradient(
    start: Color(0xFF6366F1),
    end: Color(0xFF8B5CF6),
  ),
  kidsPrimary: AppColorGradient(
    start: Color(0xFFEC4899),
    end: Color(0xFFF43F5E),
  ),
  tasksBlue: AppColorGradient(
    start: Color(0xFF3B82F6),
    end: Color(0xFF1E40AF),
  ),
  kidsManagementGreen: AppColorGradient(
    start: Color(0xFF10B981),
    end: Color(0xFF047857),
  ),
  pointsGold: AppColorGradient(
    start: Color(0xFFF59E0B),
    end: Color(0xFFD97706),
  ),
  datePickerCyan: AppColorGradient(
    start: Color(0xFF06B6D4),
    end: Color(0xFF0891B2),
  ),
  taskCompletedGreen: AppColorGradient(
    start: Color(0xFF34D399),
    end: Color(0xFF059669),
  ),
);
