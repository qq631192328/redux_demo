import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:redexdemo/app.dart';
import 'package:redexdemo/store.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    print(flutterErrorDetails.toString());
    return Container(
      child: Center(
        child: Text(
          "Flutter 崩溃了",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  };

  NavigateAction.setNavigatorKey(navigatorKey);

  runApp(App(store: store, navigatorKey: navigatorKey));
}
