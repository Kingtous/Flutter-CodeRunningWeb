import 'package:auto_route/auto_route.dart';
import 'package:code_running_front/application/application.dart';
import 'package:code_running_front/router/my_router.gr.dart';
import 'package:code_running_front/third_libs_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  ThirdLibsManager.get().setup();
  SharedPreferences.getInstance().then((value) =>
  {
    Application.sp = value,
    runApp(MyApp())
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '码上社区-Coder Community',
        theme: ThemeData(
            brightness: Brightness.light,
            accentColor: Colors.blueAccent,
            primaryColor: Colors.black
        ),
        builder: ExtendedNavigator<Router>(router: Router())
    );
  }
}
