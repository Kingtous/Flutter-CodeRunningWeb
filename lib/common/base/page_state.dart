import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:code_running_front/common/widgets/success_dialog.dart';
import 'package:code_running_front/router/my_router.gr.dart';
import 'package:code_running_front/utils/sharedpreference_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:load/load.dart';

import 'mvp.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {}

abstract class BasePageState<T extends StatefulWidget> extends State<T> {}

class BaseKeepAlivePageState<T extends StatefulWidget> extends BasePageState<T>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
}

/// 如果不想 keep alive 要 重写 bool get wantKeepAlive => false;
abstract class BaseLoadingPageState<T extends StatefulWidget>
    extends BaseKeepAlivePageState<T>
    with WidgetsBindingObserver
    implements ILoadingView {
  bool _isPrepared = false;

  ///*****************************************************/

  @mustCallSuper
  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (!_isPrepared) {
      Timer.run(() => preparedPage());
      _isPrepared = true;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @mustCallSuper
  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  ///  初始化一次 => 用于 presenter 请求网络数据后 调用 show dialog 拿不到合适的 context 报错
  void preparedPage();

  @override
  void reload() {}

  @override
  void renderPage(Object o) {}

  @override
  void showDisconnect() {}

  @override
  void showError({String msg}) {
    showDialog(
        context: context, builder: (_) =>
        FlareGiffyDialog(
          flarePath: 'animations/status/space.flr',
          flareAnimation: 'Untitled',
          title: Text('注册失败',
            style: TextStyle(
                fontSize: 22.0, fontWeight: FontWeight.w600),
          ),
          description: Text(msg
          ),
          entryAnimation: EntryAnimation.DEFAULT,
          onOkButtonPressed: () {
            ExtendedNavigator.ofRouter<Router>().pop();
          },
        ));
  }

  @override
  void showLoading({String msg}) {
    /// 把 dialog 的 show 从 普通页面里分离
    showLoadingDialog();
  }

  @override
  void showSuccess({String msg}) {
    /// 把 dialog 的 show 从 普通页面里分离
    var dialog = SuccessDialog(
      //调用对话框
      text: msg == null ? '成功' : msg,
    );
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return dialog;
        });
    // 显示2s后退出
    Timer(Duration(milliseconds: 2000), () => Navigator.pop(context));
  }

  @override
  void closeLoading() {
    /// 必须和 showLoading 方法配对使用 ，避免 pop 当前页面
    hideLoadingDialog();
  }

  /// 只是弹出页面，不与后端交付
  @override
  void logOut() async {
    await sp().remove("user");
    ExtendedNavigator.ofRouter<Router>().pushNamedAndRemoveUntil(
        Routes.indexRoute, (route) => false);
  }
}
