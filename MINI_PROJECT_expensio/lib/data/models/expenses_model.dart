import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'expenses_model.g.dart';

@HiveType(typeId: 1)
class Expenses {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? description;
  @HiveField(3)
  double? amountSpent;
  @HiveField(4)
  String? platformName;
  @HiveField(5)
  DateTime? createdOn;
  @HiveField(6)
  String? location;
  @HiveField(7)
  String? category;
  Expenses({
    this.id,
    this.title,
    this.description,
    this.amountSpent,
    this.platformName,
    this.createdOn,
    this.location,
    this.category,
  });

  Expenses copyWith({
    String? id,
    String? title,
    String? description,
    double? amountSpent,
    String? platformName,
    DateTime? createdOn,
    String? location,
    String? category,
  }) {
    return Expenses(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      amountSpent: amountSpent ?? this.amountSpent,
      platformName: platformName ?? this.platformName,
      createdOn: createdOn ?? this.createdOn,
      location: location ?? this.location,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'amountSpent': amountSpent,
      'platformName': platformName,
      'createdOn': createdOn?.millisecondsSinceEpoch,
      'location': location,
      'category': category,
    };
  }

  factory Expenses.fromMap(Map<String, dynamic> map) {
    return Expenses(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      amountSpent: map['amountSpent'],
      platformName:
          map['platformName'] != null ? map['platformName'] as String : null,
      createdOn: map['createdOn'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdOn'] as int)
          : null,
      location: map['location'] != null ? map['location'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expenses.fromJson(String source) =>
      Expenses.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expenses(id: $id, title: $title, description: $description, amountSpent: $amountSpent, platformName: $platformName, createdOn: $createdOn, location: $location, category: $category)';
  }

  @override
  bool operator ==(covariant Expenses other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.amountSpent == amountSpent &&
        other.platformName == platformName &&
        other.createdOn == createdOn &&
        other.location == location &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        amountSpent.hashCode ^
        platformName.hashCode ^
        createdOn.hashCode ^
        location.hashCode ^
        category.hashCode;
  }
}
