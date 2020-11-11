import 'package:code_running_front/business/user/dashboard/modules/cart/cart/buy/bloc.dart';
import 'package:code_running_front/business/user/dashboard/modules/cart/cart/del/bloc.dart';
import 'package:code_running_front/business/user/dashboard/modules/cart/cart/get/bloc.dart';
import 'package:code_running_front/business/user/dashboard/modules/profile/get/credits/bloc.dart';
import 'package:code_running_front/business/user/dashboard/modules/profile/get/credits/get_credits_bloc.dart';
import 'package:code_running_front/business/user/dashboard/modules/profile/get/credits/get_credits_state.dart';
import 'package:code_running_front/business/user/models/request/req_buy_cart_items_entity.dart';
import 'package:code_running_front/business/user/models/request/req_del_cart_entity.dart';
import 'package:code_running_front/business/user/models/request/req_get_credits_entity.dart';
import 'package:code_running_front/business/user/models/request/req_get_my_cart_entity.dart';
import 'package:code_running_front/business/user/models/response/resp_get_my_cart_entity.dart';
import 'package:code_running_front/common/base/page_state.dart';
import 'package:code_running_front/res/styles.dart';
import 'package:code_running_front/ui/image_load_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:load/load.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'cart/del/del_cart_bloc.dart';
import 'cart/get/get_my_cart_bloc.dart';

class CartPage extends StatefulWidget {

  const CartPage({Key key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends BaseLoadingPageState<CartPage> {
  GetMyCartBloc _bloc;
  DelCartBloc _delBloc;
  BuyCartItemsBloc _bBloc;
  var page = 0;

  var _scrollController = ScrollController();

  var _refreshController = RefreshController();

  List<RespGetMyCartData> data = List<RespGetMyCartData>();
  List<int> selected = List<int>();
  Map<int, bool> checkBoxes = Map();
  int totalNeedCredits = 0;

  void reset() {
    data.clear();
    selected.clear();
    checkBoxes.clear();
    totalNeedCredits = 0;
    setState(() {});
    page = 0;
    _bloc.add(InGetMyCartEvent(ReqGetMyCartEntity()..page = page));
  }

  @override
  void initState() {
    super.initState();
    _delBloc = DelCartBloc();
    _bBloc = BuyCartItemsBloc();
    _bloc = GetMyCartBloc();
    _bloc.add(InGetMyCartEvent(ReqGetMyCartEntity()..page = page));
    _bloc.listen((state) {
      if (state is GetMyCartedState) {
        setState(() {
          data.addAll(state.entity.data);
        });
        _refreshController.loadComplete();
      }
    });
    _delBloc.listen((state) {
      if (state is DelCartedState) {
        hideLoadingDialog();
      }
    });
    _bBloc.listen((state) {
      if (state is BuyCartItemsedState) {
        showSuccess(msg: "购买成功！剩余积分：${state.entity.data}");
        Get.arguments.getCreditsBloc
            .add(InGetCreditsEvent(ReqGetCreditsEntity()));
        hideLoadingDialog();
        reset();
      } else if (state is NoBuyCartItemsState) {
        showError(msg: state.msg);
        hideLoadingDialog();
      }
    });
  }

  @override
  void dispose() {
    _bloc?.close();
    _bBloc?.close();
    _delBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的购物车"),
        actions: <Widget>[
          BlocBuilder(
            bloc: Get.arguments.getCreditsBloc as GetCreditsBloc,
            builder: (BuildContext context, state) {
              if (state is GetCreditsedState) {
                return FlatButton(
                    onPressed: () {},
                    child: Text(
                      '我的积分数：${state.entity.data.credits}',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ));
              } else {
                return SizedBox(
                  width: 0,
                );
              }
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
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
                      return buildCartItems(data[index], index);
                    },
                    itemCount: data.length,
                  ),
                ),
              )),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(32),
              decoration: BoxDecoration(color: Colors.black),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: Text(
                    '共花费：$totalNeedCredits',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
                  FlatButton(
                      onPressed: selected.length != 0 ? handleBuy : null,
                      child: Text("购买",
                          style: TextStyle(fontSize: 16, color: Colors.white)))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void preparedPage() {
    // TODO: implement preparedPage
  }

  Widget buildCartItems(RespGetMyCartData data, int index) {
    return Card(
      key: ValueKey(index),
      elevation: 10,
      child: Container(
          padding: EdgeInsets.all(16.0),
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(Icons.delete),
                    onTap: () => handleDelete(data, data.cartItemId),
                  )
                ],
              ),
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
              Checkbox(
                value: checkBoxes[data.cartItemId] != null
                    ? checkBoxes[data.cartItemId]
                    : false,
                onChanged: (value) => handleValueChanged(value, data),
              )
            ],
          )),
    );
  }

  handleDetail(RespGetMyCartData data) {}

  void _onLoading() {
    page += 1;
    _bloc.add(InGetMyCartEvent(ReqGetMyCartEntity()..page = page));
  }

  handleBuy() {
    _bBloc.add(InBuyCartItemsEvent(ReqBuyCartItemsEntity()..ids = selected));
    showLoadingDialog();
  }

  handleValueChanged(bool value, RespGetMyCartData data) {
    checkBoxes[data.cartItemId] = value;
    if (value) {
      // 勾上，选择
      selected.add(data.cartItemId);
      totalNeedCredits += data.credits;
    } else {
      selected.remove(data.cartItemId);
      totalNeedCredits -= data.credits;
    }
    setState(() {});
  }

  handleDelete(RespGetMyCartData idata, int index) {
    showLoadingDialog();
    _delBloc.add(InDelCartEvent(ReqDelCartEntity()..itemId = index));
    selected.remove(index);
    checkBoxes.remove(index);
    data.remove(idata);
    setState(() {});
  }
}
