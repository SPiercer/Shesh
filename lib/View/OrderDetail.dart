import 'package:badges/badges.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shesha/Models/Order.dart';
import 'package:shesha/Models/Product.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetail extends StatelessWidget {
  final Order order;
  OrderDetail(this.order);
  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('قائمه الطلبات'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'اسم العميل : ${order.name}',
              style: TextStyle(fontSize: 28.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'هاتف العميل : ',
                    style: TextStyle(fontSize: 28.0),
                  ),
                  TextSpan(
                    text: '0${order.phone}',
                    style: TextStyle(fontSize: 28.0, color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch('tel://0${order.phone}');
                      },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              height: 75,
              width: _screenSize.width,
              padding: const EdgeInsets.all(8.0),
              color: Colors.grey[900],
              child: Align(
                  child: Text(
                    'العنوان',
                    style: TextStyle(fontSize: 22.0),
                  ),
                  alignment: Alignment.centerRight),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'الي                     ',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  TextSpan(
                    text: '${order.address}',
                    style: TextStyle(fontSize: 18.0, color: Colors.grey[800]),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              height: 75,
              width: _screenSize.width,
              padding: const EdgeInsets.all(8.0),
              color: Colors.grey[900],
              child: Align(
                  child: Text(
                    'تفاصيل الطلب',
                    style: TextStyle(fontSize: 22.0),
                  ),
                  alignment: Alignment.centerRight),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: order.products.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = Product.fromJson(order.products[index]);
                  Pivot pivot = Pivot.fromJson(order.products[index]['pivot']);
                  return ListTile(
                      title: Text('${product.nameAr}'),
                      trailing: Badge(
                        badgeContent: Text(pivot.quantity),
                        borderRadius: 25,
                        child: pivot.color == null
                            ? CircleAvatar(
                                child: Text('بلا لون'),
                              )
                            : CircleAvatar(
                                backgroundColor: HexColor.fromHex(pivot.color),
                                radius: 10,
                              ),
                      ));
                },
              )),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Container(
              height: 75,
              width: _screenSize.width,
              padding: const EdgeInsets.all(8.0),
              color: Colors.grey[900],
              child: Align(
                  child: Text(
                    'تكلفه الطلب',
                    style: TextStyle(fontSize: 22.0),
                  ),
                  alignment: Alignment.centerRight),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: order.products.length,
                itemBuilder: (BuildContext context, int index) {
                  Product product = Product.fromJson(order.products[index]);
                  Pivot pivot = Pivot.fromJson(order.products[index]['pivot']);
                  return ListTile(
                      title: Text('${product.nameAr}'),
                      trailing: Text(
                        '${product.salePrice} x ${pivot.quantity} = ${double.parse(product.salePrice) * double.parse(pivot.quantity)}',
                        textDirection: TextDirection.ltr,
                      ));
                },
              )),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Divider(color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'الاجمالي  ',
                    style: TextStyle(fontSize: 18.0, color: Colors.green[800]),
                  ),
                  TextSpan(
                    text: '${order.totalPrice}',
                    style: TextStyle(fontSize: 18.0, color: Colors.green[800]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
