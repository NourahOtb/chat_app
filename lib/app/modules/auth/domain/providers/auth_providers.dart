import 'package:firbase_first_connect1/app/modules/auth/domain/providers/controller/txt_form_provider.dart';
import 'package:firbase_first_connect1/app/modules/auth/domain/providers/state/auth_state.dart';
import 'package:firbase_first_connect1/app/modules/auth/domain/reposetry/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller/auth_controller.dart';

final authFormController =
    ChangeNotifierProvider((ref) => MyAuthFormController());

// final authRepositoryProvider = Provider<AuthRepo>((ref) {
//   return AuthRepo(FirebaseAuth.instance);
// });

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(AuthState(), AuthRepo(FirebaseAuth.instance));
});

final authStateProvider = StreamProvider<User?>((ref) {
  final authRepository = AuthRepo(FirebaseAuth.instance);
  ref.read(authControllerProvider);
  return authRepository.authStateChanged;
});

final checkIfAuthinticatedFutureProvider =
    FutureProvider((ref) => ref.watch(authStateProvider));
