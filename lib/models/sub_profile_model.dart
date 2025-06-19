// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SubProfileModel {
  String name;
  String subProfileId;
  String age;
  String dateOfBirth;
  String gender;
  String address;
  String phone;
  String interested;
  String notInterested;
  String theme;
  String occasion;
  SubProfileModel({
    required this.name,
    required this.subProfileId,
    required this.age,
    required this.dateOfBirth,
    required this.gender,
    required this.address,
    required this.phone,
    required this.interested,
    required this.notInterested,
    required this.theme,
    required this.occasion,
  });

  SubProfileModel copyWith({
    String? name,
    String? subProfileId,
    String? age,
    String? dateOfBirth,
    String? gender,
    String? address,
    String? phone,
    String? interested,
    String? notInterested,
    String? theme,
    String? occasion,
  }) {
    return SubProfileModel(
      name: name ?? this.name,
      subProfileId: subProfileId ?? this.subProfileId,
      age: age ?? this.age,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      interested: interested ?? this.interested,
      notInterested: notInterested ?? this.notInterested,
      theme: theme ?? this.theme,
      occasion: occasion ?? this.occasion,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'subProfileId': subProfileId,
      'age': age,
      'dateOfBirth': dateOfBirth,
      'gender': gender,
      'address': address,
      'phone': phone,
      'interested': interested,
      'notInterested': notInterested,
      'theme': theme,
      'occasion': occasion,
    };
  }

  factory SubProfileModel.fromMap(Map<String, dynamic> map) {
    return SubProfileModel(
      name: map['name'] as String,
      subProfileId: map['subProfileId'] as String,
      age: map['age'] as String,
      dateOfBirth: map['dateOfBirth'] as String,
      gender: map['gender'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      interested: map['interested'] as String,
      notInterested: map['notInterested'] as String,
      theme: map['theme'] as String,
      occasion: map['occasion'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubProfileModel.fromJson(String source) =>
      SubProfileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubProfileModel(name: $name, subProfileId: $subProfileId, age: $age, dateOfBirth: $dateOfBirth, gender: $gender, address: $address, phone: $phone, interested: $interested, notInterested: $notInterested, theme: $theme, occasion: $occasion)';
  }

  @override
  bool operator ==(covariant SubProfileModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.subProfileId == subProfileId &&
        other.age == age &&
        other.dateOfBirth == dateOfBirth &&
        other.gender == gender &&
        other.address == address &&
        other.phone == phone &&
        other.interested == interested &&
        other.notInterested == notInterested &&
        other.theme == theme &&
        other.occasion == occasion;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        subProfileId.hashCode ^
        age.hashCode ^
        dateOfBirth.hashCode ^
        gender.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        interested.hashCode ^
        notInterested.hashCode ^
        theme.hashCode ^
        occasion.hashCode;
  }
}
