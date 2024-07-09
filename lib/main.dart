import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:product_details_apps/AuthBLoc/auth_events.dart';
import 'package:product_details_apps/AuthBLoc/auth_states.dart';
import 'package:product_details_apps/ProductsBloc/product_bloc.dart';
import 'package:product_details_apps/Utils/constants.dart';
import 'package:product_details_apps/screens/Dashboard_Screen.dart';
import 'package:product_details_apps/screens/Login_Screen.dart';
import 'package:product_details_apps/screens/Registration_Screen.dart';
import 'AuthBLoc/auth_bloc.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await Hive.openBox(localStorageBox);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(AlreadyAuthenticatedCheck())),
        BlocProvider(create: (context) => ProductBloc())
      ],
      child: BlocConsumer<AuthBloc,AuthStates>(
        listener: (BuildContext context, AuthStates state) {
           if(state is AlreadyAuthenticated) {


           }
        },
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home:const RegistrationScreen(),
          );
        },
      ),
    );
  }
}


