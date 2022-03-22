abstract class RegisterStates{}

class InitialShopStates extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{}
class ChangeScreensLogInState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterGetImageState extends RegisterStates{}

class ChangeRadioButtonState extends RegisterStates{}

class ChangeSwitchValueState extends RegisterStates{}

class RegisterErrorState extends RegisterStates{
  String error;
  RegisterErrorState(this.error);
}
class LoginSuccessState extends RegisterStates{}

class LoginLoadingState extends RegisterStates{}

class LoginErrorState extends RegisterStates{
  String error;
  LoginErrorState(this.error);
}
class ForgetPassSuccessState extends RegisterStates{}

class ForgetPassLoadingState extends RegisterStates{}

class ForgetPassErrorState extends RegisterStates{
  String error;
  ForgetPassErrorState(this.error);
}
class ResetPassSuccessState extends RegisterStates{}

class ResetPassLoadingState extends RegisterStates{}

class LangChangeState extends RegisterStates{}

class ResetPassErrorState extends RegisterStates{
  String error;
  ResetPassErrorState(this.error);
}