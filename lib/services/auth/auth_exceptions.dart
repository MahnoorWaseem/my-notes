//login exceptions (in try catch)
class UserNotFoundAuthException implements Exception{}

class WrongPasswordAuthException implements Exception{}

//register exceptions
class WeakPasswordAuthException implements Exception{}

class EmailAlreadyInUseAuthException implements Exception{}

class InvalidEmailAuthException implements Exception{}

//generic exceptions
class GenericAuthException implements Exception{}

class UserNotLoggedInAuthException implements Exception{}
//like a exception that can be thrown when user is successfully reg and still the curentt user s null (ie by default reg krny k bad login nhi hoska as it is default behaviour in dart), can be because of network error, may be the state is not updatted etc...







 