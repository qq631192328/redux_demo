import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';


class TextFieldItem extends StatefulWidget {
  final String tip;
  final bool isError;
  final int maxLength;
  final Widget suffix;
  final bool password;
  final String errorTip;
  final bool isOnlyDigits;
  final String placeholder;
  final FocusNode focusNode;
  final bool Function(String value) verifyFunc;
  final void Function(String value) onChange;
  final TextEditingController editingController;

  TextFieldItem(
      {Key key,
      this.tip,
      this.placeholder,
      this.editingController,
      this.maxLength,
      this.isOnlyDigits,
      this.suffix,
      this.errorTip,
      this.isError,
      this.verifyFunc,
      this.onChange,
      this.focusNode,
      this.password = false})
      : super(key: key);
  @override
  _TextFieldItemState createState() => _TextFieldItemState();
}

class _TextFieldItemState extends State<TextFieldItem> {
  bool _tipShow = false;
  bool _isError = false;
  bool _clearBtnShow = false;

  @override
  void initState() {
    widget.editingController.addListener(() {
      if (widget.onChange != null) {
        widget.onChange(widget.editingController?.text ?? '');
      }

      setState(() {
        if (widget.verifyFunc != null) {
          _isError = widget.verifyFunc(widget.editingController?.text ?? '');
        }
        _tipShow = (widget.editingController?.text ?? '').length > 0 ||
            _isError ||
            (widget.isError ?? false);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        child: Stack(
          children: <Widget>[
            _tipShow
                ? Container(
                    margin: EdgeInsets.only(top: 0, left: 6),
                    child: Row(
                      children: <Widget>[
                        Text(
                            (_isError || (widget.isError ?? false))
                                ? widget.errorTip
                                : widget.tip,
                            style: TextStyle(
                                fontSize: 10,
                                color: (_isError || (widget.isError ?? false))
                                    ? CupertinoColors.destructiveRed
                                    : CupertinoColors.systemGrey2))
                      ],
                    ))
                : Container(),
            Container(
              margin: EdgeInsets.only(top: 6, left: 0, right: 0),
              height: 50,
              child: CupertinoTextField(
                controller: widget.editingController,
                focusNode: widget.focusNode,
                placeholder: widget.placeholder,
                placeholderStyle: TextStyle(color: Color(0xFF536073)),
                maxLength: widget.maxLength ?? 100,
                style: TextStyle(fontSize: 16),
                inputFormatters: widget.isOnlyDigits ?? false
                    ? <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly,
                      ]
                    : [],
                suffix: widget.suffix ?? Container(),
                obscureText: widget.password,
                decoration: BoxDecoration(
                  color: const Color(0x00FFFFFF),
                ),
                onChanged: (str) {
                  setState(() {
                    _tipShow = str.length > 0;
                    _clearBtnShow = str.length > 0;
                  });
                },
              ),
            ),
            _clearBtnShow
                ? Row(
                    textDirection: TextDirection.rtl,
                    children: <Widget>[
                      Container(
                        alignment: AlignmentDirectional.centerEnd,
                        margin: EdgeInsets.only(top: 16, right: 8),
                        width: 24,
                        height: 24,
                        child: CupertinoButton(
                            padding: EdgeInsets.all(0),
                            child: Image.asset(
                                'assets/images/control/icon_textfield_clear.png'),
                            onPressed: () {
                              widget.editingController.text = '';
                              setState(() {
                                _tipShow = false;
                                _clearBtnShow = false;
                              });
                            }),
                      )
                    ],
                  )
                : Container(),
            Container(
              height: 0.5,
              color: const Color(0x66333333),
              margin: EdgeInsets.only(top: 49, left: 6, right: 6),
            )
          ],
        ));
  }
}
