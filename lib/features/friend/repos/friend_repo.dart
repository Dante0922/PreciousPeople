import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:precious_people/features/friend/models/friend_profile_model.dart';

class FriendRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;



  Future<void> createFriend(FriendProfileModel friend, String userId, File? avatarFile) async {
    //await _db.collection("friends").add(friend.toJson());
    final DocumentReference<Map<String, dynamic>> path = await _db.collection("friends").doc();
    friend = friend.copyWith(friendId: path.id);
    if (avatarFile != null)   { await uploadAvatar(avatarFile, path.id);}
    _db.collection("friends").doc(path.id).set(friend.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchFriends(String userId) async {
    return _db.collection("friends").where('registerUserId', isEqualTo: userId).get();
  }

  Future<void> deleteFriend(String userId, String friendId) async {
    await _db.collection("friends").doc(friendId).delete();
    await _db.collection("users").doc(userId).collection("friends").doc(friendId).delete();
  }

  Future<void> updateFriend(String friendId, Map<String, dynamic> data, File? avatarFile) async {
    if (avatarFile != null) {await uploadAvatar(avatarFile, friendId);};
    await _db.collection("friends").doc(friendId).update(data);
  }
  Future<void> uploadAvatar(File file, String friendId) async {
    final fileRef = _storage.ref().child("avatars/$friendId");
    await fileRef.putFile(file);
  }


}

final friendRepo = Provider((ref) => FriendRepository());