import 'package:dailyfactsng/models/category.dart';
import 'package:dailyfactsng/pages/category_facts_page.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  CategoryCard({this.category});

  @override
  Widget build(BuildContext context) {
    final itemCategory = _getCategoryContents(category.id);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: AssetImage(itemCategory.assetImage), fit: BoxFit.cover)),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: itemCategory.color.withOpacity(0.5)),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoryFactsPage(
                            category: category,
                          )));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        itemCategory.icon,
                        color: Colors.white,
                        size: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Hello & welcome to it and here',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
    // return InkWell(child: Text(category.name), onTap: (){
    //    Navigator.of(context).push(MaterialPageRoute(
    //             builder: (context) => CategoryFactsPage(category: category,)));
    // },);
  }

  CategoryContent _getCategoryContents(String categoryId) {
    List<CategoryContent> contents = [
      CategoryContent(
          assetImage: 'assets/images/fact_place_holder.png',
          color: Colors.redAccent,
          icon: Icons.chrome_reader_mode),
      CategoryContent(
          assetImage: 'assets/images/fact_place_holder.png',
          color: Colors.blue,
          icon: Icons.child_friendly),
      CategoryContent(
          assetImage: 'assets/images/fact_place_holder.png',
          color: Colors.redAccent,
          icon: Icons.cloud_circle),
      CategoryContent(
          assetImage: 'assets/images/fact_place_holder.png',
          color: Colors.redAccent,
          icon: Icons.child_friendly),
      CategoryContent(
          assetImage: 'assets/images/fact_place_holder.png',
          color: Colors.redAccent,
          icon: Icons.child_friendly),
      CategoryContent(
          assetImage: 'assets/images/fact_place_holder.png',
          color: Colors.redAccent,
          icon: Icons.child_friendly),
    ];

    return contents[1];
  }
}

class CategoryContent {
  String assetImage;
  Color color;
  IconData icon;

  CategoryContent({this.assetImage, this.color, this.icon});
}
