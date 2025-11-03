# CHANGELOG

## 0.4.0

- Implemented account deletion feature with dialog UI and repository integration backed by Supabase.
- Created account deletion requests table with row-level security and policies for data privacy.
- Added Privacy Policy document outlining data collection and usage practices.
- Enhanced task creation with multi-select functionality for assigning tasks to multiple kids.
- Implemented specific time handling for task scheduling, including time selection UI and point deduction logic.
- Added uncomplete task functionality allowing tasks to be unmarked as completed from Kids Dashboard.
- Refactored ParentTasks Bloc to use unified single-status enum pattern for cleaner state management.
- Implemented flavor support for development and production environments with separate configurations.
- Fixed deep link schemes in AndroidManifest.xml for both dev and production environments.
- Enabled email confirmations in Supabase configuration.
- Added Spanish translations for Kids Dashboard and Parent Rewards sections.
- Enhanced PIN management with improved initialization and password input handling.
- Refactored Create Task page with new widget structure following project conventions.
- Updated Home page layout with tablet support and improved sign-out functionality.
- Replaced FHeader with AppBar in Reset Password and Email Verification pages for consistency.
- General UI enhancements with improved styling and layout adjustments across various pages.

## 0.3.0

- Added parental access PIN flow backed by SharedPreferences, including bloc events for creating, verifying, and updating the code.
- Introduced parent dashboard and settings routes with tiles for tasks, kids, rewards, and a new change PIN screen.
- Refreshed the home experience with parent gating dialogs, easier sign-out access, and layout tweaks for larger displays.
- Registered the shared preferences client provider and parent access repository during application startup.
- Updated launcher icon configuration to use the new kid-themed asset.

## 0.2.0

- Added data models: AppUser, Task, Reward, TaskCompletion with JSON
  serialization and Equatable.
- Implemented Supabase repositories for data models and integrated them into
  Repositories_All.
- Updated Auth_Bloc to fetch and create AppUser on login/signup, and manage
  AppUser details.
- Updated Auth_State to include user information.
- Fixed compilation errors and warnings in model and repository tests.
- Resolved missing_required_argument errors in app/lib/app/builder.dart by
  passing repository instances to Auth_Bloc.
- Enhanced LoginScreen and SignUpScreen with navigation based on authentication
  state and user role (parent or kid).
- Ensured SplashScreen routes users correctly based on their role via
  Auth_Listener_StatusChange.
- Created Supabase migration files for schema changes in data models and
  authentication.

## 0.1.0

- Initial release of Habit Heroes.
