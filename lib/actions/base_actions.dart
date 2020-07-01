import 'package:async_redux/async_redux.dart';
import 'package:redexdemo/models/app_state.dart';
import 'package:redexdemo/models/main_state.dart';
import 'package:redexdemo/pages/home/models/home_state.dart';
import 'package:redexdemo/pages/login/models/login_state.dart';

abstract class BaseAction extends ReduxAction<AppState> {
  LoginState get loginState => state.loginState;
  MainState get mainState => state.mainState;
  HomeState get homeState => state.homeState;

}
