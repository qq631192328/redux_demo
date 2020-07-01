

class MainState {

  Map userInfo;

  MainState clone()
    => MainState()
      ..userInfo = userInfo;

  static MainState initialState()
    => MainState()
      ..userInfo = null;

}