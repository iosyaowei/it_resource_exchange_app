import 'package:flutter/material.dart';
import 'package:it_resource_exchange_app/model/cate_info.dart';
import 'package:it_resource_exchange_app/net/network_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:it_resource_exchange_app/common/constant.dart' show AppColors;
import 'package:it_resource_exchange_app/pages/create/new_goods_page.dart';
import 'package:it_resource_exchange_app/utils/user_utils.dart';
import 'package:it_resource_exchange_app/model/product_detail.dart';
import './my_product_item_view.dart';
import 'package:it_resource_exchange_app/vo/new_product_vo.dart';

class MyProductListPage extends StatefulWidget {
  @override
  _MyProductListPageState createState() => _MyProductListPageState();
}

class _MyProductListPageState extends State<MyProductListPage> {
  bool _showLoading = true;

  final _loadingContainer = Container(
      color: Colors.white,
      constraints: BoxConstraints.expand(),
      child: Center(
        child: Opacity(
          opacity: 0.9,
          child: SpinKitRing(
            color: AppColors.PrimaryColor,
            size: 50.0,
          ),
        ),
      ));

  List<ProductDetail> productList = [];

  void initState() {
    super.initState();
    requsetMyProductListData();
  }

  requsetMyProductListData() {
    var userId = UserUtils.getUserInfo().userId;
    NetworkUtils.requestMyProductListData(userId).then((res) {
      if (res.status == 200) {
        productList =
            (res.data as List).map((m) => ProductDetail.fromJson(m)).toList();
        setState(() {
          _showLoading = false;
        });
      }
    });
  }

  _buildListView() {
    return ListView.builder(
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return MyProductItemView(
          product: productList[index],
          onPressed: () {
            ProductDetail product = productList[index];
            NewProductVo productVo = NewProductVo.init(
                productId: product.productId.toString(),
                title: product.productTitle,
                price: product.price.toString(),
                resourceUrl: product.productAddressUrl,
                resourcePassword: product.productAddressPassword,
                desc: product.productDesc,
                imgUrlList: product.imgUrls.split(','),
                cateId: product.cateId);

            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NewGoodsPage(productVo: productVo, completeCallback: () {
                  this.requsetMyProductListData();
                  setState(() {
                    this._showLoading = true;
                  });
                },)));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "我的资源",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: _showLoading ? _loadingContainer : _buildListView());
  }
}
