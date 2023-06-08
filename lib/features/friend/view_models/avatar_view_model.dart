import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:precious_people/features/friend/repos/friend_repo.dart';


import '../../authentication/repos/authentication_repo.dart';
import '../../user/repos/user_repo.dart';
import '../../user/view_models/users_view_model.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final FriendRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(friendRepo);
  }

  Future<void> uploadAvatar(File file, String FriendId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _repository.uploadAvatar(file, FriendId); // repo를 통해 storage에 업로드

    });
  }
}

final avatarProvider =
AsyncNotifierProvider<AvatarViewModel, void>(() => AvatarViewModel());
