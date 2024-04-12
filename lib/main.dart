// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';
// import 'package:mynotes/views/login_view.dart';
import 'dart:developer' as devtools show log;//show is used o show specific part of the package and as to be more specific like to tell where this specific functin come from

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 184, 122, 56)),
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
      //named routes are defined in main function
      routes: { //map key are string and value are functions that takes builtContext argument and returns a widget
        loginRoute:(context) => const LoginView(),
        registerRoute:(context) => const RegisterView(),
        notesRoute:(context) => const NotesView(),
        verifyEmailRoute:(context)=> const VerifyEmailView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return
    //  Scaffold(
    //   appBar: AppBar(
    //     title: const Text('My Home Page'),
    //     backgroundColor: Color.fromARGB(255, 233, 58, 70),
    //   ),
    //   body: 
      FutureBuilder(
        future: 
        // Firebase.initializeApp(
        //   options: DefaultFirebaseOptions.currentPlatform,), 
        AuthService.firebase().initialize(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done:
            // final user = FirebaseAuth.instance.currentUser;
            final user = AuthService.firebase().currentUser;
            if(user!=null){
              devtools.log(user.toString());
              if(user.isEmailVerified){
                print('Email is verified');     
                return const NotesView();         
              }else{
                return const VerifyEmailView();
              }
              }
              else{
                return const LoginView();
              }
            


            // final user = FirebaseAuth.instance.currentUser; //logged in user saved in mobiles cache
            // final emailVerify = user?.emailVerified ?? false;
            // if (emailVerify){
            //   print(user);
            //    return const Text('Its done');
            //    }
            // else{
            //   return const VerifyEmailView(); //its like we are not rendering entire screen but pushing the content in our screen without scaffold

            //a way to push view with a scaffold although its not preferable btw learn it
            // Navigator.of(context).push(
            //   MaterialPageRoute(builder:(context) => const VerifyEmailView(),)
            // );
            ////
            // }
           
            
            default:
            return const CircularProgressIndicator();
          }
        },
      );

    // );
  }
}




