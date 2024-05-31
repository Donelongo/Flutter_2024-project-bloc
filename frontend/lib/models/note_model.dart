class Note {
  final String id;
  final String title;
  final String content;
  final String userId;
  final int index;
  final DateTime createdAt;
  final DateTime updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
    required this.index,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['_id'] is String ? json['_id'] : '',
      title: json['title'] is String ? json['title'] : '',
      content: json['content'] is String ? json['content'] : '',
      userId: json['userId'] is String ? json['userId'] : '',
      index: json['index'] is int ? json['index'] : 0,
      createdAt: DateTime.parse(json['createdAt'] as String),//Dont think it matters but you can try
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'userId': userId,
      'index': index,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'Note{id: $id, title: $title, content: $content, userId: $userId, index: $index, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  Note copyWith({
    String? id,
    String? title,
    String? content,
    String? userId,
    int? index,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      index: index ?? this.index,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
