import 'package:MyInv_flutter/models/category.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(

        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                //height: 80,
                width: 90,
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    category.category,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              Container(
                //height: 80,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)
                  ),
                    gradient: RadialGradient(
                        colors: [category.begin, category.end],
                        center: Alignment(0, 0),
                        radius: 0.8,
                        focal: Alignment(0, 0),
                        focalRadius: 0.1)),
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Image.asset(category.image),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
