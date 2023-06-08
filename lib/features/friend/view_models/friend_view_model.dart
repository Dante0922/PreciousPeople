import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:precious_people/features/authentication/repos/authentication_repo.dart';
import 'package:precious_people/features/friend/models/friend_profile_model.dart';
import 'package:precious_people/features/friend/repos/friend_repo.dart';
import 'package:precious_people/utils.dart';

class FriendViewModel extends AsyncNotifier<List<FriendProfileModel>> {
  late final FriendRepository _friendRepository;
  late final AuthenticationRepository _auth;
  List<FriendProfileModel> _list = [];

  @override
  FutureOr<List<FriendProfileModel>> build() async {
    _friendRepository = ref.read(friendRepo);
    _auth = ref.read(authRepo);
    if (_auth.user!.uid.isEmpty) return List.empty();
    _list = await _fetchFriends(_auth.user!.uid);
    return _list;
  }

  Future<void> createFriend(
    String name,
    String friendaversery,
    String contact,
    bool hasAvatar,
    BuildContext context, File? avatarFile
  ) async {
    final uid = _auth.user!.uid;
    state = const AsyncValue.loading();
    final profile = FriendProfileModel(
        registerUserId: uid,
        friendId: "",
        name: name,
        friendaversery: friendaversery,
        contact: contact,
        hasAvatar: hasAvatar ?? false,
        imageUrl: "",
        isLiked: false);
    state = await AsyncValue.guard(() async {
      await _friendRepository.createFriend(profile, uid, avatarFile);
      //_list = [profile, ..._list];
      _list = await _fetchFriends(uid);
      return _list;
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: const Text(
            "친구등록 완료!",
          ),
        ),
      );
      context.pushReplacement("/friends");
    }
  }

  Future<void> updateFriend(
      FriendProfileModel friend,
      String name,
      String friendaversery,
      String contact,
      bool hasAvatar,
      BuildContext context,
      File? avatarFile) async {
    final uid = _auth.user!.uid;
    state = const AsyncValue.loading();
    final profile = FriendProfileModel(
        registerUserId: uid,
        friendId: friend.friendId,
        name: name ?? friend.name,
        friendaversery: friendaversery ?? friend.friendaversery,
        contact: contact ?? friend.contact,
        hasAvatar: hasAvatar ?? friend.hasAvatar,
        imageUrl: friend.imageUrl,
        isLiked: false);
    state = await AsyncValue.guard(() async {
      await _friendRepository.updateFriend(friend.friendId, profile.toJson(), avatarFile);
      _list = await _fetchFriends(uid);
      return _list;
    });
    print(friend.friendId);
    print(friend.toJson());
    print(state);
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: const Text(
            "친구수정 완료!",
          ),
        ),
      );
      context.pushReplacement("/friends");
    }
  }

  Future<List<FriendProfileModel>> _fetchFriends(String uid) async {
    print(uid);
    final result = await _friendRepository.fetchFriends(uid);
    final friends = result.docs.map(
      (doc) => FriendProfileModel.fromJson(
        doc.data(),
      ),
    );
    return friends.toList();
  }



}

final friendViewModel =
    AsyncNotifierProvider<FriendViewModel, List<FriendProfileModel>>(
        () => FriendViewModel());
