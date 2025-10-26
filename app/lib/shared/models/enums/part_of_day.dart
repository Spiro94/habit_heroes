enum PartOfDay {
  morning('Mañana', 'morning'),
  afternoon('Tarde', 'afternoon'),
  evening('Noche', 'night');

  final String name;
  final String key;
  const PartOfDay(this.name, this.key);
}
