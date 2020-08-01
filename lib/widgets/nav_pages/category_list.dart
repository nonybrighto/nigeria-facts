import 'package:dailyfactsng/bloc/bloc_provider.dart';
import 'package:dailyfactsng/bloc/category_bloc.dart';
import 'package:dailyfactsng/constants/constants.dart';
import 'package:dailyfactsng/models/category.dart';
import 'package:dailyfactsng/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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
          if (!categoriesSnapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          int columnCount = 2;
          return Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            // child: GridView(
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: MediaQuery.of(context).size.width > 360 ? 3 : 2,
            //     mainAxisSpacing: 5,
            //     crossAxisSpacing: 5
            //   ),
            //   children: categories.map((category) => CategoryCard(category: category)).toList()
            // ),
            child: AnimationLimiter(
              child: GridView.count(
                childAspectRatio: 1.0,
                padding: const EdgeInsets.all(8.0),
                crossAxisCount: columnCount,
                children: List.generate(
                  categories.length,
                  (int index) {
                    return AnimationConfiguration.staggeredGrid(
                      columnCount: columnCount,
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: ScaleAnimation(
                        scale: 0.5,
                        child: FadeInAnimation(
                          child: CategoryCard(
                            category: categories[index],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        });
  }
}
