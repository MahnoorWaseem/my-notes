import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';


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
                 print('hello');
                 print(userCredential);
                  }
                  on FirebaseAuthException catch(e){
                    //to catch specific type of error
                    print(e.code);
                    //e type: FirebaseExceptionAuth
                    if(e.code == 'invalid-credential'){
                      print('Kindly register first!');
                    }
                    else if(e.code == 'wrong-password'){
                      print('Password is wrong!!');
                      print(e.code);
                      //it isnt working btw -- wrng-passsword one
                    }
                  }
                  catch(e){
                    //catch all errors
                    print('something bad happened!!');
                    //e type : object
                    print(e);
                    print(e.runtimeType);
                  }
                 
                }, child: const Text('Click to Login'), //child wants a widget either image , text, listt etc to display
              ),
              TextButton(onPressed:() {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/register/',
                 (route) => false,
                 );
              }, child: Text("Not rgistered yet? Register here!"),)
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
