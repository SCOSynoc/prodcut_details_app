
import 'package:flutter/cupertino.dart';

import '../models/Products.dart';
import '../models/Users.dart';

@immutable
sealed class AuthEvents {}

class AnonymousLogin extends AuthEvents {
  final String gender;
  AnonymousLogin({required this.gender});
}

class SignInRequested extends AuthEvents {

  final String email;
  final String password;

  SignInRequested({required this.password,required this.email});

}

class SignUpRequested extends AuthEvents {

  final String email;
  final String password;
  final String name;


  SignUpRequested({
    required this.email,
    required this.name,
    required this.password,
  });

}

class AlreadyAuthenticatedCheck extends AuthEvents {}

class UpdateUserOnlineStatus extends AuthEvents {
  final bool isOnline;
  UpdateUserOnlineStatus({required this.isOnline});
}

class LogoutRequested extends AuthEvents {

}

class AuthUserDataRequested extends AuthEvents {

}

class UpdateUserFavouriteList extends AuthEvents {
  final List<String> favList;
  final Products product;
  UpdateUserFavouriteList({required this.favList,required this.product, });
}


