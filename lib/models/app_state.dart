

import 'package:redexdemo/models/main_state.dart';
import 'package:redexdemo/pages/home/models/home_state.dart';
import 'package:redexdemo/pages/login/models/login_state.dart';

class AppState {

  LoginState loginState;

  // 首页状态
  HomeState homeState;

  // 全局通用状态  【包括 loading、环境、tabBar 等信息】
  MainState mainState;

  AppState({
    this.loginState,
    this.homeState,
    this.mainState,
  });

  static AppState initialState() => AppState(
    loginState: LoginState.initialState(),
    mainState: MainState.initialState(),
    homeState: HomeState.initialState(),
  );

  AppState clone() =>
      AppState()
        ..loginState = loginState
        ..homeState = homeState
        ..mainState = mainState;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              loginState == other.loginState &&
              mainState == other.mainState &&
              homeState == other.homeState;

  @override
  int get hashCode =>
      loginState.hashCode ^
      mainState.hashCode ^
      homeState.hashCode;
}