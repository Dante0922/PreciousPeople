import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:precious_people/features/friend/models/friend_profile_model.dart';

class FriendRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future<void> createFriend(FriendProfileModel friend, String userId) async {
    await _db.collection("friends").add(friend.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchFriends(String userId) async {
    return _db.collection("friends").where('registerUserId', isEqualTo: userId).get();
  }

  Future<void> deleteFriend(String userId, String friendId) async {
    await _db.collection("friends").doc(friendId).delete();
    await _db.collection("users").doc(userId).collection("friends").doc(friendId).delete();
  }

  Future<void> updateFriend(String friendId, Map<String, dynamic> data) async {
    await _db.collection("friends").doc(friendId).update(data);
  }

}

final friendRepo = Provider((ref) => FriendRepository());