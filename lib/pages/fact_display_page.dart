import 'package:cached_network_image/cached_network_image.dart';
import 'package:dailyfactsng/bloc/fact_bloc.dart';
import 'package:dailyfactsng/constants/constants.dart';
import 'package:dailyfactsng/helpers/database_helper.dart';
import 'package:dailyfactsng/models/fact.dart';
import 'package:dailyfactsng/models/fact_source.dart';
import 'package:dailyfactsng/services/local/fact_local.dart';
import 'package:dailyfactsng/widgets/bookmark_button.dart';
import 'package:dailyfactsng/widgets/share_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FactDisplayPage extends StatefulWidget {
  final Fact fact;
  final FactBloc factBloc;
  FactDisplayPage({Key key, this.fact, this.factBloc}) : super(key: key);

  @override
  _FactDisplayPageState createState() => new _FactDisplayPageState();
}

class _FactDisplayPageState extends State<FactDisplayPage> {
  bool showSource = false;
  @override
  void initState() {
    super.initState();
    widget.factBloc.setCurrentFact(widget.fact);
  }

  @override
  Widget build(BuildContext context) {
    const double expandedHeight = 300;
    return Scaffold(
        body: StreamBuilder<Fact>(
            stream: widget.factBloc.currentFact,
            builder: (context, currentFactSnapshot) {
              Fact fact = currentFactSnapshot.data;
              return !currentFactSnapshot.hasData
                  ? Container()
                  : CustomScrollView(
                      slivers: <Widget>[
                        SliverAppBar(
                          expandedHeight: expandedHeight,
                          floating: true,
                          pinned: true,
                          flexibleSpace: FlexibleSpaceBar(
                            title: Text(fact.title),
                            background: Hero(
                              tag: 'factImage' + fact.id,
                              child: CachedNetworkImage(
                                height: expandedHeight,
                                width: double.infinity,
                                imageUrl: fact.imageUrl,
                                fit: BoxFit.cover,
                                fadeInDuration: Duration(milliseconds: 800),
                                placeholder: (context, url) => Container(
                                  width: double.infinity,
                                  height: expandedHeight,
                                  decoration: BoxDecoration(
                                      // color: Colors.black26,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/fact_place_holder.png'))),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                            child: Padding(
                          padding: const EdgeInsets.all(kDefaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  _buildIconWrap(
                                      Hero(
                                        tag: 'bookmarkButton' + fact.id,
                                        child: BookmarkButton(
                                            fact: fact,
                                            factBloc: widget.factBloc,
                                            dark: true),
                                      ),
                                      "Save"),
                                  _buildIconWrap(
                                      Hero(
                                        tag: 'shareButton' + fact.id,
                                        child: ShareButton(
                                          fact: fact,
                                        ),
                                      ),
                                      "Share")
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                fact.description +
                                    ' and this is the man that took the content from the place',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              // RaisedButton(
                              //     child: Container(
                              //       decoration: const BoxDecoration(
                              //         gradient: LinearGradient(
                              //           colors: <Color>[
                              //             kGradientFirstColor,
                              //             kGradientSecondColor
                              //           ],
                              //         ),
                              //       ),
                              //       child: const Text('View Sources',
                              //           style: TextStyle(fontSize: 20)),
                              //     ),
                              //     onPressed: () {
                              //       setState(() {
                              //         showSource = !showSource;
                              //       });
                              //     }),
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        kGradientFirstColor,
                                        kGradientSecondColor
                                      ],
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white,
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(30),
                                        onTap: () {
                                          setState(() {
                                            showSource = !showSource;
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Text(
                                            'View Sources',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (showSource)
                                FutureBuilder<List<FactSource>>(
                                    future:
                                        FactLocal(dbHelper: DatabaseHelper())
                                            .getFactSources(widget.fact.id),
                                    initialData: [],
                                    builder: (context, factSourcesSnapshot) {
                                      final factSources =
                                          factSourcesSnapshot.data;
                                      return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            ...factSources.map((source) =>
                                                _buildSourceDisplay(source))
                                          ]);
                                    })
                            ],
                          ),
                        ))
                      ],
                    );
            }));
  }

  _buildIconWrap(Widget icon, String title) {
    return Column(
      children: <Widget>[
        icon,
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  _buildSourceDisplay(FactSource source) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: InkWell(
        child: Text(
          source.title,
          style: TextStyle(
              fontSize: 16,
              color: source.link == null ? kTextColor : kSecondaryColor),
        ),
        onTap: source.link != null
            ? () {
                launch(source.link);
              }
            : null,
      ),
    );
  }
}
