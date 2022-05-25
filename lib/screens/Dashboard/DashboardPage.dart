import 'package:bike_junction_customer/screens/AddPickUp/AddPickUpPage.dart';
import 'package:bike_junction_customer/screens/Dashboard/tabs/CurrentPickUps.dart';
import 'package:bike_junction_customer/screens/Dashboard/tabs/MyPickUpsTab.dart';
import 'package:bike_junction_customer/utils/MyAssets.dart';
import 'package:bike_junction_customer/utils/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.app_theme_color,
          title: Row(
            children: [
              Text(
                "Bike",
                style: TextStyle(color: Colors.red),
              ),
              Text(
                "Junction",
                style: TextStyle(color: MyColors.white),
              ),
            ],
          ),
          leading: Icon(Icons.person),
        ),
        body: SafeArea(
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: Container(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                color: MyColors.screen_background,
                child: Column(
                  children: [
                    Material(
                      color: MyColors.app_theme_color,
                      child: TabBar(
                          physics: ScrollPhysics(),
                          labelColor: MyColors.creamYellow,
                          isScrollable: false,
                          unselectedLabelColor: Colors.white,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                  width: 3.0, color: MyColors.creamYellow),
                              insets: EdgeInsets.symmetric(horizontal: 0.0)),
                          indicatorWeight: 2.0,
                          labelPadding:
                              EdgeInsets.only(left: 30.0, right: 30.0),
                          tabs: [
                            Tab(
                              child: Text(
                                "CURRENT PICKUPS",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "MY PICKUPS",
                                style: TextStyle(fontSize: 12),
                              ),
                            )
                          ]),
                    ),
                    Expanded(child: mainBody())
                  ],
                ),
              ),
            );
          }),
        ),
        floatingActionButton: GestureDetector(
          onTap: () {
            _navigateAndDisplaySelection(context);
            /*Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddPickUpPage()));*/
          },
          child: CircleAvatar(
            radius: 25,
            backgroundColor: MyColors.creamYellow,
            child: Icon(
              Icons.add,
              color: MyColors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateAndDisplaySelection(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddPickUpPage()))
        .then((value) => setState(() {
              print("--$value");
              CurrentPickUpsTab.globalKey.currentState!.checkConnection();
            }));
  }

  Widget mainBody() {
    return TabBarView(
      physics: AlwaysScrollableScrollPhysics(),
      children: [CurrentPickUpsTab(), MyPickUpsTab()],
    );
  }
}
