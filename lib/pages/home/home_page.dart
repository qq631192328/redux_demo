
import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('主页'),
        backgroundColor: CupertinoColors.white,
      ),
      child: Container(),
    );
  }
}
