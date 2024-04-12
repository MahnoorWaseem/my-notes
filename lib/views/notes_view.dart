//notesView
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/enums/menu_action.dart';
import 'package:mynotes/services/auth/auth_service.dart';

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
              await AuthService.firebase().logOut();//returns promise
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