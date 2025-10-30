import '../models/enums/days_of_week.dart';

/// Extension methods for [DaysOfWeek] enum
/// Provides conversion utilities between DaysOfWeek and integer values
/// (where 0=Sunday, 1=Monday, ..., 6=Saturday)
extension DaysOfWeekExtension on DaysOfWeek {
  /// Convert DaysOfWeek enum to int
  /// Matches PostgreSQL day of week: 0=Sunday, 1=Monday, 2=Tuesday, etc.
  int toInt() {
    switch (this) {
      case DaysOfWeek.sunday:
        return 0;
      case DaysOfWeek.monday:
        return 1;
      case DaysOfWeek.tuesday:
        return 2;
      case DaysOfWeek.wednesday:
        return 3;
      case DaysOfWeek.thursday:
        return 4;
      case DaysOfWeek.friday:
        return 5;
      case DaysOfWeek.saturday:
        return 6;
    }
  }
}

/// Static extension methods for int to DaysOfWeek conversion
extension IntToDaysOfWeekExtension on int {
  /// Convert int to DaysOfWeek enum
  /// Returns null if the int value is not in the range 0-6
  /// Matches PostgreSQL day of week: 0=Sunday, 1=Monday, 2=Tuesday, etc.
  DaysOfWeek? toDaysOfWeek() {
    switch (this) {
      case 0:
        return DaysOfWeek.sunday;
      case 1:
        return DaysOfWeek.monday;
      case 2:
        return DaysOfWeek.tuesday;
      case 3:
        return DaysOfWeek.wednesday;
      case 4:
        return DaysOfWeek.thursday;
      case 5:
        return DaysOfWeek.friday;
      case 6:
        return DaysOfWeek.saturday;
      default:
        return null;
    }
  }
}
