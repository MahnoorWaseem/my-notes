import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: const Color.fromARGB(255, 233, 58, 116),
        ),

        body: FutureBuilder(
        future:      
      Firebase.initializeApp(
        options:DefaultFirebaseOptions.currentPlatform,
      ),
          builder: (context, snapshot) {

            switch(snapshot.connectionState){
              
              // case ConnectionState.none:
              // break;
              // case ConnectionState.waiting:
              //  break;
              // case ConnectionState.active:
              //  break;   or

              case ConnectionState.done:
              return Column(
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
                    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password,
                 );
                 print('hello');
                 print(userCredential);
                  }
                  on FirebaseAuthException catch(e){
                    if(e.code == 'weak-password'){
                      print('kindly enter strng password!!');
                    }
                    else if(e.code == 'invalid-email'){
                      print('kindly enter valid email!!');
                    }
                    else if(e.code == 'email-already-in-use'){
                      print('Email is already in use');
                    }
                    else{
                      print(e.code);
                    }
                  }
                 
                }, child: const Text('Click to register'), //child wants a widget either image , text, listt etc to display
              ),
            ],
          ); 

              default:
              return const Text('Loading...');

            }
         },
        ),
    );
  }
}


