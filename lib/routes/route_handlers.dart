import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/pages/login/register_page.dart';
import '../pages/login/user_verify_code_page.dart';
import '../pages/login/reset_password_page.dart';
import 'package:it_resource_exchange_app/pages/web/webview_page.dart';

import '../utils/user_utils.dart';

import '../pages/login/login_page.dart';
import '../pages/application_page.dart';
import '../pages/detail/goods_detail_page.dart';
import '../pages/my_product_list/my_product_list_page.dart';
import '../pages/create/new_goods_page.dart';
import '../pages/collection/my_collection_list_page.dart';
import '../pages/login/perfect_info_page.dart';
import '../pages/player/video_player_page.dart';
import '../pages/movie/movie_search_page.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UserUtils.isLogin() ? ApplicationPage() : LoginPage();
});

var mainHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ApplicationPage();
});

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});

var registerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RegisterPage();
});

var resetPassworVerityHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UserVerifyCodePage();
});

var resetPassworHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String account = params['account']?.first;
  String verityCode = params['verityCode']?.first;
  return RestPasswordPage(
    account: account,
    verityCode: verityCode,
  );
});

var perfectInfoHander = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PerfectInfoPage();
});

var productDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String productId = params['productId']?.first;
  return GoodsDetailPage(productId: int.parse(productId));
});

var webHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String title = params['title']?.first;
  var list = List<int>();
  jsonDecode(title).forEach(list.add);
  title = Utf8Decoder().convert(list);
  String url = params['url']?.first;
  return WebviewPage(title: title, url: url);
});

var myProductListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MyProductListPage();
});

var myCollectionListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MyCollectionListPage();
});

var newProductHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String productId = params['productId']?.first;
  return NewGoodsPage(productId: int.parse(productId));
});

var videoPlayerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String movieId = params['movieId']?.first;
  return VideoPlayerPage(movieId: int.parse(movieId),);
});

var movieSearchHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MovieSearchPage();
});
