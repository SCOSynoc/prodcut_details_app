
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_details_apps/AuthBLoc/auth_bloc.dart';
import 'package:product_details_apps/AuthBLoc/auth_states.dart';
import 'package:product_details_apps/screens/Login_Screen.dart';


import '../AuthBLoc/auth_events.dart';
import '../Utils/constants.dart';
import '../widgets/CommonText.dart';
import '../widgets/Common_Button.dart';
import '../widgets/Common_textfeild.dart';
import '../widgets/Loading_Manager.dart';
import 'Dashboard_Screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc,AuthStates>(

      builder: (BuildContext context, AuthStates state) {
        return  LoadingManager(
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
                      SizedBox(height: 20,),
                      const CommonText(text: 'Sign Up', fontSize: 32, fontWeight: FontWeight.bold,textAlign: TextAlign.center,),
                      CommonTextField(controller: _nameController, action: () {}, labelText: "Name", icon: Icons.person, isPassword: false),
                      SizedBox(height: 20,),
                      CommonTextField(controller: _emailController, action: () {}, labelText: "Email", icon: Icons.email, isPassword: false),
                      SizedBox(height: 16,),
                      CommonTextField(controller: _passwordController, action: () {}, labelText: "Password", icon: Icons.password, isPassword: true),
                      SizedBox(height: 20,),
                      CommonButton(onTap: (){
                        if (_formKey.currentState!.validate()) {
                          // Perform signup
                          context.read<AuthBloc>().add(
                                  SignUpRequested(email: _emailController.text,
                                    password: _passwordController.text, name: _nameController.text,)
                              );
                        }
                      }, buttonText: "Sign up"),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        const CommonText(text: "Already have account ?"),
                        TextButton(onPressed: (){
                            navigateToScreen(context, LoginScreen());
                        }, child: const CommonText(text: "LogIn",))
                      ],),
                      const SizedBox(height: 20,),
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
        if(state is SignUpSuccess) {
          navigateAndRemovePush(context, DashboardScreen());
        }

        if(state is SignUpFailure) {
        showSnackBar(context: context, content: "Something went wrong");
        }

        if(state is AlreadyAuthenticated) {
          if(state.authenticated) {
              navigateAndRemovePush(context, DashboardScreen());
          }
        }

      },

    );
  }
}
