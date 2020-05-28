import 'package:code_running_front/business/user/dashboard/modules/ground/threads/post/bloc.dart';
import 'package:code_running_front/business/user/models/request/req_get_threads_entity.dart';
import 'package:code_running_front/business/user/models/request/req_post_thread_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_threads_entity.dart';
import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/res/styles.dart';
import 'package:code_running_front/router/my_router.gr.dart';
import 'package:code_running_front/ui/image_load_view.dart';
import 'package:code_running_front/ui/nav_util.dart';
import 'package:code_running_front/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load/load.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'threads/get/bloc.dart';

class ThreadGroundPage extends StatefulWidget {
  @override
  _ThreadGroundPageState createState() => _ThreadGroundPageState();
}

class _ThreadGroundPageState extends BaseLoadingPageState<ThreadGroundPage> {
  GetThreadsBloc _bloc;
  PostThreadBloc _pbloc;
  var page = 1;

  var _refreshController = RefreshController();

  var _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _bloc = GetThreadsBloc();
    _bloc.add(InGetThreadsEvent(ReqGetThreadsEntity()..page = page));
    _pbloc = PostThreadBloc();
    _pbloc.listen((state) {
      debugPrint("trigger thread bloc change:${state.runtimeType.toString()}");
      if (state is PostThreadedState) {
        debugPrint("发布");
        showSuccess(msg: "发布成功");
        page = 1;
        Future.delayed(Duration(seconds: 2), () {
          _bloc.add(InGetThreadsEvent(ReqGetThreadsEntity()..page = page));
        });
      }
    });
  }

  @override
  void dispose() {
    _bloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("广场"),
        centerTitle: true,
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
              padding: EdgeInsets.all(32),
              child: BlocBuilder(
                bloc: _bloc,
                builder: (BuildContext context, state) {
                  _refreshController.loadComplete();
                  if (state is GetThreadsedState) {
                    hideLoadingDialog();
                    Future.delayed(Duration(milliseconds: 0), () {
                      _scrollController.jumpTo(_scrollOffset);
                    });
                    return SmartRefresher(
                      enablePullDown: false,
                      enablePullUp: true,
                      controller: _refreshController,
                      onLoading: _onLoading,
                      child: ListView.builder(
                        key: Key("ground"),
                        controller: _scrollController,
                        itemBuilder: (context, index) {
                          return buildThreadListItem(state.entity.data[index]);
                        },
                        itemCount: state.entity.data.length,
                      ),
                    );
                  } else if (state is InGetThreadsState) {
                    showLoadingDialog();
                  }
                  return SizedBox(
                    height: 0,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handlePush,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
    );
  }

  String title;
  String subtitle;

  /// 发布
  void handlePush() {
    title = "";
    subtitle = "";
    showDialog(
        barrierDismissible: true,
        context: context,
        child: Material(
          type: MaterialType.transparency, //透明类型
          child: Center(
            child: Container(
              width: 600,
              decoration: BoxDecoration(color: Colors.white),
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 100,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            maxLength: 50,
                            controller: TextEditingController(),
                            decoration: InputDecoration(
                                icon: Icon(Icons.title), hintText: "标题..."),
                            onChanged: (s) {
                              setState(() {
                                title = s;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            maxLines: 120,
                            maxLength: 4096,
                            controller: TextEditingController(),
                            decoration: InputDecoration(
                                icon: Icon(Icons.comment), hintText: "详情..."),
                            onChanged: (s) {
                              setState(() {
                                subtitle = s;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Gaps.vGap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () => NavUtil.navigator().pop(),
                        child: Text(
                          "取消",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          if (title.length == 0 || subtitle.length == 0) {
                            showError(msg: "标题或副标题不能为空");
                          } else {
                            NavUtil.navigator().pop();
                            _pbloc.add(InPostThreadEvent(ReqPostThreadEntity()
                              ..title = title
                              ..subtitle = subtitle));
                          }
                        },
                        child: Text(
                          "发布",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget buildThreadListItem(RespGetThreadsData data) {
    return GestureDetector(
      onTap: () => NavUtil.navigator().pushNamed(Routes.threadDetailPage,
          arguments: ThreadPageArguments(data: data)),
      child: Container(
        key: ValueKey(data.id),
        margin: EdgeInsets.all(16),
        child: Card(
          key: ValueKey(data.id),
          elevation: 10,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '#${data.id}',
                      style: TextStyle(fontSize: 14),
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
                Gaps.vGap(16),
                Row(
                  children: <Widget>[
                    Image.network(
                      data.avatar,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    Gaps.hGap(16),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                data.username,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          Gaps.vGap(8),
                          Row(
                            children: [
                              Text(
                                data.createDate,
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gaps.vGap(16),
                Row(
                  children: [
                    Text(
                      data.title,
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                Gaps.vGap(16),
                Row(children: [
                  Text(
                    data.subtitle,
                    style: TextStyle(fontSize: 12),
                  )
                ],),
                Gaps.vGap(4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _scrollOffset = 0;

  void _onLoading() {
    page += 1;
    _scrollOffset = _scrollController.offset;
    _bloc.add(InGetThreadsEvent(ReqGetThreadsEntity()..page = page));
  }

  @override
  void preparedPage() {
    // TODO: implement preparedPage
  }
}
