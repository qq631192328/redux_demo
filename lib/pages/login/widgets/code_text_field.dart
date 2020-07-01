import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:redexdemo/colors_utils.dart';

class CodeTextField extends StatefulWidget {
  CodeTextField(
      {Key key,
      this.defaultBottomColor,
      this.selectBottomColor,
      this.onChange,
      this.focusNode,
      this.code})
      : super(key: key);

  final String code;
  final FocusNode focusNode;
  final Color defaultBottomColor;
  final Color selectBottomColor;
  final void Function(String code) onChange;

  @override
  _CodeTextFieldState createState() => _CodeTextFieldState();
}

class _CodeTextFieldState extends State<CodeTextField> {
  String _code = '';
  Color _defaultBottomColor;
  Color _selectBottomColor;
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    _defaultBottomColor = widget.defaultBottomColor ?? Color(0x7DDDDDDD);
    _selectBottomColor = widget.selectBottomColor ?? Color(0xFFDDDDDD);
    _textController.addListener(() {
      setState(() {
        _code = _textController.text;
      });
    });
    _textController.text = widget.code;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            margin: EdgeInsets.only(top: 84),
            width: 270,
            height: 60,
            child: Stack(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 48,
                      padding: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: _code.length > 0
                                      ? _selectBottomColor
                                      : _defaultBottomColor,
                                  width: 1))),
                      child: Text(
                        _code.length > 0 ? _code.substring(0, 1) : '',
                        style: TextStyle(
                            fontSize: 36,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: 48,
                      margin: EdgeInsets.only(left: 26),
                      padding: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: _code.length > 1
                                      ? _selectBottomColor
                                      : _defaultBottomColor,
                                  width: 1))),
                      child: Text(
                        _code.length > 1 ? _code.substring(1, 2) : '',
                        style: TextStyle(
                            fontSize: 36,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: 48,
                      margin: EdgeInsets.only(left: 26),
                      padding: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: _code.length > 2
                                      ? _selectBottomColor
                                      : _defaultBottomColor,
                                  width: 1))),
                      child: Text(
                        _code.length > 2 ? _code.substring(2, 3) : '',
                        style: TextStyle(
                            fontSize: 36,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      width: 48,
                      margin: EdgeInsets.only(left: 26),
                      padding: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: _code.length > 3
                                      ? _selectBottomColor
                                      : _defaultBottomColor,
                                  width: 1))),
                      child: Text(
                        _code.length > 3 ? _code.substring(3, 4) : '',
                        style: TextStyle(
                            fontSize: 36,
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                Container(
                  height: 270,
                  child: CupertinoTextField(
                    controller: _textController,
                    style: TextStyle(fontSize: 1, color: Color(0x00FFFFFF)),
                    cursorColor: Color(0x00FFFFFF),
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    focusNode: widget.focusNode,
                    decoration: BoxDecoration(
                      color: const Color(0x00FFFFFF),
                    ),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                    onChanged: widget.onChange,
                  ),
                )
              ],
            )));
  }
}
