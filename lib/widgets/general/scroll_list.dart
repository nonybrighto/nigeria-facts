import 'dart:collection';

import 'package:dailyfactsng/models/load_state.dart';
import 'package:dailyfactsng/widgets/general/main_error_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ScrollList<T> extends StatefulWidget {
  final Stream<LoadState> loadStateStream;
  final Stream<UnmodifiableListView<T>> listContentStream;
  final Function loadMoreAction;
  final Widget Function(T, int) currentListItemWidget;
  final int gridCrossAxisCount;
  final PageStorageKey pageStorageKey;
  final ScrollController scrollController;

  ScrollList(
      {Key key,
      this.loadStateStream,
      this.listContentStream,
      this.loadMoreAction,
      this.currentListItemWidget,
      this.gridCrossAxisCount,
      this.pageStorageKey,
      this.scrollController,
      })
      : super(key: key);

  @override
  _ScrollListState<T> createState() => new _ScrollListState<T>();
}

class _ScrollListState<T> extends State<ScrollList<T>> {
  ScrollController _scrollController;
  bool canLoadMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController = (widget.scrollController != null)? widget.scrollController : ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.extentAfter < 2000 && canLoadMore) {
      widget.loadMoreAction();
      canLoadMore = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LoadState>(
      stream: widget.loadStateStream,
      builder: (BuildContext context, AsyncSnapshot<LoadState> snapshot) {
        LoadState loadState = snapshot.data;

        if (loadState is LoadComplete &&
            !(loadState is LoadEnd) &&
            !(loadState is ErrorLoad)) {
          canLoadMore = true;
        } else {
          canLoadMore = false;
        }

        if (loadState is Loading || loadState == null) {
          return _initialProgress();
        } else if (loadState is LoadError) {
          return _initialError(loadState.message, onRetry: () {
            widget.loadMoreAction();
          });
        } else if (loadState is LoadEmpty) {
          return _showEmpty(loadState.message);
        } else {
          return _contentList(loadState, widget.pageStorageKey);
        }
      },
    );
  }

  _initialProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _initialError(String message, {Function onRetry}) {
    return MainErrorDisplay(
      errorMessage: message,
      buttonText: 'RETRY',
      onErrorButtonTap: onRetry,
    );
  }

  _moreError(String message, {Function onRetry}) {
    return ListTile(
        title: Text(message, style: TextStyle(fontSize: 18),),
        trailing: RaisedButton(
            child: Text('RETRY'),
            onPressed: () {
              print('reload more pressed');
              onRetry();
            }));
  }

  _showEmpty(String message) {
    return Center(
      child: Text(message, style: TextStyle(fontSize: 18),),
    );
  }

  _contentList(LoadState loadState, PageStorageKey pageStorageKey) {
    return StreamBuilder<UnmodifiableListView<T>>(
      stream: widget.listContentStream,
      builder: (BuildContext context,
          AsyncSnapshot<UnmodifiableListView<T>> listItemSnapshot) {
        UnmodifiableListView<T> listItems = listItemSnapshot.data;
        if(listItems == null){
          return Container();
        }
        return _buildListView(loadState, listItems, pageStorageKey);
      },
    );
  }

  _buildListView(LoadState loadState, UnmodifiableListView<T> listItems,
      PageStorageKey pageStorageKey) {
    return AnimationLimiter(
          child: ListView.builder(
        key: pageStorageKey,
        shrinkWrap: true,
        controller: _scrollController,
        itemCount: (loadState is LoadingMore || loadState is LoadMoreError)
            ? listItems.length + 1
            : listItems.length,
        itemBuilder: (BuildContext context, int index) {
          if (index < listItems.length) {
            return widget.currentListItemWidget(listItems[index], index);
          } else if (loadState is LoadingMore) {
            return _buildBottomProgress();
          } else if (loadState is LoadMoreError) {
            return _moreError(loadState.message, onRetry: () {
              widget.loadMoreAction();
            });
          }
          return Container();
        },
      ),
    );
  }

  _buildBottomProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
