// // user.dart

// class User {
//   final String id;
//   final String username;
//   final String email;
//   final String password;

//   User({
//     required this.id,
//     required this.username,
//     required this.email,
//     required this.password,
//   });

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       username: json['username'],
//       email: json['email'],
//       password: json['password'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'username': username,
//       'email': email,
//       'password': password,
//     };
//   }

//   User copyWith({
//     String? id,
//     String? username,
//     String? email,
//     String? password,
//   }) {
//     return User(
//       id: id ?? this.id,
//       username: username ?? this.username,
//       email: email ?? this.email,
//       password: password ?? this.password,
//     );
//   }

//   @override
//   String toString() {
//     return 'User{id: $id, username: $username, email: $email, password: $password}';
//   }
// }


// user.dart

class User {
  final String id;
  final String username;
  final String email;

  User({
    required this.id,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, username: $username, email: $email}';
  }
}


