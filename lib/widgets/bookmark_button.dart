import 'package:dailyfactsng/bloc/bloc_provider.dart';
import 'package:dailyfactsng/bloc/fact_bloc.dart';
import 'package:dailyfactsng/constants/constants.dart';
import 'package:dailyfactsng/models/fact.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookmarkButton extends StatelessWidget {

 final Fact fact;
 final FactBloc factBloc;
 final bool dark;
  BookmarkButton({this.fact, this.factBloc, this.dark = false});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
          child: IconButton(
                          icon: fact.isBookmarked
                              ? Icon(
                                  Icons.bookmark,
                                  color: Colors.redAccent,
                                )
                              : Icon(
                                  FontAwesomeIcons.bookmark,
                                  color: dark ? kSecondaryColor : Colors.white,
                                ),
                          onPressed: () {
                            FactBloc bloc = factBloc != null ? factBloc : BlocProvider.of<FactBloc>(context);
                            bloc.toggleBookmark(
                                fact: fact,
                                toggleCallback: (toggled) {
                                  if (!toggled) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Failed to bookmark fact'),
                                    ));
                                  }
                                });
                          },
                        ),
    );
  }
}