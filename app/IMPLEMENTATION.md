# IMPLEMENTATION.md

This document outlines the phased implementation plan for building the Habit
Heroes app.

## Journal

### Phase 2: Data Models and Repositories

- Implemented data models (AppUser, Task, Reward, TaskCompletion) and their
  Supabase repositories.
- Integrated new repositories into `Repositories_All`.
- Updated `Auth_Bloc` to fetch/create `AppUser` on login/signup and updated
  `Auth_State`.
- Fixed various compilation errors and warnings in model and repository tests
  (though tests are currently skipped).
- Fixed `missing_required_argument` errors in `app/lib/app/builder.dart` by
  passing new repository instances to `Auth_Bloc` and updating `authState`
  creation.

### Phase 3: Authentication

- Updated `Auth_Bloc` to fetch and manage `AppUser` details after login/signup.
- Updated `LoginScreen` and `SignUpScreen` implicitly by implementing
  `Auth_Listener_StatusChange` for navigation based on authentication state and
  user role.
- Ensured `SplashScreen` (initial routing) correctly routes users based on their
  role (`parent` or `kid`) via `Auth_Listener_StatusChange`.

## Phased Implementation Plan

After completing a task, if you added any TODOs to the code or didn't fully
implement anything, make sure to add new tasks so that you can come back and
complete them later.

### Phase 1: Project Foundation

- [x] Verify `pubspec.yaml` description and set version to `0.1.0`.
- [x] Create a placeholder `README.md` file.
- [x] Create `CHANGELOG.md` with an entry for version `0.1.0`.
- [x] Commit the initial project state to the
      `feature/habit-heroes-initial-structure` branch.

### Phase 2: Data Models and Repositories

- [x] Create the data model files (`app_user.dart`, `task.dart`, `reward.dart`,
      `task_completion.dart`) in `app/lib/shared/models`.
- [x] Add `json_serializable` and `equatable` to the models.
- [x] Run `build_runner` to generate `.g.dart` files.
- [x] Create the repository interfaces in `app/lib/outside/repositories`.
- [x] Implement the repositories using the Supabase client.
- [x] Create a Supabase migration file for the schema changes.
- [x] **Post-Phase Checklist:**

  - [x] Run `dart_fix` and `analyze_files` and fix any issues.
  - [x] Run `dart_format`.
  - [x] Update this `IMPLEMENTATION.md` file (Journal, check off tasks).
  - [x] Check off the tasks that were completed.
  - [ ] `git diff`, create a commit message, and get user approval before
        committing.

### Phase 3: Authentication

- [x] Update the `Auth_Bloc` to fetch and manage `AppUser` details after
      login/signup.
- [x] Update the `LoginScreen` and `SignUpScreen` to handle the new `AppUser`
      data.
- [x] Create a Supabase migration file for the schema changes.
- [x] **Post-Phase Checklist:**

  - [x] Run `dart_fix` and `analyze_files` and fix any issues.
  - [x] Run `dart_format`.
  - [x] Update this `IMPLEMENTATION.md` file.
  - [x] Check off the tasks that were completed.
  - [x] `git diff`, create a commit message, and get user approval before
        committing.

### Phase 4: Parent Module

- [ ] Create `ParentTasks_Bloc` and `ParentRewards_Bloc`.
- [ ] Create the `ParentDashboardScreen` with navigation to Tasks and Rewards.
- [ ] Create `ParentTasksScreen` to display a list of tasks.
- [ ] Create `ParentRewardsScreen` to display a list of rewards.
- [ ] Create `TaskFormScreen` for creating and editing tasks.
- [ ] Create `RewardFormScreen` for creating and editing rewards.
- [ ] Implement the UI and connect it to the respective Blocs.
- [ ] Create a Supabase migration file for the schema changes.
- [ ] **Post-Phase Checklist:**

  - [ ] Create/modify tests for the parent module.
  - [ ] Run `dart_fix` and `analyze_files` and fix any issues.
  - [ ] Run tests to ensure they all pass.

  - `] Run`dart_format`.

  - [ ] Update this `IMPLEMENTATION.md` file.
  - [ ] Check off the tasks that were completed.
  - [ ] `git diff`, create a commit message, and get user approval before
        committing.

### Phase 5: Kid Module

- [ ] Create `KidTasks_Bloc` and `KidProfile_Bloc`.
- [ ] Create the `KidDashboardScreen` with navigation.
- [ ] Create `KidTasksScreen` to display the task list and allow completion.
- [ ] Create `KidRewardsScreen` to display rewards and allow redemption.
- [ ] Implement the UI, focusing on a fun, gamified experience.
- [ ] Connect the UI to the Blocs.
- [ ] Create a Supabase migration file for the schema changes.
- [ ] **Post-Phase Checklist:**
  - [ ] Create/modify tests for the kid module.
  - [ ] Run `dart_fix` and `analyze_files` and fix any issues.
  - [ ] Run tests to ensure they all pass.
  - [ ] Run `dart_format`.
  - [ ] Update this `IMPLEMENTATION.md` file.
  - [ ] Check off the tasks that were completed.
  - [ ] `git diff`, create a commit message, and get user approval before
        committing.

### Phase 6: Finalization

- [ ] Create a comprehensive `README.md` file for the package.
- [ ] Create a `GEMINI.md` file in the project directory that describes the app,
      its purpose, and implementation details.
- [ ] Ask the user to inspect the app and the code and say if they are satisfied
      with it, or if any modifications are needed.
