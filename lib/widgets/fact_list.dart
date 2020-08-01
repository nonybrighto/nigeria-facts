import 'package:dailyfactsng/bloc/bloc_provider.dart';
import 'package:dailyfactsng/bloc/fact_bloc.dart';
import 'package:dailyfactsng/models/fact.dart';
import 'package:dailyfactsng/widgets/fact_card.dart';
import 'package:dailyfactsng/widgets/general/scroll_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class FactList extends StatefulWidget {
  final PageStorageKey pageStorageKey;
  FactList({Key key, this.pageStorageKey}) : super(key: key);

  @override
  _FactListState createState() => new _FactListState();
}

class _FactListState extends State<FactList> {
  FactBloc factBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    factBloc = BlocProvider.of<FactBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScrollList<Fact>(
            listContentStream: factBloc.items,
            loadStateStream: factBloc.loadState,
            pageStorageKey: widget.pageStorageKey,
            loadMoreAction: () {
              factBloc.getItems();
            },
            currentListItemWidget: (fact, int index) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 44.0,
                    child: FadeInAnimation(
                      delay: const Duration(milliseconds: 375),
                      child: FactCard(fact: fact),
                    ),
                  ),
                );
            },
          );
  }
}
