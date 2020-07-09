import 'package:dailyfactsng/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:dailyfactsng/widgets/nav_pages/home_fact_list.dart';
import 'package:dailyfactsng/widgets/nav_pages/bookmark_list.dart';
import 'package:dailyfactsng/widgets/nav_pages/category_list.dart';
import 'package:dailyfactsng/widgets/nav_pages/settings.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  List<Map> _navPages;


  @override
  void initState() {
    super.initState();
    _navPages = [
  {'title': 'Random Facts', 'widget':  HomeFactList()},
  {'title': 'Bookmarks', 'widget':  BookmarkList()},
  {'title': 'Categories', 'widget':   CategoryList()},
  {'title': 'Settings', 'widget':  Settings()}
 ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(title: Text(_navPages[_selectedIndex]['title']), actions: <Widget>[
        IconButton(icon: Icon(Icons.search), onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchPage()));
        })
      ],),
      body: _navPages[_selectedIndex]['widget'],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Bookmarks'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Settings'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}