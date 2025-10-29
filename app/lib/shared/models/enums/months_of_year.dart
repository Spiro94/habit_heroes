enum MonthsOfYear {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december;

  String get fullName {
    switch (this) {
      case MonthsOfYear.january:
        return 'Enero';
      case MonthsOfYear.february:
        return 'Febrero';
      case MonthsOfYear.march:
        return 'Marzo';
      case MonthsOfYear.april:
        return 'Abril';
      case MonthsOfYear.may:
        return 'Mayo';
      case MonthsOfYear.june:
        return 'Junio';
      case MonthsOfYear.july:
        return 'Julio';
      case MonthsOfYear.august:
        return 'Agosto';
      case MonthsOfYear.september:
        return 'Septiembre';
      case MonthsOfYear.october:
        return 'Octubre';
      case MonthsOfYear.november:
        return 'Noviembre';
      case MonthsOfYear.december:
        return 'Diciembre';
    }
  }
}
