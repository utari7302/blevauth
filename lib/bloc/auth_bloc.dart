import 'dart:async';

import 'package:blevauth/bloc/auth_event.dart';
import 'package:blevauth/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_authLoginRequested);
    on<AuthLogOutRequested>(_authLogOutRequested);
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(error, stackTrace);
  }

  @override
  void onChange(Change<AuthState> change) {
    // TODO: implement onChange
    super.onChange(change);
  }

  

  void _authLoginRequested(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final email = event.email;
      final password = event.password;

      if (password.length < 6) {
        return emit(AuthFailure('Password cannot be less than 6 character'));
      }

      await Future.delayed(
        const Duration(seconds: 1),
        () {
          return emit(AuthSuccess(uid: '$email-$password'));
        },
      );
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }

  void _authLogOutRequested(AuthLogOutRequested event, Emitter<AuthState> emit) async{
    emit(AuthLoading());
    try{
      await Future.delayed(
        const Duration(seconds: 1),
            () {
          return emit(AuthInitial());
        },
      );
    }catch(e){
      emit(AuthFailure(e.toString()));
    }
  }
}
