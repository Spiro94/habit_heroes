# AI Coding Assistant Instructions for Habit Heroes

## Architecture Overview

**Strict Separation of Concerns**: Code is divided into "outside" (singletons) and "inside" (widget tree) layers:

- **Outside Layer** (`lib/outside/`): Singletons instantiated in `appRunner`

  - `client_providers/`: Provide clients (e.g., `Supabase_ClientProvider`)
  - `effect_providers/`: Provide effects (e.g., `Mixpanel_EffectProvider`)
  - `repositories/`: Business logic singletons (e.g., `Auth_Repository`)
- **Inside Layer** (`lib/inside/`): Instantiated in widget tree

  - `blocs/`: Application state management (events → state changes)
  - `routes/`: Navigation with auto_route code generation
  - Effects: Side-effects called directly in widgets

## State Management Patterns

**Bloc Pattern** (application state):

- Files: `bloc.dart`, `events.dart`, `state.dart`
- Naming: `Feature_Bloc`, `Feature_Event_Action`, `Feature_State`, `Feature_Status`
- Events drive state changes, widgets listen to state updates

**Cubit Pattern** (entity state):

- Single file with methods called directly in widgets
- Used for shared data across multiple screens

**Repository Pattern**:

- Singletons passed to blocs/cubits
- Handle side-effects, mocked in flow tests

## Naming Conventions

**Components**: `Location_Type_Description`

- Widgets: `SignUp_Form_SignUp`, `Routes_Button_Submit`
- Blocs: `Auth_Bloc`, `Auth_Event_SignIn`
- Repositories: `Auth_Repository`

**File Structure**:

```
lib/
├── app/           # App builder/runner
├── outside/       # Singletons (clients, effects, repos)
├── inside/        # Widget tree (blocs, routes, effects)
└── shared/        # Common utilities
```

## Development Workflow

**Local Development**:

1. Run `[App] Local Development Tasks` (starts watchers for build_runner, slang, test gallery, docs, supabase functions)
2. Use `development (debug)` runner
3. Open DevTools with `bloc_devtools_extension` tab

**Code Generation**:

- `build_runner watch`: Auto-route, JSON serialization
- `slang watch`: Internationalization
- Run `[App] Prebuild (Once)` after pulling changes

## Key Dependencies

- **State**: flutter_bloc, bloc_concurrency
- **Navigation**: auto_route + auto_route_generator
- **Backend**: supabase_flutter
- **UI**: forui (custom component library)
- **I18n**: slang + slang_flutter

## Database Schema

**Core Tables**: families, app_users, family_members, tasks, rewards, task_completions

- Row Level Security enabled on all tables
- Family-based access control
- UUID primary keys with timestamps

## Common Patterns

**Error Handling**: Try/catch in bloc event handlers, emit error states
**Logging**: Mixin `SharedMixin_Logging` for consistent logging
**Forms**: Stateful widgets with controllers, validation on submit
**Navigation**: Auto-generated routes with guards for auth states

## VS Code Tasks

- `[App] Analyze (Once)`: Lint checking
- `[App] Build Runner (Watch)`: Code generation
- `[App] Test Gallery (Serve)`: Visual testing at localhost:8001
- `[Supabase] Start/Stop/DB Reset`: Local backend management

## File Locations

- Routes: `lib/inside/routes/`
- Blocs: `lib/inside/blocs/`
- Repositories: `lib/outside/repositories/`
- Client Providers: `lib/outside/client_providers/`
- Docs: `docs/` (serve with `[Project] Documentation (Serve)`)
