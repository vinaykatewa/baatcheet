// ignore_for_file: unused_element

import 'dart:async';

import 'package:baatcheet/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:baatcheet/core/usecase/usecase.dart';
import 'package:baatcheet/core/common/entities/user.dart';
import 'package:baatcheet/features/auth/domain/usecases/current_user.dart';
import 'package:baatcheet/features/auth/domain/usecases/user_login.dart';
import 'package:baatcheet/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBlocBloc(
      {required UserSignUp userSignUp,
      required UserLogin userLogin,
      required CurrentUser currentUser,
      required AppUserCubit appUserCubit})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthBlocInitial()) {
    on<AuthBlocEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(authSignUp);
    on<AuthLogin>(authLogin);
    on<AuthIsUserLoggedIn>(authIsUserLoggedIn);
  }

  FutureOr<void> authSignUp(
      AuthSignUp event, Emitter<AuthBlocState> emit) async {
    final res = await _userSignUp.callMethod(UserSignParams(
        name: event.name, email: event.email, password: event.password));
    res.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => _emitAuthSuccess(r, emit));
  }

  FutureOr<void> authLogin(AuthLogin event, Emitter<AuthBlocState> emit) async {
    final res = await _userLogin.callMethod(
        UserLoginParams(email: event.email, password: event.password));
    res.fold((l) => emit(AuthFailure(message: l.message)),
        (r) => _emitAuthSuccess(r, emit));
  }

  FutureOr<void> authIsUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthBlocState> emit) async {
    final res = await _currentUser.callMethod(NoParams());
    res.fold((l) => emit(AuthFailure(message: l.message)), (r) {
      _emitAuthSuccess(r, emit);
    });
  }

  void _emitAuthSuccess(User user, Emitter<AuthBlocState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
