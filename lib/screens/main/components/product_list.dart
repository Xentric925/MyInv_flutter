import 'package:card_swiper/card_swiper.dart';
import 'package:MyInv_flutter/app_properties.dart';
import 'package:MyInv_flutter/models/product.dart';
import 'package:MyInv_flutter/screens/product/product_page.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  List<Product> products;
  final SwiperController swiperController = SwiperController();

  ProductList({required this.products});

  @override
  Widget build(BuildContext context) {
    double cardHeight = MediaQuery.of(context).size.height / 3;
    double cardWidth = MediaQuery.of(context).size.width / 1.5;

    return SizedBox(
      height: cardHeight,
      child: Swiper(
        autoplay: true,
        autoplayDelay: 10000,
        autoplayDisableOnInteraction: true,
        allowImplicitScrolling: true,
        itemCount: products.length,
        itemBuilder: (_, index) {
          return ProductCard(
              height: cardHeight, width: cardWidth, product: products[index]);
        },
        scale: 0.8,
        controller: swiperController,
        viewportFraction: 0.6,
        loop: false,
        fade: 0.5,
        pagination: SwiperCustomPagination(
          builder: (context, config) {
            if (config.itemCount > 20) {
              print(
                  "The itemCount is too big, we suggest use FractionPaginationBuilder instead of DotSwiperPaginationBuilder in this sitituation");
            }
            Color activeColor = mediumYellow;
            Color color = Colors.grey.withOpacity(.3);
            double size = 10.0;
            double space = 5.0;

            if (config.indicatorLayout != PageIndicatorLayout.NONE &&
                config.layout == SwiperLayout.DEFAULT) {
              return new PageIndicator(
                count: config.itemCount,
                controller: config.pageController!,
                layout: config.indicatorLayout,
                size: size,
                activeColor: activeColor,
                color: color,
                space: space,
              );
            }

            List<Widget> dots = [];

            int itemCount = config.itemCount;
            int activeIndex = config.activeIndex;

            for (int i = 0; i < itemCount; ++i) {
              bool active = i == activeIndex;
              dots.add(Container(
                key: Key("pagination_$i"),
                margin: EdgeInsets.all(space),
                child: ClipOval(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: active ? activeColor : color,
                    ),
                    width: size,
                    height: size,
                  ),
                ),
              ));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: dots,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  ProductCard(
      {Key? key,
      required this.product,
      required this.height,
      required this.width})
      : super(key: key);
  final Product product;
  final double height;
  final double width;
  @override
  _ProductCardState createState() {
    return _ProductCardState();
  }
}

class _ProductCardState extends State<ProductCard> {
  Icon likeIcon = Icon(Icons.favorite_border);
  bool isLiked = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => ProductPage(product: widget.product))),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 40),
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              color: Colors.blueGrey,
            ),
          ),
          Positioned(
            left: 0,
            top: 10,
            child: Hero(
              tag: widget.product.image,
              child: Container(
                  height: widget.height-10,
                  width: widget.width / 1.35,
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                    ),
                    color: Colors.blueGrey,
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/"+widget.product.image,
                      ),
                      fit: BoxFit.fill,
                    ),
                  )
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: likeIcon,
                onPressed: () {
                  setState(() {
                    isLiked = !isLiked;
                    likeIcon = isLiked
                        ? Icon(Icons.favorite_border)
                        : Icon(
                      Icons.favorite,
                      color: Colors.red,
                    );
                  });
                },
                color: Colors.white,
              ),
              Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5.0),
                        padding: const EdgeInsets.fromLTRB(8.0, 4.0, 3.0, 4.0),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(width: 1.0, color: Colors.white.withOpacity(0.46),),
                            left: BorderSide(width: 1.0, color: Colors.white.withOpacity(0.46)),
                            bottom: BorderSide(width: 1.0, color: Colors.white.withOpacity(0.46)),
                            right: BorderSide(width: 0.0, color: Colors.white.withOpacity(0.46))
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          color: Color.fromRGBO(124, 129, 250, 0.75),
                        ),
                        child: Text(
                          widget.product.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 18.0),
                      padding: const EdgeInsets.fromLTRB(8.0, 4.0, 3.0, 4.0),
                      decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1.0, color: Colors.white.withOpacity(0.46),),
                            left: BorderSide(width: 1.0, color: Colors.white.withOpacity(0.46)),
                            bottom: BorderSide(width: 1.0, color: Colors.white.withOpacity(0.46)),
                            right: BorderSide(width: 0.0, color: Colors.white.withOpacity(0.46))
                        ),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10)),
                        color: Color.fromRGBO(224, 69, 10, 0.7),
                      ),
                      child: Text(
                        '\$${widget.product.price}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
