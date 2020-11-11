import 'package:code_running_front/business/user/models/request/req_get_thread_comment_entity.dart';
import 'package:code_running_front/business/user/models/request/req_thread_comment_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_change_user_role_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_thread_comment_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_threads_entity.dart';
import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/common/network/http_proxy.dart';
import 'package:code_running_front/res/styles.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:load/load.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'get/bloc.dart';
import 'post/bloc.dart';

class ThreadPage extends StatefulWidget {

  const ThreadPage({Key key}) : super(key: key);

  @override
  _ThreadPageState createState() => _ThreadPageState();
}

class _ThreadPageState extends BaseLoadingPageState<ThreadPage> {
  GetThreadCommentBloc _bloc;
  PostThreadCommentBloc _pbloc;

  RespGetThreadsData data;

  var page = 0;

  var _refreshController = RefreshController();

  var _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    data = Get.arguments.data;
    _bloc = GetThreadCommentBloc();
    _bloc.add(InGetThreadCommentEvent(ReqGetThreadCommentEntity()
      ..threadId = data.id
      ..page = page));

    _pbloc = PostThreadCommentBloc();

    _bloc.listen((state) {
      if (state is GetThreadCommentedState) {
        _refreshController.refreshCompleted();
        _refreshController.loadComplete();
      } else if (state is InPostThreadCommentState) {
      } else {
        _refreshController.refreshFailed();
        _refreshController.loadFailed();

      }
    });
    _pbloc.listen((state) {
      if (state is PostThreadCommentedState) {
        showSuccess(msg: "评论成功！");
        page = 0;
        _bloc?.add(InGetThreadCommentEvent(ReqGetThreadCommentEntity()
          ..threadId = data.id
          ..page = page));
      } else if (state is InPostThreadCommentState) {

      } else {
        hideLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _bloc?.close();
    _pbloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("动态详情"),
      ),
      body: SmartRefresher(
        scrollController: _scrollController,
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: () => {
          page = 0,
          _bloc?.add(InGetThreadCommentEvent(ReqGetThreadCommentEntity()
            ..threadId = data.id
            ..page = page))
        },
        onLoading: () => {
          page += 1,
          _bloc?.add(InGetThreadCommentEvent(ReqGetThreadCommentEntity()
            ..threadId = data.id
            ..page = page))
        },
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              buildThreadListItem(data),
              Expanded(
                child: BlocBuilder(
                  bloc: _bloc,
                  builder: (BuildContext context, state) {
                    switch (state.runtimeType) {
                      case GetThreadCommentedState:
                        // 评论
                        return ListView.builder(
                          controller: _scrollController,
                          itemBuilder: (context, index) =>
                              buildCommentItem(state.entity.data[index]),
                          itemCount: state.entity.data.length,
                        );
                      default:
                        return SizedBox(
                          key: Key("assets/animations/status/loading.flr"),
                          child: new FlareActor(
                            "assets/animations/status/loading.flr",
                            animation: "spin2",
                          ),
                          width: 75,
                          height: 75,
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handlePostComment,
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buildThreadListItem(RespGetThreadsData data) {
    return Container(
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
                              data.username.toString(),
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        Gaps.vGap(8),
                        Row(
                          children: [
                            Text(
                              data.createDate.toString(),
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
                    data.title.toString(),
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              Gaps.vGap(16),
              Row(
                children: [
                  Text(
                    data.subtitle.toString(),
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        handleLike(data.userId);
                      },
                      child: Icon(Icons.favorite_border)),
                  Gaps.hGap(4),
                  Text("${data.userLike}")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  buildCommentItem(RespGetThreadCommentData data) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
                              DateTime.fromMillisecondsSinceEpoch(
                                  data.createDate.toInt() * 1000)
                                  .toLocal()
                                  .toString(),
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
                children: <Widget>[
                  Text(
                    data.content,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String comment = "";

  void handlePostComment() {
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
                            controller: TextEditingController(),
                            decoration: InputDecoration(
                                icon: Icon(Icons.comment), hintText: "评论内容..."),
                            onChanged: (s) {
                              setState(() {
                                comment = s;
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
                        onPressed: () => Get.back(),
                        child: Text(
                          "取消",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      FlatButton(
                        onPressed: () => handleComment(),
                        child: Text(
                          "评论",
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

  @override
  void preparedPage() {
    // TODO: implement preparedPage
  }

  handleComment() {
    Get.back();
    if (comment == "") {
      showError(msg: "评论内容不能为空");
      return;
    }
    _pbloc.add(InPostThreadCommentEvent(ReqThreadCommentEntity()
      ..threadId = data.id
      ..content = comment));
  }

  handleLike(int userId) async {
    RespChangeUserRoleEntity entity = (await ApiRequest.likeUser(userId)).data;
    debugPrint("start process");
    if (entity.code == 0) {
      setState(() {
        data.userLike = entity.data;
      });
    }
  }
}
