import 'package:firbase_first_connect1/app/modules/auth/domain/providers/state/auth_state.dart';
import 'package:firbase_first_connect1/app/modules/auth/domain/reposetry/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends StateNotifier<AuthState> {
  AuthController(super.state, this._authRepo);

  final AuthRepo _authRepo;

  Future<bool> register(
      {required String email,
      required String username,
      required String password}) async {
    state = state.copyWith(isLoading: true);

    try {
      User? user = await _authRepo.createUserWithEmailAndPassword(
          email: email, password: password, userName: username);

      if (user != null) {
        await user.updateDisplayName(username);
        state = state.copyWith(isLoading: false, isAuth: true);
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> googleSign() async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _authRepo.signInWithGoogle();
      if (user != null) {
        state = state.copyWith(isAuth: true);
        return true;
      }
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      throw e.toString();
    }
    return false;
  }

  Future<bool> signOut() async {
    try {
      await _authRepo.signOut();

      state = state.copyWith(
        isAuth: false,
        error: null,
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
