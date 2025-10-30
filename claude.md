# Claude CLI Project Overview

This document provides a concise overview of the `habit_heroes` Flutter project, summarizing key aspects from the project's documentation and structure. It's intended to help AI assistants and new developers quickly understand the project's conventions, setup, and workflows.

## 1. Project Setup

### Prerequisites
Before starting development, ensure the following tools are installed:
-   **Android Platform Tools (adb)**: `brew install android-platform-tools`
-   **Deno**: `brew install deno` (Used for Supabase Edge Functions)
-   **Direnv**: `brew install direnv` (For environment variables)
-   **FVM**: `dart pub global activate fvm` (To manage Flutter versions, use `fvm use 3.27.4` in root)
-   **mkdocs**: `pip install mkdocs` and `pip install mkdocs-material` (For documentation)
-   **Supabase CLI**: `brew install supabase/tap/supabase` (For local Supabase development)

### Post-Project Creation Checklist
If this project was created from the `habit_heroes` template, perform these manual steps:
1.  **Update Production Supabase**: Create a new project on Supabase.com, update `site_url` and `redirect_urls`, then link your local project using `supabase login` and `supabase link`.
2.  **Update App Configuration**: Replace `CHANGE_ME` placeholders in `app/lib/configurations/*.dart` with your Supabase, Sentry, and SMTP credentials.
3.  **Android Deep Links**: Update `app/android/app/src/main/AndroidManifest.xml` with the provided `intent-filter` for deep links.
4.  **iOS Deep Links**: Update `app/ios/Runner/Info.plist` with the provided `CFBundleURLTypes` for deep links.
5.  **Supabase Deep Links**: Update `supabase/config.toml` with `additional_redirect_urls` and enable email confirmations (`enable_confirmations = true`).
6.  **Deep Links Cleanup**: Search and replace `com.gadfly361.gadflyfluttertemplate.deep` with your project's deep link scheme (e.g., `com.my-company.my-application-name.deep`), excluding the `docs/` directory.
7.  **Environment Variables**: Create a `.env` file in the root with `SITE_HOST`, `SITE_URL_HTTP`, `SITE_URL_HTTPS`, and `EDGE_FUNCTION_SECRET`. Source these from `.envrc`.

## 2. Coding Guidelines

### Naming Conventions
-   **Client Providers**: `ClientProviderName_ClientProvider` (e.g., `Sentry_ClientProvider`)
-   **Effect Providers**: `EffectProviderName_EffectProvider` (e.g., `Mixpanel_EffectProvider`)
-   **Effects**: `EffectName_Effect` (e.g., `Mixpanel_Effect`)
-   **Repositories**: `RepositoryName_Repository` (e.g., `Auth_Repository`)
-   **Blocs**: `BlocName_Bloc` (e.g., `Auth_Bloc`)
-   **Bloc Events**: `BlocName_Event_ActionName` (e.g., `Auth_Event_GetAccessTokenFromUri`)
-   **Bloc States**: `BlocName_State` (e.g., `Auth_State`), with accompanying `BlocName_Status`.
-   **Widgets**: `WidgetLocation_WidgetType_WidgetDescription` (e.g., `Routes_Listener_AuthStatusChange`, `SignIn_Input_Email`)

### Separation of Concerns (using `flutter_bloc`)
-   Code is split into **outside** (instantiated in `appRunner`, singletons like Client/Effect Providers, Repositories) and **inside** (instantiated in the widget tree, like Cubits, Blocs, Effects) layers.
-   **Client Providers**: Provide Clients (e.g., database interaction). Singletons, instantiated outside.
-   **Effect Providers**: Provide Effects (side-effects, not singletons, instantiated in widget tree). Singletons, instantiated outside.
-   **Repositories**: Provide methods for side-effects to Blocs/Cubits. Singletons, instantiated outside, passed to `appBuilder`.
-   **Cubits**: Instantiated in widget tree, hold entity state, methods can be called directly in widget tree.
-   **Blocs**: Instantiated in widget tree, driven by events, hold application state.

### Bloc State Management Patterns
-   **Single Status Field**: Each bloc should have ONE `status` field that tracks the current action state.
-   **Single Status Enum**: Use ONE enum (e.g., `BlocName_Status`) with descriptive values that identify the action and state (e.g., `checking`, `checked`, `checkError`, `creating`, `createSuccess`, `createError`).
-   **Avoid Multiple Status Fields**: Do NOT create separate status fields like `loadStatus`, `createStatus`, etc. Use a single `status` field instead.
-   **Avoid Widget State**: Do NOT track action states (like `_isSubmitting`) in widget state. Use bloc status instead.

**Example Bloc State:**
```dart
// Single status enum with descriptive values for all actions
enum ParentAccess_Status {
  initial,
  checking,
  checked,
  checkError,
  creating,
  createSuccess,
  createError,
  verifying,
  verifySuccess,
  verifyError,
  updating,
  updateSuccess,
  updateError,
}

class ParentAccess_State {
  final ParentAccess_Status status;
  final String? errorMessage;
  final bool? pinExists;  // Additional data as needed
}
```

**Benefits:**
- Single status field simplifies state management
- Descriptive status values make the current action clear
- Single error message field reduces redundancy
- Easier to track the current operation in the UI
- Cleaner state transitions and less boilerplate code

### Theming and Colors
-   **NEVER hardcode colors**: Always use the theme token system instead of hardcoded `Color(0xFF...)` values.
-   **Solid Colors**: Use `context.solidColors.*` for general UI colors (backgrounds, text, borders, etc.)
      - Examples: `context.solidColors.surface`, `context.solidColors.onSurface`, `context.solidColors.error`
-   **Gradient Colors**: Use `context.colors.*Gradient` for feature-specific accent colors
      - Examples: `context.colors.parentsPrimary`, `context.colors.kidsPrimary`, `context.colors.tasksBlue`
-   **Reusable Components**: Use `ColorfulButton` and `ColorfulCard` widgets for gradient-based UI elements
-   **Creating New Colors**: If a color is not in the theme tokens:
      1. Determine if it's a **semantic color** (UI purpose-based) → Add to `AppSolidColors` in `colors.dart`
      2. Determine if it's a **feature-specific gradient** → Add as a new gradient to `ThemeColorTokens`
      3. Document the color in the `THEME_GUIDE.md` file
-   **Migration Status**: See `COLOR_MIGRATION_STATUS.md` for progress on converting hardcoded colors throughout the codebase
-   **Reference**: See `THEME_GUIDE.md` and `SOLID_COLORS_ADDITION.md` for complete color documentation

### Widget Organization
-   **Avoid Helper Methods**: Do NOT create helper methods that return widgets (e.g., `Widget _buildSomething()`).
-   **Use Widget Classes**: Instead of helper methods, create separate widget classes following the naming convention `PageName_Widget_WidgetDescription`.
-   **Widgets Folder**: For complex pages, create a `widgets/` folder next to the page file to organize reusable widgets.
-   **File Organization**: Each non-trivial widget should be in its own file within the `widgets/` folder.
-   **Benefits**: This approach keeps page files clean, improves testability, and makes widgets more reusable.

**Example Structure:**
```
authenticated/parents/tasks/create_task/
├── page.dart
└── widgets/
    ├── specific_date_picker.dart
    └── weekday_schedule.dart
```

**Example Widget:**
```dart
// Instead of: Widget _buildDatePicker() { ... }
// Do this:
class CreateTask_Widget_SpecificDatePicker extends StatelessWidget {
  final FDateFieldController controller;

  const CreateTask_Widget_SpecificDatePicker({
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FDateField.calendar(...);
  }
}
```

## 3. Development Workflows

### VSCode Tasks (Access via `CMD+SHIFT+B`)
-   **`[App] Analyze (Once)`**: Check for Dart analysis errors.
-   **`[App] Build Runner (Once/Watch)`**: Update code generation files (e.g., `auto_route_generator`, `json_serializable`).
-   **`[App] Dart Fix (Dry Run/Apply)`**: Fix Dart analysis errors.
-   **`[App] Modify and Copy Redirect URL for Android Emulator`**: Adjust Supabase redirect URLs for Android emulators.
-   **`[App] Prebuild (Once)`**: Run after cloning or pulling from `main` if the app isn't building.
-   **`[App] Slang (Once/Watch)`**: Update internationalization code from `app/lib/i18n/translations.i18n.yaml`.
-   **`[Packages] Prebuild (Once)`**: Run after changes to packages in `packages/`.
-   **`[Project] Direnv Allow`**: Register environment variables from `.env`.
-   **`[Project] Documentation (Serve)`**: Serve project-level documentation.
-   **`[Supabase] DB Reset`**: Delete and recreate local Supabase from migrations and seed files.
-   **`[Supabase] DB Diff (Local/Linked)`**: Check for changes between migration history/linked Supabase and local instance.
-   **`[Supabase] Functions New/Serve`**: Create or run Deno Edge Functions locally.
-   **`[Supabase] Migration List/Repair/New/Up`**: Manage Supabase migrations.
-   **`[Supabase] Start/Stop`**: Start or stop local Supabase.

### Running the Application
-   Use the "Run and Debug" tab in VSCode, selecting `development (debug)` or `production (debug)`.
-   Open DevTools (`Flutter: Open DevTools`) for debugging, especially the `bloc_devtools_extension` tab.

## 4. Key Tools and Technologies
-   **Flutter/Dart**: Core development platform.
-   **Supabase**: Backend-as-a-Service for database, authentication, and edge functions. (See also: https://supabase.com/docs)
-   **`flutter_bloc`**: State management library.
-   **`auto_route`**: Navigation and routing.
-   **`json_serializable`**: JSON serialization/deserialization.
-   **`slang_flutter`**: Internationalization.
-   **`sentry_flutter`**: Error reporting.
-   **`mixpanel_flutter`**: Analytics.
-   **`forui`**: Component library. To check the usage of a particular component, refer to the [Forui documentation](https://forui.dev/docs).
    *   **Layout**: Divider, Resizable, Scaffold
    *   **Form**: Autocomplete, Button, Checkbox, Date Field, Label, Multi Select, Picker, Radio, Select, Select Group, Slider, Switch, Text Field, Text Form Field, Time Field, Time Picker
    *   **Data Presentation**: Accordion, Avatar, Badge, Calendar, Card, Item, Item Group, Line Calendar, Tile, Tile Group Select, Tile Group Select Menu
    *   **Navigation**: Bottom Navigation Bar, Breadcrumb, Header, Pagination, Sidebar, Tabs
    *   **Feedback**: Alert, Circular Progress, Determinate Progress, Progress
    *   **Overlay**: Dialog, Sheet, Persistent Sheet, Popover, Popover Menu, Tooltip, Toast
    *   **Foundation**: Collapsible, Focused Outline, Portal, Tappable
