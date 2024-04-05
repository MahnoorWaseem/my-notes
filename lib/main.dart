import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/views/login_view.dart';
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
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if(user!=null){
              devtools.log(user.toString());
              if(user.emailVerified){
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

//enum for menu
enum MenuAction {
  logout 
}


//notesView
class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Main UI'),
        //for 3 dots like menu
        actions: [
          PopupMenuButton<MenuAction>(onSelected:(value) async//tells that popupmenubbutton is going to manage things of type MenuAction
           {
            // devtools.log(value.toString());//bcz log only accepts string value and value is of type enum (menuaction) or value.toString()
            switch(value){
              case MenuAction.logout:
                final shouldLogout = await showLogoutDialog(context);
            // devtools.log(shouldLogout.toString());
            // break;
            if(shouldLogout){
              await FirebaseAuth.instance.signOut();//returns promise
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                 (route) => false); 
            }

            }
          },itemBuilder: (context){
            //we need to return a list
            return [const PopupMenuItem(
            value: MenuAction.logout,
             child:Text('Logout') ,)
             ];
          },)
        ],
      ),
      body: const Text('Hello World'),
    );
  }
}

//show dialog function
Future<bool> showLogoutDialog (BuildContext context)//contextt to show the dialog box on and will return future of typy bool
{
  //requires generic and return opttional like value can be null
  return showDialog<bool> 
  ( 
    context:context,
    builder:(context){
      return AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(onPressed: (){
            Navigator.of(context).pop(false);
          }, child: const Text('Cancel')),
          TextButton(onPressed: (){
            Navigator.of(context).pop(true);
          }, child: const Text('Log out')),
        ],
      );
    },
  ).then((value)=>value ?? false);//to catch its value
}
 //In the showLogoutDialog function, .then((value) => value ?? false) is used to handle the result returned by the showDialog<bool> . This .then method is called when the Future<bool> returned by showDialog<bool> completes. It takes a callback function that receives the value returned by the Future<bool>.