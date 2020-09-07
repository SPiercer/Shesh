import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shesha/API/Orders.dart';
import 'package:shesha/Components/OrderItem.dart';
import 'package:shesha/Models/Order.dart';
import 'package:shesha/Providers/OrdersList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController _tabController;
  @override
  initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
  }

  int page = 1;
  bool isLoadingN = false;
  bool firstTimeN = true;
  bool isLoadingO = false;
  bool firstTimeO = true;
  @override
  Widget build(BuildContext context) {
    List<Order> newOrderList =
        Provider.of<OrderListProvider>(context).newOrderList;
    List<Order> oldOrderList =
        Provider.of<OrderListProvider>(context).oldOrderList;

    Future _loadNewData() async {
      Map<String, dynamic> firstOrderPage = await Orders().newOrders(0);
      if (firstTimeN) {
        setState(() {
          for (var order in firstOrderPage['orders']['data']) {
            newOrderList.add(Order.fromJson(order));
          }
          isLoadingN = false;
          firstTimeN = false;
        });
      }

      if (firstOrderPage['orders']['next_page_url'] != null) {
        for (int i = 1; i <= firstOrderPage['orders']['last_page']; i++) {
          Map<String, dynamic> nextOrderPage = await Orders().newOrders(i);
          for (var order in nextOrderPage['orders']['data']) {
            setState(() {
              newOrderList.add(Order.fromJson(order));
            });
          }
        }
      }
      setState(() {
        isLoadingN = false;
      });
    }

    Future _loadOldData() async {
      Map<String, dynamic> firstOrderPage = await Orders().oldOrders(0);
      if (firstTimeO) {
        setState(() {
          for (var order in firstOrderPage['orders']['data']) {
            if (order['status'] == 'finished') {
              oldOrderList.add(Order.fromJson(order));
            }
          }
          isLoadingO = false;
          firstTimeO = false;
        });
      }

      if (firstOrderPage['orders']['next_page_url'] != null) {
        for (int i = 1; i <= firstOrderPage['orders']['last_page']; i++) {
          Map<String, dynamic> nextOrderPage = await Orders().oldOrders(i);
          for (var order in nextOrderPage['orders']['data']) {
            setState(() {
              if (order['status'] == 'finished') {
                oldOrderList.add(Order.fromJson(order));
              }
            });
          }
        }
      }
      setState(() {
        isLoadingO = false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('مكاني الحالي'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
            ),
          )
        ],
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            tooltip: 'Open Drawer',
            onPressed: Scaffold.of(context).openDrawer,
            icon: Icon(
              Icons.menu,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: Container(
              height: 48.0,
              alignment: Alignment.center,
              child: TabBar(
                controller: _tabController,
                tabs: <Tab>[
                  Tab(
                    text: 'الطلبات المنتهية',
                  ),
                  Tab(text: 'الطلبات الجاريه'),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: Drawer(),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  // ignore: missing_return
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!isLoadingO &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      _loadOldData();
                      setState(() {
                        isLoadingO = true;
                      });
                    }
                  },
                  child: ListView.builder(
                    itemCount: oldOrderList.length,
                    itemBuilder: (context, index) {
                      return OrderItem(oldOrderList[index], index);
                    },
                  ),
                ),
              ),
              Container(
                height: isLoadingO ? 50.0 : 0,
                color: Colors.transparent,
                child: Center(
                  child: new CircularProgressIndicator(),
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  // ignore: missing_return
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!isLoadingN &&
                        scrollInfo.metrics.pixels ==
                            scrollInfo.metrics.maxScrollExtent) {
                      _loadNewData();
                      setState(() {
                        isLoadingN = true;
                      });
                    }
                  },
                  child: ListView.builder(
                    itemCount: newOrderList.length,
                    itemBuilder: (context, index) {
                      return OrderItem(newOrderList[index], index);
                    },
                  ),
                ),
              ),
              Container(
                height: isLoadingN ? 50.0 : 0,
                color: Colors.transparent,
                child: Center(
                  child: new CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
