import 'package:dailyfactsng/models/category.dart';
import 'package:dailyfactsng/pages/category_facts_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                image: AssetImage('assets/images/categories/'+itemCategory.assetImage), fit: BoxFit.cover)),
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
                          category.name,
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
  }

  CategoryContent _getCategoryContents(String categoryId) {
    List<CategoryContent> contents = [
      CategoryContent(
          assetImage: 'people.jpg',
          color: Colors.red,
          icon: FontAwesomeIcons.users),
      CategoryContent(
          assetImage: 'science.jpg',
          color: Colors.blue,
          icon: FontAwesomeIcons.flask),
      CategoryContent(
          assetImage: 'politics.jpg',
          color: Colors.green,
          icon: FontAwesomeIcons.fistRaised),
      CategoryContent(
          assetImage: 'art.jpg',
          color: Colors.yellow,
          icon: FontAwesomeIcons.palette),
      CategoryContent(
          assetImage: 'history.jpg',
          color: Colors.purple,
          icon: FontAwesomeIcons.monument),
      CategoryContent(
          assetImage: 'places.jpg', //orange, green , purple, blue, yellow, red
          color: Colors.redAccent,
          icon: FontAwesomeIcons.mapMarkerAlt),
      CategoryContent(
          assetImage: 'world.jpg',
          color: Colors.green,
          icon: FontAwesomeIcons.globeAfrica),
      CategoryContent(
          assetImage: 'agriculture.jpg',
          color: Colors.blue,
          icon: FontAwesomeIcons.pagelines),
      CategoryContent(
          assetImage: 'health.jpg',
          color: Colors.yellow,
          icon: FontAwesomeIcons.medkit),
      CategoryContent(
          assetImage: 'education.jpg',
          color: Colors.tealAccent,
          icon: FontAwesomeIcons.graduationCap),
      CategoryContent(
          assetImage: 'sports.jpg',
          color: Colors.pink,
          icon: FontAwesomeIcons.tableTennis),
      CategoryContent(
          assetImage: 'entertainment.jpg',
          color: Colors.purple,
          icon: FontAwesomeIcons.video),
      CategoryContent(
          assetImage: 'others.jpg',
          color: Colors.blue,
          icon: FontAwesomeIcons.doorClosed),
    ];
    return contents[int.parse(categoryId) - 1];
  }
}

class CategoryContent {
  String assetImage;
  Color color;
  IconData icon;

  CategoryContent({this.assetImage, this.color, this.icon});
}
