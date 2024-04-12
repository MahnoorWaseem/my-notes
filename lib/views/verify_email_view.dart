//verifyEmailView
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Email'),
        backgroundColor: Colors.blue,),
      body: Column(
          children: [
            const Text("We've sent an email verification. Please open it to verify your email."),
            const Text("If you haven't receive email yet, press the buttn below"),
            TextButton(onPressed:() async {
              AuthService.firebase().sendEmailVerification();
            }, 
            child: Text('Send me a verification email.')),
            TextButton(onPressed:() async {
              await AuthService.firebase().logOut();
              Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
            }, child: Text("Restart"))
          ],
        ),
    );
  }
}
