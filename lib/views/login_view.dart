import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';
import '../firebase_options.dart'; 
import 'dart:developer' as devtools show log;


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
   //creating text editing controller
late final TextEditingController _email;
late final TextEditingController _password;

@override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
  //done creating text editing controller

   @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color.fromARGB(255, 233, 58, 116),
        ),

    //     body: FutureBuilder(
    //     future:      
    //   Firebase.initializeApp(
    //     options:DefaultFirebaseOptions.currentPlatform,
    //   ),
    //       builder: (context, snapshot) {

    //         switch(snapshot.connectionState){
              
              // case ConnectionState.none:
              // break;
              // case ConnectionState.waiting:
              //  break;
              // case ConnectionState.active:
              //  break;   or

              // case ConnectionState.done:
              // return 
              body : Column(
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType:TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Enter your email here'
                ),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Enter your password here',
                ),
              ),
              TextButton(
                onPressed: () async {       
                  final email = _email.text;
                  final password = _password.text;
                  try{
                    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password,
                 );
                 //print can take objectt but log nedd string
                //  devtools.log(userCredential.toString());
                 Navigator.of(context).pushNamedAndRemoveUntil(
                  notesRoute,
                   (route) => false,);
                  }
                  on FirebaseAuthException catch(e){
                    //to catch specific type of error
                    devtools.log(e.code);
                    //e type: FirebaseExceptionAuth
                    if(e.code == 'invalid-credential'){
                      await showErrorDialog(context, 'User not found!');
                    }
                    else if(e.code == 'wrong-password'){
                      devtools.log('Password is wrong!!');
                      devtools.log(e.code);
                      await showErrorDialog(context, 'Wrong Password');
                      //it isnt working btw -- wrng-passsword one
                    }
                    else{
                      //for other firebase auth exceptions
                      await showErrorDialog(context, 
                      'Error: ${e.code}');
                    }
                  }
                  catch(e){
                    //catch all errors-generic catch block not firebase autth exception
                    // devtools.log('something bad happened!!');
                    // //e type : object
                    // devtools.log(e.toString());
                    // devtools.log((e.runtimeType).toString());
                    await showErrorDialog(context, 
                    'Error: ${e.toString()}');
                  }
                 
                }, child: const Text('Click to Login'), //child wants a widget either image , text, listt etc to display
              ),
              TextButton(onPressed:() {
                Navigator.of(context).pushNamed(
                  registerRoute,
                //  (route) => false,
                 );
              }, child: const Text("Not rgistered yet? Register here!"),)
            ],
          )

  //             default:
  //             return const Text('Loading...');

  //           }
  //        },
  //       ),
    );

  }

  } // (LoginView)



