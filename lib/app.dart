import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:async_redux/async_redux.dart';
import 'package:redexdemo/pages/home/home_page.dart';
import 'package:redexdemo/pages/login/login_page.dart';
import 'package:redexdemo/routes.dart';
import 'models/app_state.dart';


class App extends StatelessWidget {
  final Store<AppState> store;
  final GlobalKey navigatorKey;

  App({this.store, this.navigatorKey}) : super();

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        model: _ViewModel(),
        builder: (context, vm) {
          print('vm.isLogin: ${vm.isLogin}');
          return CupertinoApp(
            title: 'Redux Demo',
            routes: routes,
            navigatorKey: navigatorKey,
            navigatorObservers: [BotToastNavigatorObserver()],
            builder: BotToastInit(),
            home: UserExceptionDialog<AppState>(
              child: vm.isLogin ? HomePage() : LoginPage(),
            ),
          );
        },
      ),
    );
  }

}

class _ViewModel extends BaseModel<AppState> {
  _ViewModel();

  bool isLogin;

  _ViewModel.build({
    @required this.isLogin,
  }) : super(equals: [isLogin]);

  @override
  _ViewModel fromStore() {
    return new _ViewModel.build(
      isLogin: state.mainState.userInfo != null,
    );
  }
}
