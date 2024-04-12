import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable //a class ehose fields and also the fields of its subclsses can never be changed (var for eg) after inittiliztion
class AuthUser {
  //1 attribute (and constructor ofcourse) and 1 factory to return obj

  final bool isEmailVerified;//bc the only thing that is going to be done after the authentication and login is the verfication of email
  //the only attribute that is needed in user
const AuthUser(this.isEmailVerified); //since it will not be changed

//when we want want to return an instance of same class or subbclass
factory AuthUser.fromFirebase(User user)=> AuthUser( user.emailVerified);//factory constt to return the obj of same class or a sub class
//takes a firebase user and return an obj of our wn user that s AuthUser jiski isemailverifies prooperty true ya false hoogi based on the argument provided... 
//in this way we r nt expsing the firebase user and all of its propertties to the ui but only the one we are intrested in
}

//n tthis factory consttructors we are converting firebase user to our awn auth user so we are not exposing firebase user and all of its propertties in user interfce
//so we have abstracted away the firebase user from our own autth user