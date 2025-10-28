# Habit Heroes - Visual Style Guide

## Design Philosophy

Habit Heroes uses a **vibrant, gradient-based design system** that makes the app feel playful, engaging, and user-friendly. The visual language is built around:

- **Colorful gradients** for visual interest and hierarchy
- **Generous spacing** for comfortable touch targets and readability
- **Rounded corners** throughout for a friendly, approachable feel
- **Elevation shadows** to create depth and dimension
- **Semantic colors** that communicate purpose at a glance

---

## Color System

### Core Color Gradients

#### 1. Parents Primary (Purple/Indigo)
```
Start: #6366F1 (Indigo-500)
End:   #8B5CF6 (Violet-500)
```
**Usage**: Parent dashboard, parent-related features, administrative actions
**Feel**: Professional, authoritative, parent-focused

#### 2. Kids Primary (Pink/Rose)
```
Start: #EC4899 (Pink-500)
End:   #F43F5E (Rose-500)
```
**Usage**: Kids dashboard, kid-related features, child-friendly areas
**Feel**: Playful, energetic, fun

#### 3. Tasks Blue
```
Start: #3B82F6 (Blue-500)
End:   #1E40AF (Blue-800)
```
**Usage**: Task management, task-related features
**Feel**: Productive, focused, organized

#### 4. Kids Management Green
```
Start: #10B981 (Emerald-500)
End:   #047857 (Emerald-700)
```
**Usage**: Kids management screens, group features
**Feel**: Growth, nurturing, family-focused

#### 5. Points Gold (UPDATED - Better Contrast)
```
Start: #F59E0B (Amber-500)  ← Changed from #FCD34D
End:   #D97706 (Amber-600)  ← Changed from #78350F
```
**Change Reason**: Previous yellow was too bright, causing poor text contrast
**Usage**: Points, rewards, achievements
**Feel**: Valuable, rewarding, achievement-focused
**Text Color**: Use white or dark brown for readable contrast

#### 6. Date Picker Cyan
```
Start: #06B6D4 (Cyan-500)
End:   #0891B2 (Cyan-600)
```
**Usage**: Date pickers, calendar features, info dialogs
**Feel**: Clear, informative, time-focused

#### 7. Task Completed Green
```
Start: #34D399 (Emerald-400)
End:   #059669 (Emerald-600)
```
**Usage**: Success states, completed tasks, positive feedback
**Feel**: Accomplished, successful, positive

### Solid Colors (Semantic)

#### Surface Colors
- **Background**: `#FAFAFA` (Light), `#0F172A` (Dark)
- **Surface**: `#FFFFFF` (Light), `#1E293B` (Dark)
- **Surface Variant**: `#F3F4F6` (Light), `#334155` (Dark)

#### Text Colors
- **On Background**: `#1F2937` (Light), `#F1F5F9` (Dark)
- **On Surface**: `#111827` (Light), `#F8FAFC` (Dark)
- **On Surface Variant**: `#6B7280` (Light), `#CBD5E1` (Dark)

#### State Colors
- **Error**: `#EF4444` (Red-500)
- **Success**: `#10B981` (Emerald-500)
- **Warning**: `#F59E0B` (Amber-500)
- **Info**: `#06B6D4` (Cyan-500)

#### Utility Colors
- **Border**: `#E5E7EB` (Light), `#475569` (Dark)
- **Divider**: `#F3F4F6` (Light), `#334155` (Dark)
- **Disabled**: `#D1D5DB` (Light), `#64748B` (Dark)

---

## Component Library

### ColorfulButton

Large, eye-catching gradient button for primary navigation.

**Visual Specs**:
- Height: 200px (default)
- Border Radius: 24px
- Shadow: 20px blur, 10px offset, 30% opacity
- Icon Size: 80px
- Label Font: 36px, bold
- Subtitle Font: 16px

**Layout**:
```
┌───────────────────────────┐
│   Gradient Background     │
│                           │
│       ┌─────┐             │
│       │ Icon│  80px       │
│       └─────┘             │
│                           │
│    LABEL TEXT  36px       │
│                           │
│  Subtitle text  16px      │
│                           │
└───────────────────────────┘
      200px height
    24px border radius
```

**Usage**:
```dart
ColorfulButton(
  gradient: context.colors.parentsPrimary,
  label: 'Padres',
  subtitle: 'Gestiona tareas y recompensas',
  icon: Icons.admin_panel_settings,
  onPressed: () { },
)
```

### ColorfulCard

Gradient card container for content sections.

**Visual Specs**:
- Border Radius: 24px (default)
- Shadow: 20px blur, 10px offset, 30% opacity
- Padding: Custom (applied by child)
- Height: Auto or specified

**Usage**:
```dart
ColorfulCard(
  gradient: context.colors.taskCompletedGreen,
  child: Padding(
    padding: EdgeInsets.all(20),
    child: YourContent(),
  ),
)
```

### HabitHeroes_Dialog

Colorful modal dialog with gradient header.

**Visual Specs**:
- Border Radius: 20px
- Max Width: 400px
- Min Width: 280px
- Header Padding: 20px
- Body Padding: 20px
- Icon Size: 32px (in circular badge)
- Title Font: 20px, bold, white
- Shadow: Elevation 8

**Structure**:
```
╔═══════════════════════════╗
║  GRADIENT HEADER (20px)   ║
║      ┌───┐                ║
║      │ I │  32px icon     ║
║      └───┘                ║
║     TITLE  20px           ║
╚═══════════════════════════╝
│  BODY CONTENT (20px pad)  │
│  ┌─────────────────────┐  │
│  │ [Cancel] [Confirm]  │  │
│  └─────────────────────┘  │
└───────────────────────────┘
```

---

## Layout Patterns

### AppBar Design

**Gradient AppBars** (Used in list pages):
```dart
AppBar(
  backgroundColor: context.colors.taskType.start,
  foregroundColor: Colors.white,
  title: Text(
    'Page Title',
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  ),
  actions: [
    // White-background buttons for contrast
    ElevatedButton.icon(
      icon: Icon(Icons.add),
      label: Text('Action'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: context.colors.taskType.start,
      ),
      onPressed: () { },
    ),
  ],
)
```

### List Item Cards

**Gradient Cards** (Preferred for colorful lists):
```dart
ColorfulCard(
  gradient: context.colors.rewardType,
  borderRadius: 16,
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Row(
      children: [
        // Icon in circular badge
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.25),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.star, color: Colors.white),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Item Title',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'Subtitle',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
)
```

**Standard Cards** (For neutral content):
```dart
Card(
  margin: EdgeInsets.only(bottom: 16),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Padding(
    padding: EdgeInsets.all(16),
    child: YourContent(),
  ),
)
```

### Empty States

```dart
Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      // Large icon with gradient color
      Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: context.colors.featureType.toLinearGradient(),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.feature_icon,
          size: 64,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 24),
      Text(
        'No Items Yet',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 8),
      Text(
        'Get started by creating your first item',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: context.solidColors.onSurfaceVariant,
        ),
      ),
    ],
  ),
)
```

### Form Components

#### ColorfulTextField

A text field with gradient-colored focus borders and enhanced visual feedback:

```dart
ColorfulTextField(
  label: 'Name',
  hint: 'Enter your name',
  controller: nameController,
  gradient: context.colors.kidsManagementGreen,
  keyboardType: TextInputType.name,
  textCapitalization: TextCapitalization.words,
)
```

**Features**:
- Animated gradient background on focus
- Gradient-colored focus border (2px)
- Label changes color when focused
- Smooth 200ms transitions
- Built-in validation support

**Visual Behavior**:
- **Unfocused**: Grey label, surface variant background, no border
- **Focused**: Gradient-colored label, subtle gradient background, 2px gradient border
- **Error**: Red border, error message below

**Spacing**:
- Label-to-field gap: 8px
- Border radius: 12px
- Content padding: 16px horizontal, 16px vertical

#### ColorfulSelector

An interactive selector for options with visual preview (ideal for color pickers):

```dart
ColorfulSelector(
  label: 'Color',
  description: 'Pick a color for your profile',
  selectedText: '#FF5733',
  previewColor: Color(0xFFFF5733),
  icon: Icons.color_lens,
  gradient: context.colors.kidsManagementGreen,
  onTap: () => showColorPicker(),
)
```

**Features**:
- Circular color preview with shadow (48px diameter)
- Two-line text layout (selected value + description)
- Gradient accent icon
- Material ripple effect
- Optional placeholder text when nothing selected

**Visual Behavior**:
- **With Selection**: Shows color preview circle with white border (3px)
- **Without Selection**: Shows gradient circle with icon
- **On Tap**: Material ripple effect, triggers callback

**Spacing**:
- Label-to-selector gap: 8px
- Border radius: 12px
- Content padding: 16px all around
- Preview size: 48x48px (circular)

#### Standard TextField Pattern

For simple text fields without gradient effects:

```dart
TextField(
  controller: controller,
  decoration: InputDecoration(
    hintText: 'Hint text',
    filled: true,
    fillColor: context.solidColors.surfaceVariant,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: context.colors.featureGradient.start,
        width: 2,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
  ),
)
```

#### Form Layout Best Practices

**Spacing**:
- Between form fields: 24px
- Label to field: 8px
- Before action button: 32px

**Field Width**:
- Full width for most inputs
- Max width constraint for very wide screens: 600px

**Validation**:
- Show errors below fields
- Use red color (`context.solidColors.error`)
- Keep error messages concise (1-2 lines)

**Example Form Layout**:
```dart
ListView(
  padding: EdgeInsets.all(20),
  children: [
    ColorfulTextField(
      label: 'Field 1',
      hint: 'Enter value',
      controller: controller1,
      gradient: context.colors.featureGradient,
    ),
    Gap(24),
    ColorfulSelector(
      label: 'Option',
      description: 'Pick an option',
      onTap: () => showPicker(),
      gradient: context.colors.featureGradient,
    ),
    Gap(32),
    SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onSubmit,
        child: Text('Submit'),
      ),
    ),
  ],
)
```

---

## Typography Scale

### Display Text
- **Hero Title**: 36px, Bold
- **Page Title**: 24px, Bold
- **Section Header**: 20px, Bold

### Body Text
- **Large Body**: 18px, Medium/Regular
- **Standard Body**: 16px, Regular
- **Small Body**: 14px, Regular
- **Caption**: 12px, Regular

### Button Text
- **Large Button**: 18px, Bold
- **Standard Button**: 14-16px, Semi-Bold
- **Small Button**: 12px, Medium

---

## Spacing System

### Standard Spacing Scale
- **4px**: Tight spacing between related elements
- **8px**: Small gaps within components
- **12px**: Default gap between sub-elements
- **16px**: Standard spacing between sections
- **20px**: Component padding
- **24px**: Large gaps between major sections
- **32px**: Extra large section separation
- **48px**: Hero spacing

### Component-Specific Spacing

**Cards**:
- Padding: 16-20px
- Margin Bottom: 12-16px
- Border Radius: 16-24px

**Buttons**:
- Horizontal Padding: 20-24px
- Vertical Padding: 12-16px
- Border Radius: 12-24px

**Dialogs**:
- All Padding: 20px
- Border Radius: 20px
- Button Gap: 12px

---

## Shadow & Elevation

### Shadow Presets

**Light Elevation** (Cards, subtle depth):
```dart
BoxShadow(
  color: Colors.black.withValues(alpha: 0.1),
  blurRadius: 8,
  offset: Offset(0, 2),
)
```

**Medium Elevation** (Buttons, dialogs):
```dart
BoxShadow(
  color: gradientColor.toShadowColor(0.3),
  blurRadius: 12,
  offset: Offset(0, 4),
)
```

**High Elevation** (Colorful buttons, cards):
```dart
BoxShadow(
  color: gradientColor.toShadowColor(0.3),
  blurRadius: 20,
  offset: Offset(0, 10),
)
```

**Dialog Elevation**:
- Material elevation: 8

---

## Border Radius Standards

- **Small Elements**: 8px (badges, chips)
- **Medium Elements**: 12px (buttons, inputs)
- **Cards**: 16px (list items, content cards)
- **Large Cards**: 20px (feature cards, dialogs)
- **Hero Elements**: 24px (ColorfulButton, ColorfulCard)
- **Circular**: 999px or `BorderRadius.circular(999)`

---

## Icon Usage

### Icon Sizes
- **Hero Icons**: 64-80px (in ColorfulButton, empty states)
- **Large Icons**: 32-48px (in dialog headers, feature icons)
- **Standard Icons**: 24px (in app bars, buttons)
- **Small Icons**: 16-20px (inline icons, badges)

### Icon Colors
- **On Gradient Backgrounds**: White (`Colors.white`)
- **On Light Backgrounds**: Theme color or `context.solidColors.onSurface`
- **On Dark Backgrounds**: White or light variant
- **In Buttons**: Match foreground color

---

## Accessibility Guidelines

### Color Contrast
- **Text on Gradients**: Always use white for readability
- **Light Text**: Minimum 4.5:1 contrast ratio
- **Large Text**: Minimum 3:1 contrast ratio
- **Icons**: Follow same guidelines as text

### Touch Targets
- **Minimum Size**: 48x48 dp
- **Buttons**: 48dp height minimum
- **Icon Buttons**: 48x48 dp
- **List Items**: 56dp height minimum

### Focus States
- Use Material InkWell for automatic ripple effects
- Ensure keyboard navigation is possible
- Provide clear visual feedback on interaction

---

## Animation Guidelines

### Standard Durations
- **Fast**: 150ms (subtle feedback)
- **Normal**: 250ms (standard transitions)
- **Slow**: 350ms (page transitions)

### Curves
- **Standard Curve**: `Curves.easeInOut`
- **Enter**: `Curves.easeOut`
- **Exit**: `Curves.easeIn`
- **Bouncy**: `Curves.elasticOut` (use sparingly)

### Common Animations
- **Button Press**: Scale down slightly (0.95) with fast duration
- **Dialog**: Fade + scale up from 0.8 to 1.0
- **Page Transition**: Slide + fade
- **List Items**: Staggered fade-in on load

---

## Feature-Specific Patterns

### Parents Dashboard
- **Primary Color**: Purple/Indigo gradient
- **Cards**: Use ColorfulCard with parentsPrimary
- **AppBar**: Gradient background with white text

### Kids Dashboard
- **Primary Color**: Pink/Rose gradient
- **Cards**: Use ColorfulCard with kidsPrimary
- **AppBar**: Gradient background with white text
- **Extra Fun**: Use larger icons, more playful language

### Tasks
- **Primary Color**: Blue gradient
- **Cards**: Mix of ColorfulCard (tasksBlue) and standard Cards
- **Status Indicators**: Use taskCompletedGreen for completed

### Rewards
- **Primary Color**: Gold gradient (updated for better contrast)
- **Cards**: Use ColorfulCard with pointsGold
- **Points Badges**: Gold gradient background with white text
- **Icons**: Star icons prominently featured

### Kids Management
- **Primary Color**: Green gradient
- **Cards**: Use kid-specific colors when available
- **Avatar Circles**: Show kid's chosen color

---

## Do's and Don'ts

### ✅ Do
- Use gradient backgrounds for visual interest
- Apply consistent border radius across components
- Use generous padding (20px+) for touch-friendly UI
- Leverage shadows to create depth
- Use white text on gradient backgrounds
- Apply semantic colors (success = green, error = red)
- Use ColorfulCard and ColorfulButton for branded elements
- Center-align dialog content

### ❌ Don't
- Hardcode color values (`Color(0xFF...)`)
- Mix gradient styles arbitrarily
- Create overly complex gradient combinations
- Use insufficient padding (<12px on touch targets)
- Place dark text on dark backgrounds
- Ignore accessibility contrast requirements
- Create buttons smaller than 48dp height
- Use more than 2-3 colors on a single screen

---

## Implementation Checklist

When creating a new screen:
- [ ] Choose appropriate gradient for feature area
- [ ] Use ColorfulCard or ColorfulButton for hero elements
- [ ] Apply consistent border radius (16-24px)
- [ ] Add appropriate shadows for depth
- [ ] Use theme colors (NO hardcoded colors)
- [ ] Ensure minimum 48dp touch targets
- [ ] Test in both light and dark modes
- [ ] Verify text contrast (white on gradients)
- [ ] Add loading and empty states
- [ ] Include error handling UI

---

## Resources

### Color Generation Tools
- Use `context.colors.*Gradient.toLinearGradient()` for gradients
- Use `context.colors.*Gradient.toShadowColor(opacity)` for shadows
- Use `context.solidColors.*` for semantic colors

### Component Examples
- See `ColorfulButton` in `app/lib/inside/routes/widgets/colorful_button.dart`
- See `ColorfulCard` in `app/lib/inside/routes/widgets/colorful_card.dart`
- See `HabitHeroes_Dialog` in `app/lib/shared/widgets/habit_heroes_dialog.dart`

### Documentation
- Theme tokens: `app/lib/outside/theme/tokens/colors.dart`
- Dialog guide: `DIALOG_VISUAL_GUIDE.md`
- Quick start: `DIALOG_QUICK_START.md`

---

**Last Updated**: 2025-10-28
**Version**: 2.0 - Material Design + Gradient System
