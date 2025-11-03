# Habit Heroes

A gamified family habit-tracking app that helps families build positive habits
through fun rewards and achievements.

## Overview

Habit Heroes is a Flutter-based mobile application designed to make habit
tracking engaging for families. Parents can create tasks, assign them to their
children, and reward completed habits with points that can be redeemed for
real-world rewards.

## Features

### For Parents

- **Task Management**: Create and assign tasks to kids with customizable
  schedules and point values
- **Multi-Kid Assignment**: Assign tasks to multiple children simultaneously
- **Specific Time Scheduling**: Set specific times for tasks with automatic
  point deduction for late completion
- **Rewards System**: Create custom rewards that kids can redeem with earned
  points
- **PIN Protection**: Secure parental controls with PIN-based access to parent
  features
- **Family Dashboard**: Monitor all family members' progress and activities

### For Kids

- **Interactive Dashboard**: View assigned tasks and track completion progress
- **Points System**: Earn points by completing tasks on time
- **Rewards Catalog**: Browse and redeem available rewards with earned points
- **Task Completion**: Mark tasks as complete and track daily achievements
- **Uncomplete Tasks**: Ability to unmark accidentally completed tasks

### Technical Features

- **Multi-Environment Support**: Separate development and production
  configurations
- **Firebase Integration**: Analytics and crash reporting for app monitoring
- **Supabase Backend**: Real-time data synchronization and authentication
- **Email Verification**: Secure account creation with email confirmation
- **Account Deletion**: GDPR-compliant account deletion with data privacy
  controls
- **Internationalization**: Support for multiple languages (English, Spanish)
- **Offline Support**: Local data caching for seamless user experience

## Technology Stack

- **Framework**: Flutter 3.35.4
- **State Management**: flutter_bloc with bloc_concurrency
- **Backend**: Supabase (PostgreSQL, Authentication, Real-time)
- **Navigation**: auto_route
- **UI Library**: forui (custom component library)
- **Analytics**: Firebase Analytics, Mixpanel
- **Error Tracking**: Sentry
- **Internationalization**: slang

## Getting Started

### Prerequisites

- Flutter SDK 3.35.4 or higher
- Dart SDK 3.9.0 or higher
- Supabase account
- Firebase account (for analytics)

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run code generation:
   ```bash
   flutter pub run build_runner build
   ```
4. Configure environment variables (see Supabase and Firebase setup)
5. Run the app:
   ```bash
   flutter run
   ```

### Development Workflow

Use VS Code tasks for common development operations:

- `[App] Local Development Tasks`: Starts all development watchers
- `[App] Build Runner (Watch)`: Auto-generates code
- `[App] Slang (Watch)`: Watches for translation changes
- `[Supabase] Start`: Starts local Supabase instance

## Project Structure

```
lib/
├── app/              # Application initialization
├── inside/           # Widget tree layer (blocs, routes)
├── outside/          # Singleton layer (repositories, providers)
└── shared/           # Common utilities and models
```

## Architecture

The app follows a strict separation of concerns:

- **Outside Layer**: Singletons (repositories, client providers, effect
  providers)
- **Inside Layer**: Widget tree components (blocs, routes, UI)

See the
[Architecture Documentation](../docs/coding_guidelines/separation_of_concerns.md)
for more details.

## Contributing

Please follow the project's naming conventions and architecture guidelines:

- Component naming: `Location_Type_Description`
- Use relative imports for internal files
- Follow bloc/cubit patterns for state management

## Privacy

See [PRIVACY_POLICY.md](../PRIVACY_POLICY.md) for information about data
collection and usage.

## License

This project is proprietary software.

## Version

Current version: 0.5.0

See [CHANGELOG.md](CHANGELOG.md) for version history and release notes.
