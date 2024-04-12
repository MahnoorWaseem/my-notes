//we need to import authprovider as is the interface, authuser bc as we login etc are returning authuser so we would need to change the firebase user in to autthuser before returning,  authexception, and this file is going tto talk with firebase directly so firebase also
import 'dart:async';

import 'package:mynotes/services/auth/auth_user.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, FirebaseAuthException;

class FirebaseAuthProvider implements AuthProvider{

  @override
  Future<AuthUser> createUser({
    required String email,
     required String password,}) async{
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        //to check successful reg
        final user = currentUser;
        if(user!=null){
          return user;
        }else{
          throw UserNotLoggedInAuthException;
        }
      }on FirebaseAuthException catch(e){
              if(e.code == 'weak-password'){
              throw WeakPasswordAuthException();
            }
            else if(e.code == 'invalid-email'){
              throw InvalidEmailAuthException();
            }
            else if(e.code == 'email-already-in-use'){ throw EmailAlreadyInUseAuthException();
            }
            else{
              //any other firebase exceptions
              throw GenericAuthException();
                    }
         }
        catch(_){
              throw GenericAuthException();
      }
  }


  @override
  AuthUser? get currentUser {
    //to get firebase user and convert it into current user
    final user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      return AuthUser.fromFirebase(user);
    }else{
      return null;
    }
  }


  @override
  Future<AuthUser> logIn({required String email, required String password}) async{
   try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    //fr more cnfirmation
    final user = currentUser;
      if(user!=null){
          return user;
        }else{
          throw UserNotLoggedInAuthException;
        }
   }on FirebaseAuthException catch(e){
      if(e.code == 'invalid-credential'){
       throw UserNotFoundAuthException();
      }
      else if(e.code == 'wrong-password'){
       throw WrongPasswordAuthException();
      }
      else{
        throw GenericAuthException();
      }
   }
   catch(_){
        throw GenericAuthException();
   }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      await FirebaseAuth.instance.signOut();
    }else{
      throw UserNotLoggedInAuthException();
    }
    }

  @override
  Future<void> sendEmailVerification() async {
   final user = FirebaseAuth.instance.currentUser;
   if (user!=null){
    await user.sendEmailVerification();
   }else{
    throw UserNotLoggedInAuthException();
   }
  }

}