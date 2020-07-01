
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:async_redux/async_redux.dart';
import 'package:redexdemo/colors_utils.dart';
import 'package:redexdemo/models/app_state.dart';

import 'actions/login_actions.dart';
import 'models/login_state.dart';
import 'viewmodel/view_model.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginViewModel>(
      onInit: (store) {
        store.dispatch(InitLoginPageAction());
      },
      model: LoginViewModel(),
      builder: (context, vm) {
        return CupertinoPageScaffold(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Container(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 112, left: 52),
                            child: Text('欢迎登录',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 9, left: 52),
                            child: Text(
                              'Redux',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 72),
                        child: Stack(
                          children: <Widget>[
                            vm.loginState?.inputContent?.length == 0
                                ? Container()
                                : Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 52),
                                  child: Text(
                                    vm.loginState.accountFormatRight
                                        ? '输入手机号'
                                        : '手机号不存在，请重新输入',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: vm.loginState
                                            .accountFormatRight
                                            ? AppColors.darkGreyColor
                                            : const Color(0xFFF25642)),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin:
                              EdgeInsets.only(top: 8, left: 47, right: 50),
                              height: 44,
                              child: CupertinoTextField(
                                  controller: vm.loginState?.accountController,
                                  focusNode: vm.loginState?.accountFocus,
                                  maxLength: 11,
                                  autocorrect: true, //是否自动更正
                                  clearButtonMode:
                                  OverlayVisibilityMode.editing,
                                  placeholder: '请输入手机号码',
                                  style: TextStyle(
                                      fontSize: 16.0,),
                                  inputFormatters: <TextInputFormatter>[
                                    WhitelistingTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: BoxDecoration(
                                    color: const Color(0x00FFFFFF),
                                  )),
                            ),
                            Container(
                              margin:
                              EdgeInsets.only(top: 52, left: 52, right: 50),
                              color: Color(0xFFBCBBC1),
                              height: 0.5,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 60, left: 51),
                                  child: RichText(
                                      text: TextSpan(
                                          text: '登录代表你同意',
                                          style: TextStyle(
                                              fontSize: 13),
                                          children: [
                                            TextSpan(
                                              text: '《坎德拉用户协议》',
                                              style: TextStyle(
                                                  fontSize: 13),
                                            )
                                          ])),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin:
                              EdgeInsets.only(top: 28, left: 52, right: 52),
                              height: 40,
                              child: CupertinoButton(
                                  padding: EdgeInsets.all(0),
                                  color: CupertinoColors.activeBlue,
                                  onPressed: vm.loginState.sendBtnEnabled
                                      ? () => vm.call(SendCodeAction(context)) : null,
                                  disabledColor: const Color(0x55132547),
                                  borderRadius: BorderRadius.circular(2),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text('获取短信验证码',
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: const Color(0xFFFFFFFF))),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
