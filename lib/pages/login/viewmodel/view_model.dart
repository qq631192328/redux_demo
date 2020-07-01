
import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:redexdemo/models/app_state.dart';
import 'package:redexdemo/pages/login/models/login_state.dart';

class LoginViewModel extends BaseModel<AppState> {
  LoginViewModel();

  LoginState loginState;
  Function(ReduxAction<AppState>) call;

  LoginViewModel.build({
    @required this.loginState,
    @required this.call,
  }) : super(equals: [loginState]);

  @override
  LoginViewModel fromStore() {
    return new LoginViewModel.build(
      loginState: state.loginState,
      call: dispatch,
    );
  }
}