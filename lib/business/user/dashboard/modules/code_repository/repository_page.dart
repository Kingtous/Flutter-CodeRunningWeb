import 'dart:js' as js;

import 'package:after_layout/after_layout.dart';
import 'package:code_running_front/business/user/models/request/req_get_repository_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_repository_entity.dart';
import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/common/network/http_utils.dart';
import 'package:code_running_front/common/utils/toast_utils.dart';
import 'package:code_running_front/res/styles.dart';
import 'package:code_running_front/ui/image_load_view.dart';
import 'package:code_running_front/utils/enum.dart';
import 'package:code_running_front/utils/user_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load/load.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:universal_html/html.dart';

import 'get/bloc.dart';
import 'get/get_repository_bloc.dart';

class RepositoryPage extends StatefulWidget {
  @override
  _RepositoryPageState createState() => _RepositoryPageState();
}

class _RepositoryPageState extends BaseLoadingPageState<RepositoryPage>
    with AfterLayoutMixin {
  var _scrollController = ScrollController();

  bool get wantKeepAlive => false;

  GetRepositoryBloc _bloc;

  var offset = 0;
  var lastDataNums = -1;

  List<RespGetRepositoryData> _data = List<RespGetRepositoryData>();

  var _refreshController = RefreshController();

  String codeContent = "";

  @override
  void initState() {
    super.initState();
    _bloc = GetRepositoryBloc();
    _bloc.add(InGetRepositoryEvent(ReqGetRepositoryEntity()..offset = 0));
  }

  @override
  void dispose() {
    _bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("我的码库"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            ImageLoadView(
              "images/background/02.jpg",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              placeholder: "images/background/02.jpg",
              imageType: ImageType.assets,
            ),
            Container(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Card(
                        elevation: 10,
                        child: Container(
                          height: 800,
                          padding: EdgeInsets.all(32),
                          child: BlocBuilder(
                            bloc: _bloc,
                            builder: (BuildContext context, state) {
                              if (state is GetRepositoryedState) {
                                hideLoadingDialog();
                                _refreshController.loadComplete();
                                Future.delayed(Duration(seconds: 0), () {
                                  _scrollController.jumpTo(_scrollOffset);
                                });
                                return SmartRefresher(
                                  enablePullDown: false,
                                  enablePullUp: true,
                                  header: WaterDropHeader(),
                                  controller: _refreshController,
                                  onLoading: _onLoading,
                                  child: ListView.builder(
                                    controller: _scrollController,
                                    itemBuilder: (context, index) {
                                      return buildCodeListItem(
                                          state.entity.data[index]);
                                    },
                                    itemCount: state.entity.data.length,
                                  ),
                                );
                              } else if (state is InGetRepositoryState) {
                                _refreshController.loadFailed();
                                showLoadingDialog();
                              } else if (state is NoGetRepositoryState) {
                                _refreshController.loadFailed();
                                showError(msg: state.msg ?? "");
                              }
                              return SizedBox(
                                width: 0,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Card(
                      elevation: 10,
                      child: Container(
                        padding: EdgeInsets.all(32),
                        height: 800,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: <Widget>[
                            SingleChildScrollView(
                                child: Text(
                              codeContent == "" ? "无内容或未选择文件查看" : codeContent,
                              overflow: TextOverflow.clip,
                              style: TextStyle(fontSize: 16),
                            )),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: FlatButton(
                                  onPressed: handleCopyToClipBoard,
                                  child: Text("复制")),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void preparedPage() {}

  Widget buildCodeListItem(RespGetRepositoryData data) {
    return Column(
      key: ValueKey(data.hashCode),
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Divider(height: 1),
        Row(
          children: <Widget>[
            Text('ID：${data.id}'),
            Gaps.hGap(4),
            Text(
                '(${data.codeType == 3 ? "Python3" : data.codeType == 2 ? "Java" : "C++"})'),
            Expanded(
                child: Text(
              '创建时间：${DateTime.fromMillisecondsSinceEpoch(data.createDate * 1000).toString()}',
              textAlign: TextAlign.right,
            )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
                onPressed: () => handleLook(data.localPath), child: Text("查看")),
            FlatButton(
                onPressed: () => handleDownload(data.localPath),
                child: Text("下载")),
          ],
        ),
      ],
    );
  }

  void handleDownload(String path) {
    js.context.callMethod("open", ["$path?token=${getUserInfo().token}"]);
  }

  void handleLook(String path) async {
    Response<dynamic> resp = await HttpUtils.get()
        .req("$path?token=${getUserInfo().token}", method: "get");
    setState(() {
      codeContent = resp.data.toString();
    });
  }

  double _scrollOffset = 0;

  /// 加载
  void _onLoading() {
    _scrollOffset = _scrollController.offset;
    debugPrint('$offset');
    offset += 10;
    _bloc.add(InGetRepositoryEvent(ReqGetRepositoryEntity()..offset = offset));
  }

  @override
  void afterFirstLayout(BuildContext context) {
//    Future.delayed(Duration(milliseconds: 500),(){
//      debugPrint("load");
//      _refreshController.requestLoading();
//    });
  }

  void handleCopyToClipBoard() async {
    Clipboard.setData(ClipboardData(text: codeContent)).then((value) {
      ToastUtils.show("复制成功");
    });
  }
}
