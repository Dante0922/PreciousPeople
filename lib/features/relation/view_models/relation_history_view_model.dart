
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:precious_people/features/relation/models/relation_history_model.dart';
import 'package:precious_people/features/relation/models/relation_model.dart';

import '../repos/relation_history_repo.dart';

class RelationHistoryViewModel extends AsyncNotifier<void>{
  late final RelationHistoryRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(relationHistoryRepo);
  }

  Future<void> createRelationHistory(RelationModel relation) async {
    RelationHistoryModel history = RelationHistoryModel(
      friendId: relation.friendId,
      startDate: relation.startDate,
      endDate: DateTime.now().toString(),
    );
    await _repository.createRelationHistory(relation.friendId, history);
  }

  Future<List<RelationHistoryModel>> fetchRelationHistory(String friendId) async {
    final snapshot = await _repository.fetchRelationHistory(friendId);
    return snapshot.docs.map((e) => RelationHistoryModel.fromJson(e.data())).toList();
  }

  Future<RelationHistoryModel?> findLatestHistory(String friendId) async {
    return await _repository.findLatestHistory(friendId);
  }
}

final relationHistoryVM = AsyncNotifierProvider<RelationHistoryViewModel,void>(() => RelationHistoryViewModel());