import 'package:flutter/material.dart';

class SevenTextField extends StatefulWidget {
  SevenTextField(
      {Key key,
      this.width,
      this.height,
      this.onChanged,
      this.textEditingController,
      this.isPassword,
        this.onEditComplete,
        this.labelText,
        this.icon})
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

  @override
  _SevenTextFieldState createState() => _SevenTextFieldState();
}

class _SevenTextFieldState extends State<SevenTextField> {
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
        alignment: Alignment.center,
        height: widget.height,
        width: widget.width,
        child: Stack(
          children: <Widget>[
            Center(
              child: TextField(
                style: TextStyle(fontSize: 16),
                cursorColor: Colors.black,
                onEditingComplete: widget.onEditComplete,
                cursorWidth: 1,
                maxLength: 16,
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
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(90)),
                  ),
                  labelStyle: TextStyle(fontSize: 16),
                  labelText: widget.labelText,
                  hoverColor: Colors.black,
                  prefixIcon: widget.icon,
                ),
              ),
            ),
            widget.isPassword
                ? GestureDetector(
              onTap: () {
                setState(() {
                  _hidePassword = !_hidePassword;
                });
              },
              child: Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 16.0, bottom: 16),
                child: _hidePassword
                    ? Icon(Icons.remove_red_eye)
                    : Icon(Icons.panorama_fish_eye),
              ),
            )
                : SizedBox(
              width: 0,
            )
          ],
        ));
  }
}
