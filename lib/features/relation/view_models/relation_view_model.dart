import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:precious_people/features/friend/repos/friend_repo.dart';

import '../../../utils.dart';
import '../../authentication/repos/authentication_repo.dart';
import '../models/relation_history_model.dart';
import '../models/relation_model.dart';
import '../repos/relation_history_repo.dart';
import '../repos/relation_repo.dart';

class RelationViewModel extends AsyncNotifier<List<RelationModel>> {
  late final RelationshipRepository _relationRepository;
  late final FriendRepository _friendRepository;
  late final AuthenticationRepository _auth;
  List<RelationModel> _list = [];

  @override
  FutureOr<List<RelationModel>> build() async {
    _auth = ref.read(authRepo);
    _relationRepository = ref.read(relationRepo);
    _friendRepository = ref.read(friendRepo);
    _list = await _fetchRelations(_auth.user!.uid) as List<RelationModel>;
    return _list;
  }

  Future<List<RelationModel>> _fetchRelations(String userId) async {
    final snapshot = await _relationRepository.fetchRelations(userId);
    return snapshot.docs.map((e) => RelationModel.fromJson(e.data())).toList();
  }

  Future<RelationModel?> findRelation(String friendId) async {
    final relation = await _relationRepository.findRelation(friendId);
    return relation;
  }

  Future<void> createRelation(
      BuildContext context, String friendId, String period) async {
    final uid = _auth.user!.uid;
    final friend = await _friendRepository.findFriend(friendId);
    state = const AsyncValue.loading();
    final relation = RelationModel(
        registerUserId: uid,
        friendId: friendId,
        name: friend.name,
        startDate: DateTime.now().toString(),
        endDate:
            DateTime.now().add(Duration(days: int.parse(period))).toString(),
        period: period,
        lastContact: "");
    state = await AsyncValue.guard(() async {
      await _relationRepository.createRelation(friendId, relation);
      _list = await _fetchRelations(uid);
      return _list;
    });
    print(state);
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: const Text(
            "등록 완료!",
          ),
        ),
      );
      context.pushReplacement("/home");
    }
  }

  Future<void> snoozeRelation(
      BuildContext context, String friendId, RelationModel relation) async {
    final uid = _auth.user!.uid;
    state = const AsyncValue.loading();
    final newRelation = relation!.copyWith(
        endDate: DateTime.parse(relation.endDate)
            .add(const Duration(days: 7))
            .toString());

    state = await AsyncValue.guard(() async {
      await _relationRepository.updateRelation(friendId, newRelation);
      _list = await _fetchRelations(uid);
      return _list;
    });
  }

  Future<void> completeAndResetRelation(
      BuildContext context, String friendId, RelationModel relation) async {
    final uid = _auth.user!.uid;
    state = const AsyncValue.loading();
    final newRelation = relation!.copyWith(
        endDate: DateTime.now()
            .add(Duration(days: int.parse(relation.period)))
            .toString(),
        lastContact: DateTime.now().toString());


    state = await AsyncValue.guard(() async {
      await _relationRepository.updateRelation(friendId, newRelation);
      await ref.read(relationHistoryRepo).createRelationHistory(
          friendId,
          RelationHistoryModel(
              friendId: friendId,
              startDate: relation.startDate,
              endDate: DateTime.now().toString()));
      _list = await _fetchRelations(uid);
      return _list;
    });
  }
}

final relationViewModel =
    AsyncNotifierProvider<RelationViewModel, List<RelationModel>>(
        () => RelationViewModel());
