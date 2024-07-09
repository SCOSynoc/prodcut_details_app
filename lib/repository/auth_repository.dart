import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/Products.dart';
import '../models/Users.dart';

abstract class AuthRepository {
  void initializeInstances();

  Future<bool> signInUserWithEmailAndPassword({ required String email ,
    required String password,
    required String name});

  Future<bool> loginUserWithEmailAndPassword({
    required String email ,
    required String password,
  });

  Future<Users?> getCurrentUserData();

}

class AuthService extends AuthRepository {
  late FirebaseAuth _auth;
  late FirebaseFirestore _firebase;

  @override
  Future<Users?> getCurrentUserData() async{
    Users? user;
    if(_auth.currentUser == null){
      return user;
    }else{
      var userData = await _firebase.collection("users").doc(_auth.currentUser!.uid).get();
      if(userData.data() != null){
        user = Users.fromJson(userData.data()!);
      }
      return user;
    }
  }

  Future<Stream<Users>> getCurrentUserDataStream() async{
      Users? user;
      var userData = await _firebase.collection("users").doc(_auth.currentUser!.uid).snapshots().map((event) {
         Map<String,dynamic> data = event.data() ?? {};
         return Users.fromJson(data);
      });
      return userData;
    }




  @override
  void initializeInstances() {
    _auth = FirebaseAuth.instance;
    _firebase = FirebaseFirestore.instance;
  }

  @override
  Future<bool> loginUserWithEmailAndPassword({required String email, required String password}) async{
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch(e){
      throw Exception(e.message);
    } on Exception catch(e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> signInUserWithEmailAndPassword({required String email, required String password, required String name}) async{
    try {
     await _auth.createUserWithEmailAndPassword(email: email, password: password);
     return true;
    } on FirebaseAuthException catch(e){
      throw Exception(e.message);
    } on Exception catch(e) {
      throw Exception(e);
    }
  }

  Future<void> saveUserToFirestore({
    required final String name,
    required final String email,
    required final String pic,
    required final List<String> favouriteList
  }) async{
    try{
      String uid = _auth.currentUser!.uid;
      String imageUri = "";

      Users user = Users(
          name: name,
          email: email,
          uid: uid,
          pic: pic,
          favouriteList: favouriteList

      );
      await _firebase.collection("users").doc(uid).set(user.toJson());
    }  catch(e){
      print("Error with saveUserDatatoFirestoreFunction():: ${e}");
      throw Exception("saveUserDatatoFirestoreFunction():: ${e}");
    }
  }

  void logoutCurrentUser(){

    _auth.signOut();
  }

  void updateUserFavourite({required Products product, required List<String> productsList})async{
     print("productList is ${productsList}");
      if(productsList.contains(json.encode(product.toJson()))) {
        /*print("productLis remove is ${productsList}");*/
        await _firebase.collection("users").doc(_auth.currentUser?.uid).update({
          "favouriteList": FieldValue.arrayRemove([json.encode(product.toJson())])
        });
      }else{
        /*print("The value is ${product.toJson()}");*/
        await _firebase.collection("users").doc(_auth.currentUser?.uid).update({
          "favouriteList": FieldValue.arrayUnion([json.encode(product.toJson())])
        }).onError((e,s) {
            print("The value is $e and stack is $s");
        }) ;
      }
  }


}