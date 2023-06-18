import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:precious_people/features/relation/models/relation_history_model.dart';

class RelationHistoryRepository{
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createRelationHistory(String friendId, RelationHistoryModel model) async {
    await _db.collection("relations").doc(friendId).collection("history").add(model.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchRelationHistory(String friendId) async {
    return _db.collection("relations").doc(friendId).collection("history").get();
  }
  Future<RelationHistoryModel?> findLatestHistory(String friendId) async {
    final snapshot = await _db.collection("relations").doc(friendId).collection("history")
        .orderBy("startDate",descending: true).limit(1).get();
    if (!snapshot.docs.isNotEmpty) {
      return null;
    }
    return RelationHistoryModel.fromJson(snapshot.docs.first.data());
  }

}

final relationHistoryRepo = Provider((ref) => RelationHistoryRepository());


