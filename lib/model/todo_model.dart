class TODO {
  int? id;
  String task;
  String date;
  String time;

  TODO({
    required this.date,
    required this.task,
    required this.time,
    this.id,
  });

  factory TODO.fromDB({required Map data}) {
    return TODO(
      date: data['date'],
      task: data['task'],
      time: data['time'],
      id: data['id'],
    );
  }
}
