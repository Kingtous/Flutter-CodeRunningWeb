import 'package:code_running_front/business/user/dashboard/modules/store/add/add_cart_event.dart';
import 'package:code_running_front/business/user/dashboard/modules/store/add/bloc.dart';
import 'package:code_running_front/business/user/models/request/req_add_cart_entity.dart';
import 'package:code_running_front/business/user/models/request/req_get_mall_items_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_mall_items_entity.dart';
import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/res/styles.dart';
import 'package:code_running_front/ui/image_load_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:load/load.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'add/add_cart_bloc.dart';
import 'get/bloc.dart';

class StorePage extends StatefulWidget {
  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends BaseLoadingPageState<StorePage> {
  GetMallItemsBloc _gbloc;
  AddCartBloc _abloc;

  var page = 0;

  var _refreshController = RefreshController();

  var _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _gbloc = GetMallItemsBloc();
    _abloc = AddCartBloc();
    _gbloc.add(InGetMallItemsEvent(ReqGetMallItemsEntity()..page = page));
    _gbloc.listen((state) {
      if (state is GetMallItemsedState) {
        setState(() {
          data.addAll(state.entity.data);
        });
        _refreshController.loadComplete();
      }
    });
    _abloc.listen((state) {
      if (state is AddCartedState) {
        hideLoadingDialog();
        showSuccess(msg: "加入购物车成功！");
      }
    });
  }

  @override
  void dispose() {
    _gbloc?.close();
    super.dispose();
  }

  List<RespGetMallItemsData> data = new List<RespGetMallItemsData>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text("点点通")),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: handleEnterCart,
      //   child: Icon(Icons.add_shopping_cart),
      // ),
      body: Container(
          padding: EdgeInsets.all(32),
          child: Scrollbar(
            controller: _scrollController,
            child: SmartRefresher(
              scrollController: _scrollController,
              controller: _refreshController,
              enablePullUp: true,
              enablePullDown: false,
              onLoading: _onLoading,
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 600),
                itemBuilder: (BuildContext context, int index) {
                  return buildMallItems(data[index]);
                },
                itemCount: data.length,
              ),
            ),
          )),
    );
  }

  @override
  void preparedPage() {
    // TODO: implement preparedPage
  }

  void handleEnterCart() {
  }

  Widget buildMallItems(RespGetMallItemsData data) {
    return GestureDetector(
      onTap: () => handleDetail(data),
      child: Card(
        elevation: 10,
        child: Container(
            width: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ImageLoadView(
                  data.img,
                  width: 200,
                  height: 200,
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
      ),
    );
  }

  void _onLoading() {
    page += 1;
    debugPrint("page:$page");
    _gbloc.add(InGetMallItemsEvent(ReqGetMallItemsEntity()..page = page));
  }

  void handleDetail(RespGetMallItemsData data) {
    showDialog(
        context: context,
        builder: (_) => NetworkGiffyDialog(
              image: ImageLoadView(
                data.img,
                fit: BoxFit.cover,
              ),
              title: Text(
                data.name,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
              ),
              description: Text(
                '${data.credits}积分' + '\n' + data.detail,
                overflow: TextOverflow.visible,
              ),
              entryAnimation: EntryAnimation.TOP_LEFT,
              buttonOkText: Text("加入购物车"),
              buttonCancelText: Text("取消"),
              onOkButtonPressed: () {
                Get.back();
                handleAddCart(data);
              },
            ));
  }

  void handleAddCart(RespGetMallItemsData data) {
    debugPrint("add cart");
    _abloc?.add(InAddCartEvent(ReqAddCartEntity()..itemId = data.id));
    showLoadingDialog();
  }
}
