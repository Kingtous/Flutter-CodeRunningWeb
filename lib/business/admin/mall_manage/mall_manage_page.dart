import 'package:code_running_front/business/user/models/request/req_add_items_entity.dart';
import 'package:code_running_front/business/user/models/request/req_get_mall_items_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_change_user_status_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_mall_items_entity.dart';
import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/common/network/http_proxy.dart';
import 'package:code_running_front/res/styles.dart';
import 'package:code_running_front/ui/nav_util.dart';
import 'package:flutter/material.dart';

class ItemsManagePage extends StatefulWidget {
  @override
  _ItemsManagePageState createState() => _ItemsManagePageState();
}

class _ItemsManagePageState extends BaseLoadingPageState<ItemsManagePage> {
  RespGetMallItemsEntity _entity;
  ReqGetMallItemsEntity _reqEntity = ReqGetMallItemsEntity()..page = 0;
  ReqAddItemsEntity _reqAddItemsEntity;

  String _name;

  @override
  void initState() {
    super.initState();
    //
    ApiRequest.getMallItems(_reqEntity).then((callback) {
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
      appBar: AppBar(title: Text("商品目录")),
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
                          DataColumn(label: Text("编号")),
                          DataColumn(label: Text("商品名称")),
                          DataColumn(label: Text("商品描述")),
                          DataColumn(label: Text("商品图片")),
                          DataColumn(label: Text("所需积分数")),
                          DataColumn(label: Text("状态")),
                          DataColumn(label: Text("操作")),
                        ],
                        rows: _entity.data
                            .map((item) => DataRow(cells: [
                                  DataCell(Text("${item.id}")),
                                  DataCell(Text(item.name)),
                                  DataCell(Text("${item.detail}")),
                                  DataCell(Image.network(
                                    item.img,
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                  )),
                                  DataCell(Text(item.credits.toString())),
                                  DataCell(Text(item.isOn ? "已上架" : "已下架")),
                                  DataCell(Wrap(
                                    children: [
                                      FlatButton(
                                          onPressed: () => handleIsOn(item.id),
                                          child: Text(item.isOn ? "下架" : "上架")),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => handleAdd(context),
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void preparedPage() {
    // TODO: implement preparedPage
  }

  loadMore() {
    _reqEntity.page += 1;
    ApiRequest.getMallItems(_reqEntity).then((callback) {
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

  handleIsOn(int id) async {
    var callback = await ApiRequest.changeItemStatus(id);
    debugPrint(callback.toString());
    RespChangeUserStatusEntity entity = callback.data;
    if (entity != null && entity.code == 0) {
      var newStatus = entity.data;
      _entity.data.forEach((element) {
        if (element.id == id) {
          setState(() {
            element.isOn = newStatus;
          });
          return;
        }
      });
    }
  }

  handleAdd(BuildContext context) {
    _reqAddItemsEntity = new ReqAddItemsEntity()..isOn = false;
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: TextEditingController(),
                                decoration: InputDecoration(hintText: "名称"),
                                onChanged: (s) {
                                  _reqAddItemsEntity.name = s;
                                },
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: TextEditingController(),
                                decoration: InputDecoration(hintText: "描述"),
                                onChanged: (s) {
                                  _reqAddItemsEntity.detail = s;
                                },
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: TextEditingController(),
                                decoration: InputDecoration(hintText: "图片链接"),
                                onChanged: (s) {
                                  _reqAddItemsEntity.img = s;
                                },
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: TextEditingController(),
                                decoration: InputDecoration(hintText: "所需积分数"),
                                onChanged: (s) {
                                  _reqAddItemsEntity.credits = int.parse(s);
                                },
                              ),
                            )
                          ],
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
                        onPressed: () => handleSubmit(),
                        child: Text(
                          "提交",
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

  handleSubmit() async {
    var callback = await ApiRequest.addMallItems(_reqAddItemsEntity);
    if (callback != null && callback.data.code == 0) {
      showSuccess(msg: "添加成功！");
      RespGetMallItemsData data = RespGetMallItemsData()
        ..credits = _reqAddItemsEntity.credits
        ..name = _reqAddItemsEntity.name
        ..detail = _reqAddItemsEntity.detail
        ..img = _reqAddItemsEntity.img
        ..id = callback.data.data.id;
      setState(() {
        _entity.data.add(data);
      });
    }
  }
}
