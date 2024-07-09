
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_details_apps/AuthBLoc/auth_bloc.dart';
import 'package:product_details_apps/AuthBLoc/auth_events.dart';
import 'package:product_details_apps/AuthBLoc/auth_states.dart';
import 'package:product_details_apps/Utils/constants.dart';
import 'package:product_details_apps/widgets/CommonText.dart';

import '../widgets/Common_Button.dart';
import '../widgets/Common_textfeild.dart';
import '../widgets/Loading_Manager.dart';
import 'Dashboard_Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc,AuthStates>(

      builder: (BuildContext context, AuthStates state) {
        return LoadingManager(
          isLoading: isLoading,
          child: Scaffold(
            body: Form(
              key: _formKey,
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width > 700 ? 650 : MediaQuery.of(context).size.width),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20,),
                      const CommonText(text: 'Log In', fontSize: 32, fontWeight: FontWeight.bold,textAlign: TextAlign.center,),
                      const SizedBox(height: 20,),
                      CommonTextField(controller: _emailController, action: () {}, labelText: "Email", icon: Icons.email, isPassword: false),
                      const SizedBox(height: 16,),
                      CommonTextField(controller: _passwordController, action: () {}, labelText: "Password", icon: Icons.password, isPassword: true),
                      const SizedBox(height: 20,),
                      CommonButton(onTap: (){
                        if (_formKey.currentState!.validate()) {
                          // Perform Login
                          context.read<AuthBloc>().add(
                                  SignInRequested(password: _passwordController.text, email: _emailController.text)
                              );
                        }
                      }, buttonText: "Sign in")
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, AuthStates state) {
        if(state is AuthLoading) {
           isLoading = state.loading;
        }
              if(state is SignInSuccess) {
                navigateAndRemovePush(context, DashboardScreen());
              }

              if(state is SignInFailure) {
                showSnackBar(context: context, content: "${state.message}");
              }
      },

    );
  }
}
