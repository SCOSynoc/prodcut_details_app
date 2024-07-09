import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_details_apps/AuthBLoc/auth_events.dart';
import 'package:product_details_apps/AuthBLoc/auth_states.dart';
import 'package:product_details_apps/Utils/constants.dart';
import 'package:product_details_apps/screens/Registration_Screen.dart';

import '../AuthBLoc/auth_bloc.dart';
import '../models/Users.dart';
import '../widgets/CommonText.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userImage;
  Users? userData;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc,AuthStates>(
      builder: (context,state) {
        if(state is AuthUserSuccess) {
           userData = state.user;
           userImage = userData?.pic;
        }
          return Scaffold(
            appBar: AppBar(
              title:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(text: 'Profile',),
                  IconButton(onPressed: (){
                    context.read<AuthBloc>().add(LogoutRequested());
                  }, icon: Icon(Icons.logout))
                ],
              ),
            ),
            body: Column(
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage:userImage == null ? null : NetworkImage(userImage!) ,
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CommonText(text: "${userData?.name ?? ""}",),
                  ),),

              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(child: CommonText(text: "${userData?.email ?? ""}",),
                  ),),

              ],
            ),
          );
      }, listener: (BuildContext context, AuthStates state) {
         if(state is SignOutSuccess){
             navigateAndRemovePush(context, RegistrationScreen());
         }
    },

    );
  }
}
