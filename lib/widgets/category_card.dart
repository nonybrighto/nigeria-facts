import 'package:dailyfactsng/models/category.dart';
import 'package:dailyfactsng/pages/category_facts_page.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {

  final Category category;
  CategoryCard({this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(child: Text(category.name), onTap: (){
       Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CategoryFactsPage(category: category,)));
    },);
  }
}