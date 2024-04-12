// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:mynotes/utilities/show_error_dialog.dart';
// import '../firebase_options.dart';

// stateful register view
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

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
        title: const Text('Register'),
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
              body: Column(
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
                    // final userCredential = 
                    await AuthService.firebase().createUser(email: email, password: password);
                 //we doing email verificattin fr user 
                 final user = AuthService.firebase().currentUser;
                AuthService.firebase().sendEmailVerification();
                 Navigator.of(context).pushNamed(verifyEmailRoute);
                  } on WeakPasswordAuthException{
                    await showErrorDialog(context, 'Weak Password');
                  } on InvalidEmailAuthException{
                    await showErrorDialog(context, 'Email is invalid');
                  } on EmailAlreadyInUseAuthException{
                       await showErrorDialog(context, 'Email already in use');
                  } on GenericAuthException{
                         await showErrorDialog(context, 'Failed to register');
                     
                  }
                  // on FirebaseAuthException catch(e){
                    // if(e.code == 'weak-password'){
                    //   await showErrorDialog(context, 'Weak Password');
                      
                    // }
                    // else if(e.code == 'invalid-email'){
                    //   await showErrorDialog(context, 'Email is invalid');
                      
                    // }
                    // else if(e.code == 'email-already-in-use'){
                    //   await showErrorDialog(context, 'Email already in use');
                     
                    // }
                    // else{
                    //   //any other firebase exceptions
                    //   await showErrorDialog(context,'Error: ${e.code}');
                      
                    // }
                  // } catch(e){
                  //   await showErrorDialog(context,'Error: ${e.toString()}');//every obj has a func ttostring()
                  // }
                 
                }, child: const Text('Click to register'), //child wants a widget either image , text, listt etc to display
              ),
              TextButton(onPressed:() {
                Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
              }, child: const Text('Already registered? Login here!'))
            ],
          ) 

        //       default:
        //       return const Text('Loading...');

        //     }
        //  },
        // ),
    );
  }
}

//createUserWithEmailAndPassword()
//The method is a two-step operation; it will first create the new account (if it does not already exist and the password is valid) and then automatically sign in the user in to that account. 