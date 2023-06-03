import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:precious_people/features/user/view_models/users_view_model.dart';

import '../../../utils.dart';
import '../repos/authentication_repo.dart';

class SocialAuthViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> googleSignIn(BuildContext context) async {
    UserCredential? userCredential;
    final users = ref.read(usersProvider.notifier);
    state = const AsyncValue.loading();

    state =
        await AsyncValue.guard(() async {
           userCredential = await _repository.signInWithGoogle();
           await users.createProfile(
               userCredential!, "", "");
        });

    if (state.hasError) {
      showFirebaseErrorSnack(
        context,
        state.error,
      ); // ViewModel에서 활용할 수 있는 util로 구현
    } else if (userCredential?.additionalUserInfo?.isNewUser == true) {
      context.go("/userInfo");
    } else {
      context.go("/home");
    }
  }
}

final socialAuthProvider = AsyncNotifierProvider<SocialAuthViewModel, void>(
    () => SocialAuthViewModel());
