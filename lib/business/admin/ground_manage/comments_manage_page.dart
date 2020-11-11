import 'package:code_running_front/business/user/models/request/req_get_thread_comment_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_thread_comment_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_status_entity.dart';
import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/common/network/http_proxy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentsManagePage extends StatefulWidget {

  const CommentsManagePage({Key key}) : super(key: key);

  @override
  _CommentsManagePageState createState() => _CommentsManagePageState();
}

class _CommentsManagePageState
    extends BaseLoadingPageState<CommentsManagePage> {
  RespGetThreadCommentEntity _entity;
  ReqGetThreadCommentEntity _reqEntity = ReqGetThreadCommentEntity()..page = 0;

  String _name;
  int threadId;

  @override
  void initState() {
    super.initState();
    threadId = Get.arguments.threadId;
    //
    _reqEntity.threadId = threadId;
    ApiRequest.getThreadComment(_reqEntity).then((callback) {
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
      appBar: AppBar(title: Text("评论一览")),
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
                          DataColumn(label: Text("评论ID")),
                          DataColumn(label: Text("用户头像")),
                          DataColumn(label: Text("用户名")),
                          DataColumn(label: Text("发表时间")),
                          DataColumn(label: Text("发表内容")),
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
                                  DataCell(Text(
                                      "${DateTime.fromMillisecondsSinceEpoch(item.createDate.toInt() * 1000).toLocal().toString()}")),
                                  DataCell(Text(item.content.toString())),
                                  DataCell(Wrap(
                                    children: [
                                      FlatButton(
                                          onPressed: () =>
                                              handleCommentDelete(item.id),
                                          child: Text("删除评论")),
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
    ApiRequest.getThreadComment(_reqEntity).then((callback) {
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

  handleCommentDelete(int id) async {
    var callback = await ApiRequest.deleteComment(threadId, id);
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

  handleGetThreadComment(int id) {}
}
