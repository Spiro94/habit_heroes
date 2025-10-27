import '../../../inside/i18n/translations.g.dart';

enum DaysOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  String get shortName {
    switch (this) {
      case DaysOfWeek.monday:
        return t.daysOfWeek.monday.short;
      case DaysOfWeek.tuesday:
        return t.daysOfWeek.tuesday.short;
      case DaysOfWeek.wednesday:
        return t.daysOfWeek.wednesday.short;
      case DaysOfWeek.thursday:
        return t.daysOfWeek.thursday.short;
      case DaysOfWeek.friday:
        return t.daysOfWeek.friday.short;
      case DaysOfWeek.saturday:
        return t.daysOfWeek.saturday.short;
      case DaysOfWeek.sunday:
        return t.daysOfWeek.sunday.short;
    }
  }

  String get fullName {
    switch (this) {
      case DaysOfWeek.monday:
        return t.daysOfWeek.monday.full;
      case DaysOfWeek.tuesday:
        return t.daysOfWeek.tuesday.full;
      case DaysOfWeek.wednesday:
        return t.daysOfWeek.wednesday.full;
      case DaysOfWeek.thursday:
        return t.daysOfWeek.thursday.full;
      case DaysOfWeek.friday:
        return t.daysOfWeek.friday.full;
      case DaysOfWeek.saturday:
        return t.daysOfWeek.saturday.full;
      case DaysOfWeek.sunday:
        return t.daysOfWeek.sunday.full;
    }
  }
}
