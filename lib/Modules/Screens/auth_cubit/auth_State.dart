abstract class AuthStates {}
class AuthInitialState extends AuthStates{}

class RegisterLoadingState extends AuthStates{}
class RegisterSuccessState extends AuthStates{}
class FailedRegisterState extends AuthStates{
  String message;
  FailedRegisterState({required this.message});
}

class LoginLoadingState extends AuthStates{}
class LoginSuccessState extends AuthStates{}
class FailedToLoginState extends AuthStates{
  final String message;
  FailedToLoginState({required this.message});
}


