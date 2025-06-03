import 'dart:convert';
import 'package:equatable/equatable.dart';

// TODO UPDATE MODEL VARS
class {{singular_name.pascalCase()}} extends Equatable {
  final int? id;

  const {{singular_name.pascalCase()}}({this.id});

  @override
  List<Object?> get props => [id];

  {{singular_name.pascalCase()}} copyWith({int? id}) {
    return {{singular_name.pascalCase()}}(id: id ?? this.id);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id};
  }

  factory {{singular_name.pascalCase()}}.fromMap(Map<String, dynamic> map) {
    return {{singular_name.pascalCase()}}(id: map['id'] != null ? map['id'] as int : null);
  }

  String toJson() => json.encode(toMap());

  factory {{singular_name.pascalCase()}}.fromJson(String source) =>
      {{singular_name.pascalCase()}}.fromMap(json.decode(source) as Map<String, dynamic>);
}
