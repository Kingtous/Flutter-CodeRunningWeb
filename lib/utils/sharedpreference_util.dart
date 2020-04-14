import 'package:code_running_front/application/application.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences sp() {
  return Application.sp;
}
