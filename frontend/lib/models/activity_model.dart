class Activity {
  final String id;
  final String user;
  final String name;
  final String date;
  final String time;
  final List<String> logs;

  Activity({
    required this.id,
    required this.user,
    required this.name,
    required this.date,
    required this.time,
    required this.logs,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'name': name,
      'date': date,
      'time': time,
      'logs': logs,
    };
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['_id'],
      user: json['user'],
      name: json['name'],
      date: json['date'],
      time: json['time'],
      logs: List<String>.from(json['logs']),
    );
  }

  copyWith({required String user, required String name, required String date, required String time, required List<String> logs}) {}
}


