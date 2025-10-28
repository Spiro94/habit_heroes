# Custom Colorful Theme System Guide

This document explains how to use the new custom colorful theme system in the Habit Heroes app.

## Overview

The app now features a centralized, theme-aware color and gradient system that eliminates hardcoded color values throughout the codebase. All colors are managed through the theme token system and can be easily accessed and modified.

## Architecture

### Color Token System

**Location:** `app/lib/outside/theme/tokens/colors.dart`

The color system is built around two main classes:

#### `AppColorGradient`
Represents a gradient with start and end colors:

```dart
const gradient = AppColorGradient(
  start: Color(0xFF6366F1),
  end: Color(0xFF8B5CF6),
  begin: Alignment.topLeft,
  alignment: Alignment.bottomRight,
);
```

Methods available:
- `toLinearGradient()` - Returns a `LinearGradient` for use in decorations
- `toShadowColor(opacity)` - Returns the start color with opacity for shadows

#### `AppSolidColors`
Contains solid colors for the general app color scheme:

- **`background`** - Main background color
- **`surface`** - Surface color for cards, sheets, etc.
- **`surfaceVariant`** - Variant surface color for hierarchy
- **`onBackground`** - Text color on background
- **`onSurface`** - Primary text color on surface
- **`onSurfaceVariant`** - Secondary text color on surface
- **`primary`** - Primary action color
- **`onPrimary`** - Text color on primary background
- **`secondary`** - Secondary action color
- **`onSecondary`** - Text color on secondary background
- **`error`** - Error/destructive action color
- **`onError`** - Text color on error background
- **`success`** - Success state color
- **`warning`** - Warning state color
- **`info`** - Info state color
- **`border`** - Border color
- **`divider`** - Divider color
- **`disabled`** - Disabled state color
- **`disabledText`** - Text color for disabled state

#### `ThemeColorTokens`
Contains both solid colors and semantic color gradients for the app:

**Solid Colors:**
- **`solidColors`** - Access to all solid colors via `AppSolidColors`

**Gradient Colors:**
- **`parentsPrimary`** - Purple/Indigo gradient for parent-related features
- **`kidsPrimary`** - Pink/Rose gradient for kids-related features
- **`tasksBlue`** - Blue gradient for task management
- **`kidsManagementGreen`** - Green gradient for kids management/group features
- **`pointsGold`** - Yellow/Gold for points and reward badges
- **`datePickerCyan`** - Cyan gradient for date pickers and secondary elements
- **`taskCompletedGreen`** - Green for completed tasks

### Theme Extension

**Location:** `app/lib/outside/theme/tokens/extensions.dart`

The color tokens are integrated into the theme system via `ThemeTokenExtensions`:

```dart
extension ThemeTokensBuildContext on BuildContext {
  ThemeTokenExtensions get tokens =>
      Theme.of(this).extension<ThemeTokenExtensions>()!;

  ThemeColorTokens get colors => tokens.colors;
}
```

This allows accessing colors anywhere with access to `BuildContext`:

```dart
final gradient = context.colors.parentsPrimary;
final solidColors = context.solidColors;
```

## Usage Examples

### Using Solid Colors

Solid colors can be accessed via `context.solidColors` for general app theming:

```dart
// Access solid colors
Text(
  'Hello',
  style: TextStyle(
    color: context.solidColors.onBackground,
  ),
)

// Use for backgrounds
Container(
  color: context.solidColors.surface,
  child: ...
)

// Use for borders
Container(
  decoration: BoxDecoration(
    border: Border.all(
      color: context.solidColors.border,
    ),
  ),
)

// Disabled state
Container(
  color: context.solidColors.disabled,
  child: Text(
    'Disabled',
    style: TextStyle(color: context.solidColors.disabledText),
  ),
)

// Success/Error states
Container(
  color: context.solidColors.success,
  child: Icon(Icons.check),
)

Container(
  color: context.solidColors.error,
  child: Icon(Icons.error),
)
```

### Using Gradients in Custom Widgets

```dart
// Access the gradient
final gradient = context.colors.parentsPrimary;

// Create a container with gradient
Container(
  decoration: BoxDecoration(
    gradient: gradient.toLinearGradient(),
    borderRadius: BorderRadius.circular(24),
    boxShadow: [
      BoxShadow(
        color: gradient.toShadowColor(0.3),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  ),
  child: ...
)
```

### Using ColorfulButton Widget

The `ColorfulButton` widget provides a quick way to create gradient buttons with icons and text:

**Location:** `app/lib/inside/routes/widgets/colorful_button.dart`

```dart
ColorfulButton(
  gradient: context.colors.parentsPrimary,
  label: 'Padres',
  subtitle: 'Gestiona tareas y recompensas',
  icon: Icons.admin_panel_settings,
  onPressed: () => _handleParentAccess(context),
)
```

**Parameters:**
- `gradient` (required) - The `AppColorGradient` to use
- `label` (required) - Main text
- `onPressed` (required) - Callback when tapped
- `icon` - Icon to display above label
- `subtitle` - Smaller text below label
- `height` - Button height (default: 200)
- `borderRadius` - Corner radius (default: 24)
- `shadowOpacity` - Shadow opacity (default: 0.3)
- `shadowBlur` - Shadow blur radius (default: 20)
- `shadowOffset` - Shadow offset (default: Offset(0, 10))
- `iconSize` - Icon size (default: 80)
- `labelFontSize` - Label font size (default: 36)
- `subtitleFontSize` - Subtitle font size (default: 16)

### Using ColorfulCard Widget

The `ColorfulCard` widget provides a flexible gradient card:

**Location:** `app/lib/inside/routes/widgets/colorful_card.dart`

```dart
ColorfulCard(
  gradient: context.colors.kidsPrimary,
  height: 150,
  onTap: () => print('Tapped!'),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.star, color: Colors.white, size: 48),
      const SizedBox(height: 8),
      const Text('Rewards', style: TextStyle(color: Colors.white)),
    ],
  ),
)
```

**Parameters:**
- `gradient` (required) - The `AppColorGradient` to use
- `child` (required) - Widget to display inside the card
- `onTap` - Optional callback when tapped
- `height` - Optional card height
- `borderRadius` - Corner radius (default: 24)
- `shadowOpacity` - Shadow opacity (default: 0.3)
- `shadowBlur` - Shadow blur radius (default: 20)
- `shadowOffset` - Shadow offset (default: Offset(0, 10))

## Migration Guide

### Converting Hardcoded Gradients

**Before:**
```dart
Container(
  decoration: BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(24),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF6366F1).withOpacity(0.3),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  ),
  child: ...
)
```

**After:**
```dart
ColorfulButton(
  gradient: context.colors.parentsPrimary,
  label: 'Button Label',
  onPressed: () => {},
)
```

### Converting Pages

When updating a page to use the new theme:

1. **Add imports:**
   ```dart
   import '../../../../outside/theme/theme.dart';
   import '../../widgets/colorful_button.dart';
   ```

2. **Replace hardcoded containers with colorful widgets:**
   ```dart
   // Use ColorfulButton or ColorfulCard instead of GestureDetector + Container
   ```

3. **Access colors via context:**
   ```dart
   // Use context.colors.{colorName} to access gradients
   ```

## Color Palette Reference

### Solid Colors - Light Mode

| Color Token | Hex Value | Usage |
|-------------|-----------|-------|
| `background` | `#FAFAFA` | Main page background |
| `surface` | `#FFFFFF` | Cards, sheets, elevated surfaces |
| `surfaceVariant` | `#F3F4F6` | Secondary surface variation |
| `onBackground` | `#1F2937` | Main text on background |
| `onSurface` | `#111827` | Primary text on surface |
| `onSurfaceVariant` | `#6B7280` | Secondary text on surface |
| `primary` | `#6366F1` | Primary actions and accents |
| `onPrimary` | `#FFFFFF` | Text on primary background |
| `secondary` | `#EC4899` | Secondary actions |
| `onSecondary` | `#FFFFFF` | Text on secondary background |
| `error` | `#EF4444` | Destructive/error states |
| `onError` | `#FFFFFF` | Text on error background |
| `success` | `#10B981` | Success/completion states |
| `warning` | `#F59E0B` | Warning states |
| `info` | `#06B6D4` | Information states |
| `border` | `#E5E7EB` | Borders and outlines |
| `divider` | `#F3F4F6` | Dividers between content |
| `disabled` | `#D1D5DB` | Disabled component backgrounds |
| `disabledText` | `#9CA3AF` | Text in disabled state |

### Solid Colors - Dark Mode

| Color Token | Hex Value | Usage |
|-------------|-----------|-------|
| `background` | `#0F172A` | Main page background |
| `surface` | `#1E293B` | Cards, sheets, elevated surfaces |
| `surfaceVariant` | `#334155` | Secondary surface variation |
| `onBackground` | `#F1F5F9` | Main text on background |
| `onSurface` | `#F8FAFC` | Primary text on surface |
| `onSurfaceVariant` | `#CBD5E1` | Secondary text on surface |
| `primary` | `#818CF8` | Primary actions and accents |
| `onPrimary` | `#111827` | Text on primary background |
| `secondary` | `#F472B6` | Secondary actions |
| `onSecondary` | `#111827` | Text on secondary background |
| `error` | `#FCA5A5` | Destructive/error states |
| `onError` | `#7F1D1D` | Text on error background |
| `success` | `#6EE7B7` | Success/completion states |
| `warning` | `#FCD34D` | Warning states |
| `info` | `#22D3EE` | Information states |
| `border` | `#475569` | Borders and outlines |
| `divider` | `#334155` | Dividers between content |
| `disabled` | `#64748B` | Disabled component backgrounds |
| `disabledText` | `#94A3B8` | Text in disabled state |

### Gradient Colors - Light Mode

| Color Token | Start Color | End Color | Usage |
|-------------|------------|-----------|-------|
| `parentsPrimary` | `#6366F1` (Indigo) | `#8B5CF6` (Purple) | Parent dashboard, parent features |
| `kidsPrimary` | `#EC4899` (Pink) | `#F43F5E` (Rose) | Kids dashboard, kids features |
| `tasksBlue` | `#3B82F6` (Blue) | `#1E40AF` (Dark Blue) | Task management |
| `kidsManagementGreen` | `#10B981` (Emerald) | `#047857` (Teal) | Kids management, groups |
| `pointsGold` | `#FCD34D` (Yellow) | `#78350F` (Brown) | Points, rewards badges |
| `datePickerCyan` | `#06B6D4` (Cyan) | `#0891B2` (Dark Cyan) | Date pickers, secondary |
| `taskCompletedGreen` | `#34D399` (Light Green) | `#059669` (Green) | Completed task indicators |

### Gradient Colors - Dark Mode

Currently uses the same gradient colors as light mode. These can be customized by updating `_colorTokens_dark` in `colors.dart`.

The solid colors have separate dark mode definitions optimized for dark backgrounds.

## Customizing Colors

### Customizing Solid Colors

To change solid colors (backgrounds, text colors, borders, etc.):

1. **Edit `app/lib/outside/theme/tokens/colors.dart`**
2. **Update `_solidColors_light` and/or `_solidColors_dark`:**

```dart
const _solidColors_light = AppSolidColors(
  background: Color(0xFFNEWCOLOR),
  surface: Color(0xFFNEWCOLOR),
  // ... update other colors
);
```

3. **The changes will automatically apply throughout the app!**

### Customizing Gradient Colors

To change gradient colors (buttons, cards, feature-specific accents):

1. **Edit `app/lib/outside/theme/tokens/colors.dart`**
2. **Update the `_colorTokens_light` or `_colorTokens_dark` constants:**

```dart
const _colorTokens_light = ThemeColorTokens(
  solidColors: _solidColors_light,
  parentsPrimary: AppColorGradient(
    start: Color(0xFFNEWSTART),
    end: Color(0xFFNEWEND),
  ),
  // ... update other gradients
);
```

3. **The changes will automatically apply throughout the app!**

## Best Practices

1. **Always use theme colors** - Never hardcode colors in new code
2. **Use semantic names** - Use the semantic color tokens (e.g., `parentsPrimary`) rather than generic names
3. **Leverage reusable widgets** - Use `ColorfulButton` and `ColorfulCard` instead of creating custom containers
4. **Maintain consistency** - Keep similar features using the same color tokens
5. **Support dark mode** - Consider updating dark mode colors when you customize the palette

## Examples in the Codebase

### Home Page
**File:** `app/lib/inside/routes/authenticated/home/page.dart`

Shows how to use `ColorfulButton` for the main entry point buttons.

### Parent Dashboard
**File:** `app/lib/inside/routes/authenticated/parent_dashboard/page.dart`

Shows how to use `ColorfulButton` with custom sizing for dashboard cards.

### Kids Dashboard
**File:** `app/lib/inside/routes/authenticated/kids_dashboard/page.dart`

Uses custom colors throughout the tab interface and task cards.

## Troubleshooting

### Import Error: "Target of URI doesn't exist"

Make sure you're using the correct relative path. From `lib/inside/` paths, use:
```dart
import '../../../../outside/theme/theme.dart';
```

### Error: "The getter 'colors' isn't defined"

Ensure you've imported the theme:
```dart
import '../../../../outside/theme/theme.dart';
```

### Colors not updating

Clear the build cache:
```bash
fvm flutter clean
```

Then rebuild the app.

## Future Enhancements

- Add color opacity variations for each gradient
- Create text color tokens for better text contrast
- Implement automatic dark mode color adjustments
- Add animation/transition color tokens
- Create component-specific color token sets
