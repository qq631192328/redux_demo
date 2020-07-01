import 'dart:async';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:async_redux/async_redux.dart';
import 'package:redexdemo/actions/base_actions.dart';
import 'package:redexdemo/actions/main_actions.dart';
import 'package:redexdemo/models/app_state.dart';
import 'package:redexdemo/routes.dart';

class UpdateInputContentAction extends BaseAction {
  final String content;

  UpdateInputContentAction(this.content);

  @override
  AppState reduce() {
    final loginState = this.loginState.clone()..inputContent = content;
    return state.clone()
      ..loginState = loginState;
  }
}

class UpdateButtonEnabledAction extends BaseAction {
  final bool enabled;

  UpdateButtonEnabledAction(this.enabled);

  @override
  AppState reduce() {
    final loginState = this.loginState.clone()..sendBtnEnabled = enabled;
    return state.clone()
      ..loginState = loginState;
  }
}

class UpdateTimeCountAction extends BaseAction {
  final int time;

  UpdateTimeCountAction(this.time);

  @override
  AppState reduce() {
    final loginState = this.loginState.clone()..countdownTime = time;
    return state.clone()
      ..loginState = loginState;
  }

}

class UpdateAccountFormatAction extends BaseAction {
  final bool isCorrect;

  UpdateAccountFormatAction(this.isCorrect);

  @override
  AppState reduce() {
    final loginState = this.loginState.clone()..accountFormatRight = isCorrect;
    return state.clone()
      ..loginState = loginState;
  }

}

class InitLoginPageAction extends BaseAction {
  @override
  AppState reduce() {
    TextEditingController controller = TextEditingController();

    controller.addListener(() {
      print(controller.text);
      var text = controller.text;

      dispatch(UpdateInputContentAction(text));

      final isCorrect = text.length == 11 && RegexUtil.isMobileSimple(text);

      dispatch(UpdateButtonEnabledAction(isCorrect));
      dispatch(UpdateAccountFormatAction(true));
    });

    final _loginState = loginState.clone()
      ..accountFocus = FocusNode()
      ..accountController = controller;
    return state.clone()
      ..loginState = _loginState;
  }
}

class SendCodeAction extends BaseAction {
  BuildContext context;

  SendCodeAction(this.context);

  void before() => dispatch(LoadingAction(true));

  @override
  Future<AppState> reduce() async {
    var mobile = loginState.inputContent;

    // request
    await Future.delayed(Duration(milliseconds: 500));
    dispatch(ShowToastAction('短信已发送, 请查收!'));
    dispatch(NavigateAction.pushNamed(AppRoutes.validationPage));

    return null;
  }

  void after() => dispatch(LoadingAction(false));
}

class StartTimerAction extends BaseAction {
  int time;

  StartTimerAction({this.time = 60});

  @override
  Future<AppState> reduce() async {
    loginState.codeFocus.unfocus();
    loginState.timer?.cancel();

    Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (time > 0) {
        time--;
        dispatch(UpdateTimeCountAction(time));
      } else {
        timer.cancel();
      }
    });

    final _loginState = loginState.clone()..timer = timer;
    return state.clone()..loginState = _loginState;
  }
}

class StopTimerAction extends BaseAction {
  int time;

  StopTimerAction({this.time = 60});

  @override
  AppState reduce() {
    loginState.timer?.cancel();

    final _loginState = loginState.clone()
      ..timer = null
      ..countdownTime = time;
    return state.clone()..loginState = _loginState;
  }
}

class SendCodeAgainAction extends BaseAction {
  BuildContext context;

  SendCodeAgainAction(this.context);

  void before() => dispatch(LoadingAction(true));

  @override
  Future<AppState> reduce() async {
    var mobile = loginState.inputContent;

    dispatch(StartTimerAction());
    dispatch(ShowToastAction('短信已发送, 请查收!'));

    return null;
  }

  void after() => dispatch(LoadingAction(false));
}

class ValidateCodeAction extends BaseAction {
  final String code;

  ValidateCodeAction(this.code);

  @override
  Future<AppState> reduce() async {
    var mobile = loginState.inputContent;
    print('here');

    dispatch(ShowToastAction('🍺登录成功🍺'));
    dispatch(NavigateAction.pop());
    dispatch(SelectUserAction({
      'userId': 'xxxxx'
    }));

    return null;
  }
}

class SelectUserAction extends BaseAction {
  final Map userInfo;

  SelectUserAction(this.userInfo);

  @override
  Future<AppState> reduce() async {
    final _mainState = mainState.clone()..userInfo = userInfo;
    return state.clone()..mainState = _mainState;
  }
}
