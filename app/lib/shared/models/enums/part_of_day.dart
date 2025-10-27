import '../../../inside/i18n/translations.g.dart';

enum PartOfDay {
  morning,
  afternoon,
  night;

  String get displayName {
    switch (this) {
      case PartOfDay.morning:
        return t.partOfDay.morning;
      case PartOfDay.afternoon:
        return t.partOfDay.afternoon;
      case PartOfDay.night:
        return t.partOfDay.night;
    }
  }

  String get key {
    switch (this) {
      case PartOfDay.morning:
        return 'morning';
      case PartOfDay.afternoon:
        return 'afternoon';
      case PartOfDay.night:
        return 'night';
    }
  }
}
