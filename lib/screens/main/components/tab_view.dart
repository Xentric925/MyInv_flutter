import 'package:MyInv_flutter/models/category.dart';
import 'package:flutter/material.dart';
import '../../../models/product.dart';
import 'category_card.dart';
import 'recommended_list.dart';

class TabView extends StatelessWidget {
  List<Product> products=[];
  final List<Category> categories = [
    Category(
      Color(0xffFCE183),
      Color(0xffF68D7F),
      'Gadgets',
      'assets/headphone_5.png',
    ),
    Category(
      Color(0xffF749A2),
      Color(0xffFF7375),
      'Clothes',
      'assets/jeans_4.png',
    ),
    Category(
      Color(0xff00E9DA),
      Color(0xff5189EA),
      'Fashion',
      'assets/cap_5.png',
    ),
    Category(
      Color(0xffAF2D68),
      Color(0xff632376),
      'Home',
      'assets/box.png',
    ),
    Category(
      Color(0xff36E892),
      Color(0xff33B2B9),
      'Beauty',
      'assets/ring_5.png',
    ),
  ];

  final TabController tabController;

  TabView({
    required this.tabController,required this.products
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          SafeArea(
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height / 9,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (_, index) => CategoryCard(
                              category: categories[index],
                            ))),
                SizedBox(
                  height: 16.0,
                ),
                Flexible(child: RecommendedList()),
                Flexible(child: RecommendedList(products: products,)),
              ],
            ),
          ),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList()),
            Flexible(child: RecommendedList(products: products,)),
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList()),
            Flexible(child: RecommendedList(products: products,)),
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList()),
            Flexible(child: RecommendedList(products: products,)),
          ]),
          Column(children: <Widget>[
            SizedBox(
              height: 16.0,
            ),
            Flexible(child: RecommendedList()),
            Flexible(child: RecommendedList(products: products,)),
          ]),
        ]);
  }
}
