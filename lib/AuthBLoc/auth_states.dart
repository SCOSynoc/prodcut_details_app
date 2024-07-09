
import 'package:flutter/cupertino.dart';

import '../models/Users.dart';

@immutable
sealed class AuthStates{}


class AuthInitial extends AuthStates {}

class AuthLoading extends AuthStates {
  final bool loading;
  AuthLoading({required this.loading});
}

class AnonymousSignInSuccess extends AuthStates {
  final bool isGuest;
  AnonymousSignInSuccess({required this.isGuest});
}

class SignUpSuccess extends AuthStates {}

class SignUpFailure extends AuthStates {}

class SignInFailure extends AuthStates {
  final String message;
  SignInFailure({required this.message});
}

class SignInSuccess extends AuthStates {}

class AnonymousSignInFailure extends AuthStates {}

class SignOutSuccess extends AuthStates {}

class AlreadyAuthenticated extends AuthStates {
  final bool authenticated ;
  AlreadyAuthenticated({required this.authenticated});
}

class AuthUserSuccess extends AuthStates {
  final Users user;
  final Stream<Users> userS;
  AuthUserSuccess({required this.user,required this.userS});
}

