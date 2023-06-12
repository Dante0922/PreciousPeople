
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:precious_people/features/relation/models/relation_model.dart';


class RelationshipRepository{

  final FirebaseFirestore _db = FirebaseFirestore.instance;

Future<void> createRelation(String friendId, RelationModel model) async {
  await _db.collection("relations").doc(friendId).set(model.toJson());
  }

  Future<void> completeRelation(String friendId, RelationModel model) async {
    await _db.collection("relations").doc(friendId).update(model.toJson());
    await _db.collection("relations").doc(friendId).collection("history").add({
      "friendId": model.friendId,
      "startDate": model.startDate,
      "endDate": model.endDate,
    });
  }

  Future<void> updateRelation(String friendId, RelationModel model) async {
    await _db.collection("relations").doc(friendId).update(model.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchRelations(String userId) async {
    return _db.collection("relations").where('registerUserId', isEqualTo: userId).get();
  }
}
final relationRepo = Provider((ref) => RelationshipRepository());
