import 'package:flutter/cupertino.dart';
import 'package:async_redux/async_redux.dart';
import 'package:redexdemo/colors_utils.dart';
import 'package:redexdemo/models/app_state.dart';
import 'package:redexdemo/pages/login/viewmodel/view_model.dart';
import 'package:redexdemo/pages/login/widgets/code_text_field.dart';

import 'actions/login_actions.dart';
import 'models/login_state.dart';


class ValidationPage extends StatefulWidget {
  @override
  _CodeValidationState createState() => _CodeValidationState();
}

class _CodeValidationState extends State<ValidationPage> {

  String mobileFormate(String mobile) {
    if (mobile.length != 11) {
      return '';
    }

    return mobile.substring(0, 3) +
        ' ' +
        mobile.substring(3, 7) +
        ' ' +
        mobile.substring(7, 11);
  }

  /// 倒计时按钮
  Widget buildCountDownBtn(BuildContext context, LoginViewModel vm) {
    if (vm.loginState.countdownTime == 0) {
      return CupertinoButton(
          onPressed: () => vm.call(SendCodeAgainAction(context)),
          child: Text('重新获取', style: TextStyle(color: AppColors.primaryColor)));
    } else {
      return RichText(
          text: TextSpan(
              text: '${vm.loginState.countdownTime}S',
              style: TextStyle(color: AppColors.primaryColor),
              children: [
            TextSpan(
              text: ' 后可重新获取',
              style: TextStyle(color: AppColors.textGreyColor),
            )
          ]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LoginViewModel>(
      onInit: (store) {
        store.dispatch(StartTimerAction());
      },
      onDispose: (store) {
        store.dispatch(StopTimerAction());
      },
      model: LoginViewModel(),
      builder: (context, vm) {
        return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              previousPageTitle: '登录',
              middle: Text('验证手机号'),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 120, left: 52),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '请输入短信验证码',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColor),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 12, left: 52),
                        child: Row(
                          children: <Widget>[
                            RichText(
                                text: TextSpan(
                                    text: '验证码已经发送至手机号 ',
                                    style:
                                        TextStyle(color: AppColors.textColor),
                                    children: [
                                  TextSpan(
                                    text: mobileFormate(
                                        vm.loginState.inputContent),
                                    style: TextStyle(
                                        color: AppColors.primaryColor),
                                  )
                                ])),
                          ],
                        )),
                    CodeTextField(
                      focusNode: vm.loginState.codeFocus,
                      onChange: (code) {
                        if (code.length > 3) {
                          vm.loginState.codeFocus?.unfocus();
                          print('here 111');
                          vm.call(ValidateCodeAction(code));
                        }
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 24),
                      child: Center(child: buildCountDownBtn(context, vm)),
                    )
                  ],
                ),
              ],
            ));
      },
    );
  }
}
