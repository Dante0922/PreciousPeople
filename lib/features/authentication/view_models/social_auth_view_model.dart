import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../utils.dart';
import '../repos/authentication_repo.dart';

class SocialAuthViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> googleSignIn(BuildContext context) async {
    print("hello2");
    state = const AsyncValue.loading();

    print("hello3");
    state =
        await AsyncValue.guard(() async => await _repository.signInWithGoogle());

    print("hello4");
    print(state);
    if (state.hasError) {
      showFirebaseErrorSnack(
        context,
        state.error,
      ); // ViewModel에서 활용할 수 있는 util로 구현
    } else {
      context.go("/home");
    }
  }
}

final socialAuthProvider = AsyncNotifierProvider<SocialAuthViewModel, void>(
    () => SocialAuthViewModel());
