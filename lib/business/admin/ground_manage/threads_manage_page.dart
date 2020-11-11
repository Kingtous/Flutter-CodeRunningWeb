import 'package:code_running_front/business/user/models/request/req_get_threads_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_threads_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/common/network/http_proxy.dart';
import 'package:code_running_front/router/my_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadsManagePage extends StatefulWidget {
  @override
  _ThreadsManagePageState createState() => _ThreadsManagePageState();
}

class _ThreadsManagePageState extends BaseLoadingPageState<ThreadsManagePage> {
  RespGetThreadsEntity _entity;
  ReqGetThreadsEntity _reqEntity = ReqGetThreadsEntity()..page = 1;

  String _name;

  @override
  void initState() {
    super.initState();
    //
    ApiRequest.getThreads(_reqEntity).then((callback) {
      if (callback.data != null && callback.data.code == 0) {
        setState(() {
          _entity = callback.data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("帖子一览")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
              alignment: Alignment.topCenter,
              padding: EdgeInsets.all(50),
              child: _entity == null
                  ? SizedBox(
                      width: 0,
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        sortColumnIndex: 0,
                        sortAscending: true,
                        columns: [
                          DataColumn(label: Text("帖子编号")),
                          DataColumn(label: Text("用户头像")),
                          DataColumn(label: Text("发帖用户")),
                          DataColumn(label: Text("帖子标题")),
                          DataColumn(label: Text("帖子描述")),
                          DataColumn(label: Text("用户被赞")),
                          DataColumn(label: Text("操作")),
                        ],
                        rows: _entity.data
                            .map((item) => DataRow(cells: [
                                  DataCell(Text("${item.id}")),
                                  DataCell(Image.network(
                                    item.avatar,
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                  )),
                                  DataCell(Text(item.username)),
                                  DataCell(Text("${item.title}")),
                                  DataCell(Text(item.subtitle.toString())),
                                  DataCell(Text(item.userLike.toString())),
                                  DataCell(Wrap(
                                    children: [
                                      FlatButton(
                                          onPressed: () =>
                                              handleGetThreadComment(item.id),
                                          child: Text("查看评论")),
                                      FlatButton(
                                          onPressed: () =>
                                              handleThreadDelete(item.id),
                                          child: Text("删除帖子")),
                                    ],
                                  ))
                                ]))
                            .toList(),
                      ),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(onPressed: () => loadMore(), child: Text("加载更多"))
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void preparedPage() {
    // TODO: implement preparedPage
  }

  loadMore() {
    _reqEntity.page += 1;
    ApiRequest.getThreads(_reqEntity).then((callback) {
      if (callback.data != null && callback.data.code == 0) {
        if (callback.data.data.length == 0) {
          showError(msg: "没有更多数据");
        }
        setState(() {
          _entity.data.addAll(callback.data.data);
        });
      }
    });
  }

  handleThreadDelete(int id) async {
    var callback = await ApiRequest.deleteThread(id);
    debugPrint(callback.toString());
    RespStatusEntity entity = callback.data;
    if (entity != null && entity.code == 0) {
      _entity.data.forEach((element) {
        if (element.id == id) {
          setState(() {
            _entity.data.remove(element);
          });
          return;
        }
      });
    }
  }

  handleGetThreadComment(int id) {
    Get.toNamed(Routes.commentsManagePage,
        arguments: CommentsManagePageArguments(threadId: id));
  }
}
