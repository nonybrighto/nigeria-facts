import 'package:cached_network_image/cached_network_image.dart';
import 'package:dailyfactsng/bloc/bloc_provider.dart';
import 'package:dailyfactsng/bloc/category_bloc.dart';
import 'package:dailyfactsng/bloc/fact_bloc.dart';
import 'package:dailyfactsng/models/category.dart';
import 'package:dailyfactsng/models/fact.dart';
import 'package:dailyfactsng/pages/fact_display_page.dart';
import 'package:dailyfactsng/widgets/bookmark_button.dart';
import 'package:dailyfactsng/widgets/share_button.dart';
import 'package:flutter/material.dart';

class FactCard extends StatelessWidget {
  final Fact fact;
  FactCard({this.fact});
  @override
  Widget build(BuildContext context) {
    double borderRadius = 20;
    double imageHeight = 220;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(borderRadius),
                          topRight: Radius.circular(borderRadius)),
                      child: Hero(
                        tag: 'factImage' + fact.id,
                        child: CachedNetworkImage(
                          height: imageHeight,
                          width: double.infinity,
                          imageUrl: fact.imageUrl,
                          fit: BoxFit.cover,
                          fadeInDuration: Duration(milliseconds: 800),
                          placeholder: (context, url) => Container(
                            width: double.infinity,
                            height: imageHeight,
                            decoration: BoxDecoration(
                                // color: Colors.black54,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        'assets/images/fact_place_holder.png'))),
                          ),
                        ),
                      )),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      child: Hero(
                        tag: 'bookmarkButton' + fact.id,
                        child: BookmarkButton(
                          fact: fact,
                        ),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                                                      child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  fact.title,
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.w500),
                                ),
                                StreamBuilder<List<Category>>(
                                    initialData: [],
                                    stream: BlocProvider.of<CategoryBloc>(context)
                                        .categories,
                                    builder: (context, categoriesSnapshot) {
                                      Category category = categoriesSnapshot.data
                                          .firstWhere(
                                              (cat) => cat.id == fact.categoryId,
                                              orElse: () => null);
                                      return Text(
                                          category != null ? category.name : '');
                                    }),
                              ],
                            ),
                          ),
                          Transform.translate(
                            offset: const Offset(15, 0),
                            child: Hero(
                                tag: 'shareButton' + fact.id,
                                child: ShareButton(fact: fact)),
                          )
                        ],
                      ),
                    ),
                    Text(
                      fact.summary +
                          ' and the content will be the basis of all text in the file and now we move',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              )
            ],
          ),
          onTap: () {
            FactBloc _factBloc = BlocProvider.of<FactBloc>(context);
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FactDisplayPage(
                      fact: fact,
                      factBloc: _factBloc,
                    )));
          },
        ),
      ),
    );
  }
}
