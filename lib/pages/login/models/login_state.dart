


import 'dart:async';
import 'package:flutter/cupertino.dart';

class LoginState {
  /// 登录页面
  FocusNode accountFocus;
  String inputContent;
  bool sendBtnEnabled;
  bool accountFormatRight;
  TextEditingController accountController;

  /// 验证码页面
  Timer timer;
  FocusNode codeFocus;
  bool showPassAlert;
  int countdownTime;
  bool showCodeErrorAlert;

  LoginState({
    this.accountFocus,
    this.inputContent,
    this.sendBtnEnabled,
    this.accountController,
    this.accountFormatRight,
    this.timer,
    this.codeFocus,
    this.showPassAlert,
    this.countdownTime,
    this.showCodeErrorAlert,
  });

  static LoginState initialState() => LoginState(
    accountFocus: FocusNode(),
    inputContent: null,
    sendBtnEnabled: false,
    accountController: null,
    accountFormatRight: true,
    timer: null,
    codeFocus: FocusNode(),
    showPassAlert: false,
    countdownTime: 60,
    showCodeErrorAlert: false,
  );


  LoginState clone() =>
      LoginState()
        ..timer = timer
        ..codeFocus = codeFocus
        ..accountFocus = accountFocus
        ..inputContent = inputContent
        ..showPassAlert = showPassAlert
        ..countdownTime = countdownTime
        ..sendBtnEnabled = sendBtnEnabled
        ..accountController = accountController
        ..accountFormatRight = accountFormatRight
        ..showCodeErrorAlert = showCodeErrorAlert;

}
