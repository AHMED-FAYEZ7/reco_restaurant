import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reco_restaurant/features/auth/domain/usecases/cache_user_use_case.dart';
import 'package:reco_restaurant/features/auth/domain/usecases/clear_cashed_user_use_case.dart';
import 'package:reco_restaurant/features/auth/domain/usecases/get_cached_user_use_case.dart';
import 'package:reco_restaurant/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:reco_restaurant/features/auth/domain/usecases/sign_out_use_case.dart';
import 'package:reco_restaurant/features/auth/domain/usecases/sign_up_use_case.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCachedUserUseCase getCachedUserUseCase;
  final CacheUserUseCase cacheUserUseCase;
  final ClearCachedUserUseCase clearCachedUserUseCase;

  AuthBloc({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.getCachedUserUseCase,
    required this.cacheUserUseCase,
    required this.clearCachedUserUseCase,
  }) : super(const AuthState()) {
    on<SignUpEvent>(_onSignUp);
    on<SignInEvent>(_onSignIn);
    on<SignOutEvent>(_onSignOut);
    on<AuthCheckCachedUser>(_onCheckCachedUser);
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final user = await signUpUseCase(event.email, event.password);
      emit(state.copyWith(user: user, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final user = await signInUseCase(event.email, event.password);
      if (user != null) {
        await cacheUserUseCase(user);
      }
      emit(state.copyWith(user: user, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    await signOutUseCase();
    await clearCachedUserUseCase();
    emit(const AuthState());
  }

  Future<void> _onCheckCachedUser(
    AuthCheckCachedUser event,
    Emitter<AuthState> emit,
  ) async {
    final user = await getCachedUserUseCase();
    if (user != null) {
      emit(state.copyWith(user: user, isLoading: false));
    } else {
      emit(const AuthState());
    }
  }
}
