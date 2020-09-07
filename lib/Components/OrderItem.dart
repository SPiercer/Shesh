import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shesha/API/Orders.dart';
import 'package:shesha/Models/Order.dart';
import 'package:shesha/Providers/OrdersList.dart';
import 'package:shesha/View/OrderDetail.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  final int id;
  OrderItem(this.order, this.id);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        height: 150,
        color: Colors.grey[900],
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => OrderDetail(order))),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(order.products[0]['image_path']),
                radius: 25,
              ),
              title: Text('${order.name}'),
              subtitle: Text('0${order.phone}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('${order.status}'),
                  Text('ID: ${order.id}'),
                ],
              ),
            ),
            Row(
              children: order.status == 'delivery_by_representative'
                  ? [
                      InkWell(
                        onTap: () async {
                          Position position = await getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.high);

                          String origin = position.latitude.toString() +
                              ',' +
                              position.longitude
                                  .toString(); // lat,long like 123.34,68.56
                          String destination =
                              order.latitude + ',' + order.longitude;
                          if (Platform.isAndroid) {
                            final AndroidIntent intent = new AndroidIntent(
                                action: 'action_view',
                                data: Uri.encodeFull(
                                    "https://www.google.com/maps/dir/?api=1&origin=" +
                                        origin +
                                        "&destination=" +
                                        destination +
                                        "&travelmode=driving&dir_action=navigate"),
                                package: 'com.google.android.apps.maps');
                            intent.launch();
                          } else {
                            String url =
                                "https://www.google.com/maps/dir/?api=1&origin=" +
                                    origin +
                                    "&destination=" +
                                    destination +
                                    "&travelmode=driving&dir_action=navigate";
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          }
                        },
                        child: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Center(
                                  child: Text(
                                'الخريطه',
                                style: TextStyle(fontSize: 18.0),
                              )),
                              color: Colors.deepOrange,
                              height: 44,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        child: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Center(
                                  child: Text(
                                'انهاء',
                                style: TextStyle(fontSize: 18.0),
                              )),
                              color: Colors.blue,
                              height: 44,
                            ),
                          ),
                        ),
                        onTap: () {
                          Orders().finishOrder(id);
                          Provider.of<OrderListProvider>(context, listen: false)
                              .removeNew(id);
                        },
                      ),
                    ]
                  : [
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    OrderDetail(order))),
                        child: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Center(
                                  child: Text(
                                'تفاصيل',
                                style: TextStyle(fontSize: 18.0),
                              )),
                              color: Colors.indigo[400],
                              height: 44,
                            ),
                          ),
                        ),
                      ),
                    ],
            )
          ],
        ),
      ),
    );
  }
}
