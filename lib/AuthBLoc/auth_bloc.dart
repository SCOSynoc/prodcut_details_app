
import 'dart:convert';



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_details_apps/repository/Local_storage.dart';


import '../../models/Users.dart';
import '../repository/auth_repository.dart';
import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvents,AuthStates> {
  AuthBloc(): super(AuthInitial()) {
    on<SignUpRequested>(_onSignupRequest);
    on<SignInRequested>(_onSignInRequested);
    on<AlreadyAuthenticatedCheck>(_checkAuthentication);
    on<LogoutRequested>(_onLogoutSuccess);
    on<AuthUserDataRequested>(_onAuthUserDataRequest);
    on<UpdateUserFavouriteList>(_onUpdateUserFavouriteList);
  }
}


AuthService service = AuthService()..initializeInstances();
HiveService local = HiveService()..initLocalService();




void _onSignupRequest(SignUpRequested event, Emitter<AuthStates> emit) async {
  emit(AuthLoading(loading: true));
  try{
    emit(AuthLoading(loading: true));
    bool done = await service.signInUserWithEmailAndPassword(
        email: event.email, password: event.password, name: event.name);
    if(done){
      await service.saveUserToFirestore(name: event.name, email: event.email, pic: '', favouriteList: []);
      emit(SignUpSuccess());
    }else{
      emit(SignUpFailure());
    }
  }catch(e){
    emit(AuthLoading(loading: false));
    emit(SignUpFailure());
    throw Exception("onSignupRequest() :: $e");
  }
}

void _onSignInRequested(SignInRequested event, Emitter<AuthStates> emit) async {
  try{
    emit(AuthLoading(loading: true));
    bool done = await service.loginUserWithEmailAndPassword(
      email: event.email, password: event.password,);
    if(done){
      emit(SignInSuccess());
    }else{
      emit(SignInFailure(message: 'Failed to login'));
    }
  }catch(e){
    emit(AuthLoading(loading: false));
    emit(SignInFailure(message: '$e'));
    print("The login error is ${e}");
    throw Exception("onLoginRequest() :: $e");
  }
}

/// authentication check functions
void _checkAuthentication(AlreadyAuthenticatedCheck event, Emitter<AuthStates> emit) async{
  emit(AuthLoading(loading: true)) ;
  try {
    String? data = local.getData(key: "userData");
    print("here the checked data is user from local hive storage Authentication check :: () $data");
    if(data != null) {
      emit(AlreadyAuthenticated(authenticated: true));
    }else{

      try{
        Users? user = await  service.getCurrentUserData();
        print("elec-bloc-exceuted and user is $user");
        if(user == null) {
          emit(AuthLoading(loading: false)) ;
          emit(AlreadyAuthenticated(authenticated: false));
        }else{
          local.addData(key: "userData", value: jsonEncode(user.toJson()));
          emit(AuthLoading(loading: false)) ;
          emit(AlreadyAuthenticated(authenticated: true));
        }
      }catch(e){
        throw Exception("Firebase exception is $e");
      }
    }
  }catch(e) {
    emit(AuthLoading(loading: false)) ;
    emit(AlreadyAuthenticated(authenticated: false));
    throw Exception(" error in function $e");

  }
}



void _onLogoutSuccess(LogoutRequested event, Emitter<AuthStates> emit) async{
  local.removeData(key: "userData");
  local.removeData(key: "isUserGuest");
  service.logoutCurrentUser();
  emit(SignOutSuccess());
}

void _onAuthUserDataRequest(AuthUserDataRequested event, Emitter<AuthStates> emit) async{
     Users? user = await service.getCurrentUserData();
     Stream<Users> userStream = await service.getCurrentUserDataStream();
     if(user != null) {
       emit(AuthUserSuccess(user: user, userS: userStream));
     }
}

void _onUpdateUserFavouriteList(UpdateUserFavouriteList event,Emitter<AuthStates> emit )async {
      service.updateUserFavourite(product: event.product, productsList: event.favList);

}

