import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:precious_people/features/authentication/repos/authentication_repo.dart';
import 'package:precious_people/features/user/view_models/users_view_model.dart';

import '../../../utils.dart';

class SignUpViewmodel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.watch(authRepo);
  }

  Future<void> dropOut(BuildContext context) async {
    state = const AsyncValue.loading();
    final uid = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(() async {
      await _authRepo.dropOut();
      await ref.read(usersProvider.notifier).deleteProfile(uid);
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: const Text(
            "회원탈퇴가 정상적으로 처리되었습니다.",
          ),
        ),
      );
      context.go("/home");
    }
  }

  Future<void> changePassword(BuildContext context, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authRepo.changePassword(password);
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: const Text(
            "비밀번호가 수정되었습니다.",
          ),
        ),
      );
      context.go("/home");
    }
  }

  Future<bool> verifyPassword(BuildContext context, String password) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authRepo.verifyPassword(password);
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
      return false;
    } else {
      return true;
    }
  }
}

final changeAuthProvider =
    AsyncNotifierProvider<SignUpViewmodel, void>(() => SignUpViewmodel());
