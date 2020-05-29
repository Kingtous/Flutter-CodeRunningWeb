import 'package:code_running_front/business/user/models/response/resp_change_user_role_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_change_user_status_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_users_list_entity.dart';
import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/common/network/http_proxy.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends BaseLoadingPageState<UsersPage> {
  RespUsersListEntity _entity;

  @override
  void initState() {
    super.initState();
    //
    ApiRequest.getUserList().then((callback) {
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
      appBar: AppBar(title: Text("用户管理")),
      body: SingleChildScrollView(
        child: Container(
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
                    sortColumnIndex: 1,
                    sortAscending: true,
                    columns: [
                      DataColumn(label: Center(child: Text("编号"))),
                      DataColumn(label: Center(child: Text("ID"))),
                      DataColumn(label: Center(child: Text("昵称"))),
                      DataColumn(label: Center(child: Text("身份"))),
                      DataColumn(label: Center(child: Text("状态"))),
                      DataColumn(label: Center(child: Text("操作"))),
                    ],
                    rows: _entity.data
                        .map((user) => DataRow(cells: [
                              DataCell(Text("${user.id}")),
                              DataCell(Text(user.username)),
                              DataCell(Text("${user.nickname}")),
                              DataCell(
                                  Text('${user.role == 0 ? "普通用户" : "管理员"}')),
                              DataCell(Text(
                                  '${user.enable == true ? "正常使用" : "冻结"}')),
                              DataCell(Wrap(
                                children: [
                                  FlatButton(
                                      onPressed: () =>
                                          handleChangeRole(user.id),
                                      child: Text(user.role == 0
                                          ? "变更为管理员"
                                          : "变更为一用户")),
                                  FlatButton(
                                      onPressed: () =>
                                          handleChangeStatus(user.id),
                                      child: Text(user.enable ? "禁用" : "启动")),
                                ],
                              ))
                            ]))
                        .toList(),
                  ),
                ),
        ),
      ),
    );
  }

  List<DataRow> _tableRowList() {
    debugPrint("build tablerow");
    List<DataRow> list = [];
    if (_entity != null) {
      var length = _entity.data.length;
      for (var index = 0; index < length; index++) {
        var row = DataRow(cells: null);
        var user = _entity.data[index];
        var cells = [];
        cells.add(DataCell(Text("${user.id}")));
        cells.add(DataCell(Text(user.username)));
        cells.add(DataCell(Text("${user.nickname}")));
        cells.add(DataCell(Text('${user.role == 0 ? "普通用户" : "管理员"}')));
        cells.add(DataCell(Text('${user.enable == true ? "正常使用" : "冻结"}')));
        cells.add(DataCell(Wrap(
          children: [
            FlatButton(
                onPressed: () => handleChangeRole(user.id),
                child: Text(user.role == 0 ? "变更为管理员" : "变更为普通用户")),
            FlatButton(
                onPressed: () => handleChangeStatus(user.id),
                child: Text(user.enable ? "禁用" : "启动")),
          ],
        )));
        debugPrint("add");
//        list.add(DataRow(cells: cells));
        debugPrint("add $index");
      }
    }
    return list;
  }

  handleChangeRole(int id) async {
    var callback = await ApiRequest.changeRole(id);
    RespChangeUserRoleEntity entity = callback.data;
    if (entity != null && entity.code == 0) {
      var newRole = entity.data;
      _entity.data.forEach((element) {
        if (element.id == id) {
          setState(() {
            element.role = newRole;
          });
          return;
        }
      });
    }
    if (entity != null && entity.code == 1016) {
      showError(msg: "你不能对自己进行相关操作");
    }
  }

  handleChangeStatus(int id) async {
    var callback = await ApiRequest.changeUserStatus(id);
    debugPrint(callback.toString());
    RespChangeUserStatusEntity entity = callback.data;
    if (entity != null && entity.code == 0) {
      var newStatus = entity.data;
      _entity.data.forEach((element) {
        if (element.id == id) {
          setState(() {
            element.enable = newStatus;
          });
          return;
        }
      });
    }
    if (entity != null && entity.code == 1016) {
      showError(msg: "你不能对自己进行相关操作");
    }
  }

  @override
  void preparedPage() {
    // TODO: implement preparedPage
  }
}
