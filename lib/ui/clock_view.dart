import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

///
/// 自定义时钟控件：可用于首页时钟动画
///

class ClockView extends StatefulWidget{
  final double radius;//半径
//  final Color handColor;
//  final Color numberColor;
//  final Color borderColor;

  const ClockView(
      {Key key,
//        this.handColor = Colors.black,
//        this.numberColor = Colors.black,
//        this.borderColor = Colors.black,
        this.radius = 124.5})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ClockViewState();

}

class ClockViewState extends State<ClockView>{

  DateTime dateTime;
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateTime = DateTime.now();
    timer = Timer.periodic(Duration(seconds: 1), (timer){
      setState(() {
        dateTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CustomPaint(
      painter: Clock(dateTime, radius: widget.radius),
      size: Size(widget.radius * 2,widget.radius * 2),
    );
  }
}

class Clock extends CustomPainter {
  Color handColor = Colors.black;//指针颜色
//  Color numberColor = Colors.black;//表盘字体颜色
  Color borderColor = Colors.black;//边框颜色
  double radius = 124.5;//半径

  List<Offset> secondsOffset = [];//存放各个刻度点的集合
  List<Offset> secondsOffset1 = [];//存放各个刻度点的集合

  final DateTime datetime;

//  TextPainter textPainter;
//  double angle;
  double borderWidth;

  Clock(this.datetime, {this.radius = 124.5,}) {

    borderWidth = radius / 8;//时钟边框的粗细

    final secondDistance = radius - borderWidth * 1.5;//计算秒针的长度

    for (var i = 0; i < 60; i++) {
      Offset offset, offset1;
      if(i % 15 == 0){
        offset = Offset(
            cos(degToRad(6 * i - 90)) * secondDistance + radius,
            sin(degToRad(6 * i - 90)) * secondDistance + radius);

        offset1 = Offset(
            cos(degToRad(6 * i - 90)) * (secondDistance-borderWidth*1.5) + radius,
            sin(degToRad(6 * i - 90)) * (secondDistance-borderWidth*1.5) + radius);
      }else{
        offset = Offset(
            cos(degToRad(6 * i - 90)) * secondDistance + radius,
            sin(degToRad(6 * i - 90)) * secondDistance + radius);

        offset1 = Offset(
            cos(degToRad(6 * i - 90)) * (secondDistance-borderWidth) + radius,
            sin(degToRad(6 * i - 90)) * (secondDistance-borderWidth) + radius);
      }
      secondsOffset.add(offset);
      secondsOffset1.add(offset1);
    }

//    textPainter = new TextPainter(
//      textAlign: TextAlign.center,
//      textDirection: TextDirection.rtl,
//    );
//    angle = degToRad(360 / 60);
  }

  @override
  void paint(Canvas canvas, Size size) {
    //("Clock-----------${size.width}---------${size.height}");

    final scale = radius / 150;

    //画Clock外框圆
    final borderPaint = Paint()
      ..color = Color.fromARGB(255, 30, 30, 30)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    canvas.drawCircle(
        Offset(radius, radius), radius - borderWidth / 2, borderPaint);


    if (secondsOffset.length > 0) {
      //所有刻度点
      //canvas.drawPoints(PointMode.points, secondsOffset, secondPPaint);

      final biggerPaint = Paint()
        ..strokeWidth = 7 * scale
        ..color = Color.fromARGB(255, 92, 92, 92);

      final biggerPaint1 = Paint()
        ..strokeWidth = 14 * scale
        ..color = Color.fromARGB(255, 92, 92, 92);

      for (var i = 0; i < secondsOffset.length; i++) {
        if (i % 5 == 0) {
          canvas.drawLine(secondsOffset[i], secondsOffset1[i], biggerPaint);
          //画数字
//          canvas.save();
//          canvas.translate(0.0, -radius + borderWidth * 4);
//          textPainter.text = new TextSpan(
//            text: "${(i ~/ 5) == 0 ? "12" : (i ~/ 5)}",
//            style: TextStyle(
//              color: numberColor,
//              fontFamily: 'Times New Roman',
//              fontSize: 28.0 * scale,
//            ),
//          );
//          //helps make the text painted vertically
//          canvas.rotate(-angle * i);
//          textPainter.layout();
//          textPainter.paint(canvas,
//              new Offset(-(textPainter.width / 2), -(textPainter.height / 2)));
//          canvas.restore();
        }
        if(i % 15 == 0) {
          canvas.drawLine(secondsOffset[i], secondsOffset1[i], biggerPaint1);
        }
        //canvas.rotate(angle);
      }

      //画准点时刻比较粗的点
//      final biggerPaint = Paint()
//        ..strokeWidth = 5 * scale
//        ..color = numberColor;
//
//      canvas.drawPoints(PointMode.points, bigger, biggerPaint);
    }

    final hour = datetime.hour;
    final minute = datetime.minute;
    //final second = datetime.second;

    // 画时针
    Offset hourHand1 = Offset(
        radius - cos(degToRad(360 / 12 * (hour + minute/60) - 90)) * (radius * 0.1),
        radius - sin(degToRad(360 / 12 * (hour + minute/60) - 90)) * (radius * 0.1));
    Offset hourHand2 = Offset(
        radius + cos(degToRad(360 / 12 * (hour + minute/60) - 90)) * (radius * 0.3),
        radius + sin(degToRad(360 / 12 * (hour + minute/60) - 90)) * (radius * 0.3));
    final hourPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4 * scale;
    canvas.drawLine(hourHand1, hourHand2, hourPaint);

    // 画分针
    Offset minuteHand1 = Offset(
        radius - cos(degToRad(360 / 60 * minute - 90)) * (radius * 0.1),
        radius - sin(degToRad(360 / 60 * minute - 90)) * (radius * 0.1));
    Offset minuteHand2 = Offset(
        radius +
            cos(degToRad(360 / 60 * minute - 90)) * (radius - borderWidth * 3.6),
        radius +
            sin(degToRad(360 / 60 * minute - 90)) * (radius - borderWidth * 3.6));
    final minutePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4 * scale;
    canvas.drawLine(minuteHand1, minuteHand2, minutePaint);

    // 画秒针
//    Offset secondHand1 = Offset(
//        radius - cos(degToRad(360 / 60 * second - 90)) * (radius * 0.3),
//        radius - sin(degToRad(360 / 60 * second - 90)) * (radius * 0.3));
//    Offset secondHand2 = Offset(
//        radius +
//            cos(degToRad(360 / 60 * second - 90)) * (radius - borderWidth * 3),
//        radius +
//            sin(degToRad(360 / 60 * second - 90)) * (radius - borderWidth * 3));
//    final secondPaint = Paint()
//      ..color = handColor
//      ..strokeWidth = 1 * scale;
//    canvas.drawLine(secondHand1, secondHand2, secondPaint);

    //画中心的圆
//    final centerPaint = Paint()
//      ..strokeWidth = 2 * scale
//      ..style = PaintingStyle.stroke
//      ..color = Colors.yellow;
//    canvas.drawCircle(Offset(radius, radius), 4 * scale, centerPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

num degToRad(num deg) => deg * (pi / 180.0);

num radToDeg(num rad) => rad * (180.0 / pi);