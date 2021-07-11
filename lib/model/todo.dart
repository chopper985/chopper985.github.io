import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String image;
  final String title;
  final String subTitle;
  final String status;
  final Timestamp createAt;
  Todo({
    required this.image,
    required this.title,
    required this.subTitle,
    required this.status,
    required this.createAt,
  });

  Todo copyWith({
    String? image,
    String? title,
    String? subTitle,
    String? status,
    Timestamp? createAt,
  }) {
    return Todo(
      image: image ?? this.image,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      status: status ?? this.status,
      createAt: createAt ?? this.createAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'title': title,
      'subTitle': subTitle,
      'status': status,
      'createAt': createAt.toDate().toString(),
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      image: map['image'],
      title: map['title'],
      subTitle: map['subTitle'],
      status: map['status'],
      createAt: map['createAt'],
    );
  }
    factory Todo.fromFirestore(dynamic map) {
    return Todo(
      image: map['image'],
      title: map['title'],
      subTitle: map['subTitle'],
      status: map['status'],
      createAt: map['createAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Todo(image: $image, title: $title, subTitle: $subTitle, status: $status, createAt: $createAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Todo &&
      other.image == image &&
      other.title == title &&
      other.subTitle == subTitle &&
      other.status == status &&
      other.createAt == createAt;
  }

  @override
  int get hashCode {
    return image.hashCode ^
      title.hashCode ^
      subTitle.hashCode ^
      status.hashCode ^
      createAt.hashCode;
  }
}
