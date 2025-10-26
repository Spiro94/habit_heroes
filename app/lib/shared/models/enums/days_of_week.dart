enum DaysOfWeek {
  monday('Lun', 'Lunes'),
  tuesday('Mar', 'Martes'),
  wednesday('Mie', 'Miércoles'),
  thursday('Jue', 'Jueves'),
  friday('Vie', 'Viernes'),
  saturday('Sab', 'Sábado'),
  sunday('Dom', 'Domingo');

  final String shortName;
  final String fullName;
  const DaysOfWeek(this.shortName, this.fullName);
}
