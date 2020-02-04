import 'package:code_running_front/router/my_router.gr.dart';
import 'package:code_running_front/third_libs_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  ThirdLibsManager.get().setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Makes Better',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: Router.onGenerateRoute,
      initialRoute: Router.indexRoute,
    );
  }
}
