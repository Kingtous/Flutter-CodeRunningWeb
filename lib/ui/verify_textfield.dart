
import 'package:code_running_front/common/utils/px_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SmsTextField extends StatefulWidget {
  SmsTextField({Key key,
    this.width,
    this.height,
    this.onChanged,
    this.textEditingController,
    this.isPassword,
    this.onEditComplete,
    this.right, this.labelText, this.icon})
      : assert(width != null),
        assert(height != null),
        assert(onChanged != null),
        assert(textEditingController != null),
        assert(isPassword != null),
        assert(onEditComplete != null),
        super(key: key);

  final String labelText;
  final Widget icon;
  final double width;
  final double height;
  final Function(String text) onChanged;
  final TextEditingController textEditingController;
  final bool isPassword;
  final Function() onEditComplete;
  final Widget right;

  @override
  _SmsTextFieldState createState() => _SmsTextFieldState();
}

class _SmsTextFieldState extends State<SmsTextField> {
  bool _isEmpty = true;

  bool _hidePassword = true;

  @override
  void initState() {
    super.initState();
    _hidePassword = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        width: widget.width,
        child: Stack(
          children: <Widget>[
            Center(
              child: TextField(
                  style: TextStyle(
                      fontSize: sp(42)
                  ),
                  inputFormatters: [LengthLimitingTextInputFormatter(6)],
                  cursorColor: Colors.black,
                  onEditingComplete: widget.onEditComplete,
                  cursorWidth: 1,
                  controller: widget.textEditingController,
                  onChanged: (s) {
                    var str = s.trim();
                    if (str.length != 0) {
                      _isEmpty = false;
                    } else {
                      _isEmpty = true;
                    }
                    widget.onChanged(str);
                  },
                  obscureText: _hidePassword,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(90)),
                  ),
                  labelStyle: TextStyle(fontSize: sp(42)),
                  labelText: widget.labelText,
                  hoverColor: Colors.black,
                  prefixIcon: widget.icon,
                ),
              ),
            ),
            Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(
                    top: h(16), bottom: h(16), right: w(10)),
                child: widget.right)
          ],
        ));
  }
}
