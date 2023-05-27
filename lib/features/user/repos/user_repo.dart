import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // firestore에 저장하기 위한 문법. Users라는 컬렉션에 uid로 객체를 저장함.
  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }

  // firestore에서 uid로 객체정보를 불러오는 메소드
  Future<Map<String, dynamic>?> findProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).update(data);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchUsers() async {
    return _db.collection("users").orderBy("uid").get();
  }

  Future<void> deleteUser(String uid) async {
    await _db.collection("users").doc(uid).delete();
  }
}

final userRepo = Provider(
  (ref) => UserRepository(),
);
