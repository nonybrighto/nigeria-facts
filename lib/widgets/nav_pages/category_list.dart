import 'package:dailyfactsng/bloc/bloc_provider.dart';
import 'package:dailyfactsng/bloc/category_bloc.dart';
import 'package:dailyfactsng/constants/constants.dart';
import 'package:dailyfactsng/models/category.dart';
import 'package:dailyfactsng/widgets/category_card.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {
  CategoryList({Key key}) : super(key: key);

  @override
  _CategoryListState createState() => new _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

   CategoryBloc _categoryBloc;
  @override
  void initState() {
    super.initState();
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);
    _categoryBloc.getCategories();
  }

  @override
  Widget build(BuildContext context) {
     return StreamBuilder<List<Category>>(
        stream: _categoryBloc.categories,
        builder: (context, categoriesSnapshot) {
          List<Category> categories = categoriesSnapshot.data;
          if(!categoriesSnapshot.hasData){
              return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width > 360 ? 3 : 2,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5
              ),
              children: categories.map((category) => CategoryCard(category: category)).toList()
            ),
          );
        }
      );
  }
}