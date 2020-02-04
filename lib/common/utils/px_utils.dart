import 'package:flutter_screenutil/flutter_screenutil.dart';

double w(double pxW) {
  return ScreenUtil().setWidth(pxW);
}

double h(double pxH) {
  return ScreenUtil().setHeight(pxH);
}

double sp(double px) {
  return ScreenUtil().setSp(px);
}
