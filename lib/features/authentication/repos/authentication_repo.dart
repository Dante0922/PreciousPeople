import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get user => _firebaseAuth.currentUser;
  bool get isLoggedIn => user != null;

  // 백엔드와 연동하여 로그인 정보를 확인하는 메서드
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  Future<UserCredential> emailSignUp(
    String email,
    String password,
  ) async {
    final UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> dropOut() async {
    await _firebaseAuth.currentUser!.delete();
  }

  Future<void> changePassword(String newPassword) async {
    await _firebaseAuth.currentUser!.updatePassword(newPassword);
  }

  Future<void> verifyPassword(String password) async {
    final credential = EmailAuthProvider.credential(
      email: _firebaseAuth.currentUser!.email!,
      password: password,
    );
    await _firebaseAuth.currentUser!.reauthenticateWithCredential(credential);
  }
}

final authRepo = Provider((ref) => AuthenticationRepository());

final authState = StreamProvider((ref) {
  final repo = ref.watch(authRepo);
  return repo.authStateChanges();
});
