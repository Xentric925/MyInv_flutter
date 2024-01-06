import 'package:MyInv_flutter/app_properties.dart';
import 'package:MyInv_flutter/models/product.dart';
import 'package:MyInv_flutter/screens/product/product_page.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

class RecommendedList extends StatelessWidget {
  List<Product>? products;
  RecommendedList({this.products});
  List<Product> recommendedProducts = [
    Product(99999999990,'bag_1.png', 'Bag', 'Beautiful bag', 2.33),
    Product(99999999991,'cap_5.png', 'Cap', 'Cap with beautiful design', 10),
    Product(99999999992,'jeans_1.png', 'Jeans', 'Jeans for you', 20),
    Product(99999999993,'womanshoe_3.png', 'Woman Shoes', 'Shoes with special discount', 30),
    Product(99999999994,'bag_10.png', 'Bag Express', 'Bag for your shops', 40),
    Product(99999999995,'jeans_3.png', 'Jeans', 'Beautiful Jeans', 102.33),
    Product(99999999996,'ring_1.png', 'Silver Ring', 'Description', 52.33),
    Product(99999999997,'shoeman_7.png', 'Shoes', 'Description', 62.33),
    Product(99999999998,'headphone_9.png', 'Headphones', 'Description', 72.33),
  ];


  @override
  Widget build(BuildContext context) {
    products==null?products=recommendedProducts:products=products;
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              IntrinsicHeight(
                child: Container(
                  margin: const EdgeInsets.only(left: 16.0, right: 8.0),
                  width: 4,
                  color: mediumYellow,
                ),
              ),
              Center(
                  child: Text(
                products==recommendedProducts?'Recommended':'Products',
                style: TextStyle(
                    color: darkGrey,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              )),
            ],
          ),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0),
            child: MasonryGridView.count(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              crossAxisCount: 3,
              itemCount: products!.length,
              itemBuilder: (BuildContext context, int index) => new ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ProductPage(product: products![index]))),
                  child: Container(
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                            colors: [
                              Colors.grey.withOpacity(0.3),
                              Colors.grey.withOpacity(0.7),
                            ],
                            center: Alignment(0, 0),
                            radius: 0.6,
                            focal: Alignment(0, 0),
                            focalRadius: 0.1),
                      ),
                      child: Stack(
                          children: [
                            Image.asset("assets/"+products![index].image,fit: BoxFit.contain/*,height: double.infinity,width: double.infinity*/,),
                            Positioned(
                                child: Container(
                                  child:Text(
                                    products![index].price.toString()+"\$",
                                    style: TextStyle(color: Colors.white,fontSize: 16.0,fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),color: Color.fromRGBO(224, 69, 10, 0.8)),
                                ),
                                bottom: 2.0,
                                right: 0)
                          ]
                      )
                  ),
                ),
              ),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          ),
        ),
      ],
    );
  }
}

