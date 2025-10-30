# CHANGELOG

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
