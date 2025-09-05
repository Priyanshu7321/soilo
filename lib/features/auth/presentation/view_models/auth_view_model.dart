import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soilo/core/services/auth_service.dart';
import 'package:soilo/features/auth/data/repositories/auth_repository_impl.dart';

import '../../../../core/providers/auth_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthRepositoryImpl(authService: authService);
});

final authStateChangesProvider = StreamProvider<User?>((ref) async* {
  final authRepo = ref.watch(authRepositoryProvider);
  final authService = ref.watch(authServiceProvider);
  
  // First, check if we have a stored login state
  final isLoggedIn = await authService.isLoggedIn;
  
  if (isLoggedIn) {
    final currentUser = authRepo.currentUser;
    if (currentUser != null) {
      yield currentUser;
    } else {
      // If we have a stored login but no current user, clear the state
      await authService.clearLoginState();
    }
  }
  
  // Then listen to auth state changes
  yield* authRepo.authStateChanges;
});

final authControllerProvider = StateNotifierProvider<AuthController, AsyncValue<void>>((ref) {
  final authRepo = ref.watch(authRepositoryProvider);
  return AuthController(authRepo: authRepo);
});

class AuthController extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepo;
  
  AuthController({required AuthRepository authRepo}) 
      : _authRepo = authRepo,
        super(const AsyncValue.data(null));

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _authRepo.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      await _authRepo.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      await _authRepo.signInWithGoogle();
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      await _authRepo.signOut();
      state = const AsyncValue.data(null);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }
}
