import 'dart:convert';

class User {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? username;
  final DateTime? birthdate;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.birthdate,
  });

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? username,
    DateTime? birthdate,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      username: username ?? this.username,
      birthdate: birthdate ?? this.birthdate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'birthdate': birthdate?.toIso8601String(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String?,
      firstName: map['firstName'] as String?,
      lastName: map['lastName'] as String?,
      email: map['email'] as String?,
      username: map['username'] as String?,
      birthdate:
          map['birthdate'] != null ? DateTime.tryParse(map['birthdate']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
