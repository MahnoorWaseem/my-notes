
//abstract class - abstract classes  contains behaviour ttha can be inherited by subclass thattswhy it allows function deff
//interface whereas describes a set of method signatures, the implementations of which may be provided by multiple classes that are otherwise not necessarily related to each other.
//Interfaces cannot have properties, while abstract classes can
//An interface specifies the syntax that all classes that implements it must follow.
// All interface methods must be public, while abstract class methods is public or protected
// All methods in an interface are abstract, so they cannot be implemented in code and the abstract keyword is not necessary
// Classes can implement an interface while inheriting from another class at the same time
//use implements keywrd not extends
//itt is basically an interface.. that’s why its an interface… you can say that an interface is a contract that guarantees that a class implements all the properties and methods defined in the interface.
//in our case every auth provider should implements or conform to these methods like a contract

//these are the tasks that should be done be the auth prvider that you are using - in ur case its firebase
//i- fetching current user and then abstract away it with our wn user ie authuser
//ii- login functiom which typically reurns a future when successfully completing promise otherwise throws exceptin
//iii- signup
//iv- logout
//v- able to send emails
import 'package:mynotes/services/auth/auth_user.dart';
abstract class AuthProvider{
  AuthUser? get currentUser;
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
}