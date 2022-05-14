class Task {
  int id;
  String icon;
  String title;
  String date;
  String reminder;
  bool done = false;

  Task(
      {required this.id,
      required this.icon,
      required this.title,
      required this.date,
      required this.reminder});

  Map toMap() {
    return {
      'id': id,
      'icon': icon,
      'title': title,
      'date': date,
      'reminder': reminder,
      'done': done,
    };
  } //to map

  Task.fromMap(Map map)
      : id = map['id'],
        icon = map['icon'],
        title = map['title'],
        date = map['date'],
        reminder = map['reminder'],
        done = map['done'];
}
