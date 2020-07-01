
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:redexdemo/models/app_state.dart';
import 'base_actions.dart';
import 'package:bot_toast/bot_toast.dart';

class LoadingAction extends BaseAction {
  final bool visable;
  LoadingAction(this.visable);

  @override
  FutureOr<AppState> reduce() {
    if (visable)
      BotToast.showLoading();
    else
      BotToast.closeAllLoading();
    return null;
  }

}


class ShowToastAction extends BaseAction {
  final String info;
  ShowToastAction(this.info);

  @override
  FutureOr<AppState> reduce() {
    BotToast.showText(text: info);

    return null;
  }
}