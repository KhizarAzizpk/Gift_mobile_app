// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:gift_mobile_app/models/sub_profile_model.dart';

class UserModel {
  String uid;
  String userName;
  String email;
  String phoneNumber;
  String profileImageUrl;
  String gender;
  String dateOfBirth;
  String address;
  String createdAt;
  String selectedCountry;
  List<SubProfileModel> subProfilesList;
  UserModel({
    required this.uid,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.gender,
    required this.dateOfBirth,
    required this.address,
    required this.selectedCountry,
    required this.createdAt,
    required this.subProfilesList,
  });

  UserModel copyWith({
    String? uid,
    String? userName,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
    String? gender,
    String? dateOfBirth,
    String? address,
    String? Country,
    String? createdAt,
    List<SubProfileModel>? subProfilesList,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      subProfilesList: subProfilesList ?? this.subProfilesList,
      selectedCountry:selectedCountry ?? this.selectedCountry,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'selectedCountry':selectedCountry,
      'createdAt': createdAt,
      'subProfilesList': subProfilesList.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      userName: map['userName'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profileImageUrl: map['profileImageUrl'] ?? '',
      gender: map['gender'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      address: map['address'] ?? '',
      selectedCountry: map['selectedCountry'] ?? '',
      createdAt: map['createdAt'] ?? '',
      subProfilesList: List<SubProfileModel>.from(
        (map['subProfilesList'] as List<dynamic>).map<SubProfileModel>(
          (x) => SubProfileModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, userName: $userName, email: $email, phoneNumber: $phoneNumber, profileImageUrl: $profileImageUrl, gender: $gender, dateOfBirth: $dateOfBirth, address: $address,selectedCountry:$selectedCountry, createdAt: $createdAt, subProfilesList: $subProfilesList)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.userName == userName &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.profileImageUrl == profileImageUrl &&
        other.gender == gender &&
        other.dateOfBirth == dateOfBirth &&
        other.address == address &&
        other.selectedCountry == selectedCountry &&
        other.createdAt == createdAt &&
        listEquals(other.subProfilesList, subProfilesList);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        userName.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        profileImageUrl.hashCode ^
        gender.hashCode ^
        dateOfBirth.hashCode ^
        address.hashCode ^
        selectedCountry.hashCode^
        createdAt.hashCode ^
        subProfilesList.hashCode;
  }
}
