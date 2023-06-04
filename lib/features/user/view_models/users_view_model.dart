import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../authentication/repos/authentication_repo.dart';
import '../models/user_profile_model.dart';
import '../repos/user_repo.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _usersRepository;
  late final AuthenticationRepository _authenticationRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _usersRepository = ref.read(userRepo);
    _authenticationRepository = ref.read(authRepo);
    if (_authenticationRepository.isLoggedIn) {
      // authRepo를 통해 login상태로 확인되면 uid로 객체정보를 받아옴.
      final profile = await _usersRepository
          .findProfile(_authenticationRepository.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile); // 객체정보Json을 Map으로 분리하여 반환.
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile(
    UserCredential credential,
    String name,
    String birthday,
  ) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }
    state = const AsyncValue.loading();
    final profile = UserProfileModel(
      uid: credential.user!.uid,
      email: credential.user!.email!,
      name: name,
      birthday: birthday,
    );
    await _usersRepository.createProfile(profile);
    state = AsyncValue.data(profile);
  }

  // hasAvatar를 true로 업데이트 시켜 화면이 동적으로 반응하게 만든다.
  Future<List<UserProfileModel>> getUserList() async {
    final result = await _usersRepository.fetchUsers();
    final users = result.docs.map(
      (doc) => UserProfileModel.fromJson(doc.data()),
    );
    return users.toList();
  }

  Future<void> updateProfile(
    BuildContext context,
    Map<String, dynamic> data,
  ) async {
    state = const AsyncValue.loading();
    final user = _authenticationRepository.user;
    if (user == null) {
      throw Exception("User not found");
    }
    /* data 강제 수정.. 나중에 수정해야함.. */
    data['uid'] = data['uid'] ?? state.value!.uid;
    data['email'] = data['email'] ?? state.value!.email;
    data['name'] = data['name'] ?? state.value!.name;
    data['birthday'] = data['birthday'] ?? state.value!.birthday;

    await _usersRepository.updateUser(state.value!.uid, data);
    state = AsyncValue.data(UserProfileModel.fromJson(data));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        content: const Text(
          "정보가 수정되었습니다.",
        ),
      ),
    );
    context.go("/home");
  }

  Future<void> deleteProfile(String uid) async {
    state = const AsyncValue.loading();
    await _usersRepository.deleteUser(uid);
    state = AsyncValue.data(UserProfileModel.empty());
  }

  //유저의 정보를 찾아오는 함수
  Future<Map<String, dynamic>> findProfile(String uid) async {
    final profile = await _usersRepository.findProfile(uid);
    if (profile != null) {
      return profile;
    } else {
      return {};
    }
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
