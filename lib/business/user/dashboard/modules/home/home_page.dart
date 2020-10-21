import 'package:code_running_front/business/user/dashboard/modules/home/profile/alter_profile_bloc.dart';
import 'package:code_running_front/business/user/dashboard/modules/home/profile/alter_profile_event.dart';
import 'package:code_running_front/business/user/dashboard/modules/home/profile/alter_profile_state.dart';
import 'package:code_running_front/business/user/dashboard/modules/profile/get/profile/bloc.dart';
import 'package:code_running_front/business/user/dashboard/modules/profile/get/profile/get_profile_bloc.dart';
import 'package:code_running_front/business/user/models/request/req_alter_profile_entity.dart';
import 'package:code_running_front/business/user/models/request/req_get_my_bought_entity.dart';
import 'package:code_running_front/business/user/models/request/req_get_profile_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_my_bought_entity.dart';
import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/res/styles.dart';
import 'package:code_running_front/ui/image_load_view.dart';
import 'package:code_running_front/utils/user_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:load/load.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'item/bloc.dart';

class HomePage extends StatefulWidget {
  final GetProfileBloc pBloc;

  const HomePage({Key key, this.pBloc}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BaseLoadingPageState<HomePage> {
  GetMyBoughtBloc _bloc;
  AlterProfileBloc _aBloc;

  var page = 0;
  List<RespGetMyBoughtData> data = List<RespGetMyBoughtData>();

  String _nickname;
  String _avatarUrl;

  var _scrollController = ScrollController();

  var _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _bloc = GetMyBoughtBloc();
    _aBloc = AlterProfileBloc();
    _aBloc.listen((state) {
      if (state is AlterProfileedState) {
        showSuccess(msg: "修改成功");
        hideLoadingDialog();
        widget.pBloc.add(
            InGetProfileEvent(ReqGetProfileEntity()..id = getUserInfo().id));
      } else if (state is NoAlterProfileState) {
        showError(msg: state.msg);
        hideLoadingDialog();
      }
    });
    _bloc.add(InGetMyBoughtEvent(ReqGetMyBoughtEntity()..page = page));
    _bloc.listen((state) {
      if (state is GetMyBoughtedState) {
        data.addAll(state.entity.data);
        _refreshController.loadComplete();
      } else if (state is NoGetMyBoughtState) {
        showError(msg: state.msg);
        _refreshController.loadFailed();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _bloc?.close();
    _aBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("个人资料")),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SmartRefresher(
          enablePullDown: false,
          enablePullUp: true,
          header: WaterDropHeader(),
          controller: _refreshController,
          scrollController: _scrollController,
          onLoading: _onLoading,
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverList(
                  delegate: SliverChildListDelegate([
                BlocBuilder(
                  bloc: widget.pBloc,
                  builder: (BuildContext context, state) {
                    if (state is GetProfileedState) {
                      return Card(
                        elevation: 10,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Gaps.vGap(16),
                                    Text('编号：${state.entity.data.id}'),
                                    Gaps.vGap(16),
                                    Text('ID：${state.entity.data.username}'),
                                    Gaps.vGap(16),
                                    Text('昵称：${state.entity.data.nickname}'),
                                    Gaps.vGap(16),
                                  ],
                                ),
                              ),
                              ImageLoadView(
                                state.entity.data.avatarUrl,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: 0,
                      );
                    }
                  },
                ),
                // 修改昵称
                BlocBuilder(
                  bloc: widget.pBloc,
                  builder: (BuildContext context, state) {
                    if (state is GetProfileedState) {
                      return Card(
                        elevation: 10,
                        child: Container(
                          padding: EdgeInsets.all(32),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  controller: TextEditingController(
                                      text: state.entity.data.nickname),
                                  onChanged: (s) => {_nickname = s},
                                ),
                              ),
                              FlatButton(
                                onPressed: () => handleAlterNickName(_nickname),
                                child: Text("修改昵称"),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: 0,
                      );
                    }
                  },
                ),

                // 修改头像
                BlocBuilder(
                  bloc: widget.pBloc,
                  builder: (BuildContext context, state) {
                    if (state is GetProfileedState) {
                      return Card(
                        elevation: 10,
                        child: Container(
                          padding: EdgeInsets.all(32),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  controller: TextEditingController(
                                      text: state.entity.data.avatarUrl),
                                  onChanged: (s) => {_avatarUrl = s},
                                ),
                              ),
                              FlatButton(
                                onPressed: () => handleAlterUrl(_avatarUrl),
                                child: Text("修改头像"),
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: 0,
                      );
                    }
                  },
                ),
                    Gaps.vGap(50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("已购买的"),
                      ],
                    ),
//              SmartRefresher(
//                enablePullDown: false,
//                enablePullUp: true,
//                header: WaterDropHeader(),
//                controller: _refreshController,
//                scrollController: _scrollController,
//                onLoading: _onLoading,
//                child: GridView.builder(
//                  controller: _scrollController,
//                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                      maxCrossAxisExtent: 600),
//                  itemBuilder: (BuildContext context, int index) {
//                    return buildCartItems(data[index], index);
//                  },
//                  itemCount: data.length,
//                ),
//              )
              ])),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 600),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return buildCartItems(data[index], index);
                }, childCount: data.length),
              )

//            SliverChildListDelegate([
//              GridView.builder(
//                controller: _scrollController,
//                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//                    maxCrossAxisExtent: 600),
//                itemBuilder: (BuildContext context, int index) {
//                  return buildCartItems(data[index], index);
//                },
//                itemCount: data.length,
//              ),
//            ])
            ],
          ),
        ),
      ),
    );
  }

  @override
  void preparedPage() {
    // TODO: implement preparedPage
  }

  Widget buildCartItems(RespGetMyBoughtData data, int index) {
    return Card(
      key: ValueKey(index),
      elevation: 10,
      child: Container(
          width: 200,
          // padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ImageLoadView(
                data.img,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              Text("售价:${data.credits}积分",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20, color: Colors.red)),
              Gaps.vGap(8),
              Text(
                data.name,
                style: TextStyle(fontSize: 16),
              ),
              Text(data.detail,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14)),
            ],
          )),
    );
  }

  void _onLoading() {
    page += 1;
    _bloc.add(InGetMyBoughtEvent(ReqGetMyBoughtEntity()..page = page));
  }

  handleAlterNickName(String nickname) {
    if (nickname != null && nickname.length != 0) {
      _aBloc.add(InAlterProfileEvent(ReqAlterProfileEntity()
        ..field = "nickname"
        ..value = nickname));
      showLoadingDialog();
    }
  }

  handleAlterUrl(String avatarUrl) {
    if (_avatarUrl != null && _avatarUrl.length != 0) {
      _aBloc.add(InAlterProfileEvent(ReqAlterProfileEntity()
        ..field = "avatar_url"
        ..value = avatarUrl));
      showLoadingDialog();
    }
  }
}
