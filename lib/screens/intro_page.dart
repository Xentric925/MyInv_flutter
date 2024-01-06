import 'package:MyInv_flutter/app_properties.dart';
import 'package:MyInv_flutter/screens/main/main_page.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController controller = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.42),
            ),
          ),
          PageView(
            onPageChanged: (value) {
              setState(() {
                pageIndex = value;
              });
            },
            controller: controller,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/find-product-icon.png', // Update this with the actual image asset
                      height: 200,
                      width: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Browse Existing Products',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16.0),
                    child: Text(
                      'Explore a wide range of products from various sellers.',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/unarchive-icon.png', // Update this with the actual image asset
                      height: 200,
                      width: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      'Host Your Own Products',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16.0),
                    child: Text(
                      'Link your store and start selling your products to a wider audience.',
                      textAlign: TextAlign.right,
                      style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    ),
                  ),
                ],
              ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        'assets/secondScreen.png',
                        height: 200,
                        width: 200,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Shipping to anywhere ',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16.0),
                      child: Text(
                        'We will ship to anywhere in the world, With 30 day 100% money back policy.',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.grey, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        'assets/thirdScreen.png',
                        height: 200,
                        width: 200,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'On-time delivery',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16.0),
                      child: Text(
                        'You can track your product with our powerful tracking service.',
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.grey, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              bottom: 16.0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(4, (i) =>
                          Container(
                            margin: EdgeInsets.all(8.0),
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: pageIndex == i ? yellow : Colors.white),
                            child:InkWell(onTap: (){setState(() {
                              controller.jumpToPage(i);
                            });}, mouseCursor: SystemMouseCursors.click,),
                          ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Opacity(
                          opacity: pageIndex != 3 ? 1.0 : 0.0,
                          child: TextButton(
                            child: Text(
                              'SKIP',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => MainPage()));
                            },
                          ),
                        ),
                        pageIndex != 3
                            ? TextButton(
                                child: Text(
                                  'NEXT',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onPressed: () {
                                  if (!(controller.page == 3.0))
                                    controller.nextPage(
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.linear);
                                },
                              )
                            : TextButton(
                                child: Text(
                                  'FINISH',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => MainPage()));
                                },
                              )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
  }
}
