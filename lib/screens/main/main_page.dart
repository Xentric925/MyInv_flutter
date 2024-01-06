import 'dart:convert';
import 'dart:core';

import 'package:MyInv_flutter/app_properties.dart';
import 'package:MyInv_flutter/custom_background.dart';
import 'package:MyInv_flutter/models/product.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/Person.dart';
import '../auth/Login_page.dart';
import 'components/custom_bottom_bar.dart';
import 'components/product_list.dart';
import 'components/tab_view.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

List<String> timelines = ['New Arrivals'];
String selectedTimeline = 'New Arrivals';
late final Dio dio = Dio(BaseOptions(receiveDataWhenStatusError: true,validateStatus: (status) { return status! < 500; },extra: {'withCredentials': true}));
List<Product> products = [];
Map<String,List<Product>> timelineProducts={};
List<Product> currProducts = [];

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  late TabController tabController;
  late TabController bottomTabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    bottomTabController = TabController(length: 4, vsync: this);
    //checkLogin();
    getNewArrivals();
    getProducts();
  }
  Future<void> checkLogin() async {
    String url="";
    kIsWeb? url="http://localhost/MyInv/auth/check_login.php":url="http://10.0.2.2/MyInv/auth/check_login.php";
    print("before response checkLogin");
    try {
      var response = await dio.get(url);
      print(response.statusCode);
      print("after response checkLogin");
      if (response.statusCode != 200) {
        // Session is set, navigate to MainPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } catch (error) {
      print('after response with error');
      print(error);
    }
  }
  Future<void> getProducts() async {
    //print("before response");
    try {
      String url="";
      kIsWeb? url="http://localhost//MyInv/actions/productDetails.php":url="http://10.0.2.2/MyInv/actions/productDetails.php";
      var response = await dio.post(url,data: {'withImage':'true'},options: Options(headers: {'Accept': 'application/json'} ));
      //print("after response");
      //print(response.statusCode);
      if (response.statusCode == 200) {
        // Session is set, navigate to MainPage
        //print(response.data);
        String s=jsonEncode(response.data);
        final List jsonData = jsonDecode(s);
        products = jsonData.map((json) => Product.fromJson(json)).toList();
        //print(products);
      }
      else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } on DioException catch (error) {
      print("error in getProducts()"+error.message!);
      print(error.type.name);
    }
  }
  Future<void> getNewArrivals() async {
    //print("before response");
    try {
      String url="";
      kIsWeb? url="http://localhost//MyInv/actions/newArrival.php":url="http://10.0.2.2/MyInv/actions/newArrival.php";
      var response = await dio.get(url);
      print("after response");
      print(response.statusCode);
      if (response.statusCode == 200) {
        //print(response.data.toString());
        final List jsonData = jsonDecode(response.data.toString());
        setState(() {
          timelineProducts['New Arrival'] = jsonData.map((json) => Product.fromJson(json)).toList();
          currProducts=timelineProducts['New Arrival']!;
        });
      }
      else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } on DioException catch (error) {
      print("error in getNewArrivals()"+error.message!);
      print(error.type.name);
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget appBar = Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.notifications,
                color: Colors.blueGrey,
              )),
          IconButton(
              onPressed:  () async
                  {
                    await Person.logout();
                    Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => LoginPage()));
                  },
              icon: Icon(Icons.logout,color: Colors.white,))
        ],
      ),
    );
    Widget generateInkWell(int index) {
      return Flexible(
        child: InkWell(
          onTap: () {
            setState(() {
              selectedTimeline = timelines[index];
              currProducts=timelineProducts[selectedTimeline]!;;
            });
          },
          child: Text(
            timelines[index],
            style: TextStyle(
                fontSize: timelines[index] == selectedTimeline ? 20 : 14,
                color: timelines[index] == selectedTimeline ?Colors.blueGrey:Colors.grey,
            ),
          ),
        ),
      );
    }

    Widget topHeader = Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          generateInkWell(0),
        ],
      ),
    );

    Widget tabBar = TabBar(
      tabs: [
        Tab(text: 'Trending'),
        Tab(text: 'Sports'),
        Tab(text: 'Headsets'),
        Tab(text: 'Wireless'),
        Tab(text: 'Bluetooth'),
      ],
      labelStyle: TextStyle(fontSize: 16.0,color: Colors.white54),
      unselectedLabelStyle: TextStyle(
        fontSize: 14.0,color: Colors.lightBlueAccent
      ),
      labelColor: darkGrey,
      unselectedLabelColor: Color.fromRGBO(0, 0, 0, 0.5),
      isScrollable: true,
      controller: tabController,
    );

    return Theme(
      data: ThemeData(
        primaryColor: Colors.blueGrey,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
        ).copyWith(
          secondary: Colors.blueGrey[700],
        ),
        textTheme: GoogleFonts.openSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      child: Scaffold(
        bottomNavigationBar: CustomBottomBar(controller: bottomTabController),
        body: Stack(children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.42),
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          CustomPaint(
            painter: MainBackground(),
            child: TabBarView(
              controller: bottomTabController,
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                SafeArea(
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      // These are the slivers that show up in the "outer" scroll view.
                      return <Widget>[
                        SliverToBoxAdapter(
                          child: appBar,
                        ),
                        SliverToBoxAdapter(
                          child: topHeader,
                        ),
                        SliverToBoxAdapter(
                          child: ProductList(
                            products: currProducts,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: tabBar,
                        )
                      ];
                    },
                    body: TabView(
                      tabController: tabController,products: products,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
