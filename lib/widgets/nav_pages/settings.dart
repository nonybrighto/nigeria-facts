import 'package:dailyfactsng/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:dailyfactsng/pages/about_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
     return SingleChildScrollView(
        child:  Column(
          children: <Widget>[
            ListTile(
              title: Text('Show Notification', style: titleStyle,),
              leading: Icon(FontAwesomeIcons.infoCircle),
              subtitle: Text('We would love to get your suggestions. The fact ill be attributed to you in the source.'),
              onTap: (){
                launch('mailto:$kContactEmail?subject=Suggestion title&body=Suggestion \n');
              },
            ),
            ListTile(
              title: Text('Suggest Fact', style: titleStyle,),
              leading: Icon(FontAwesomeIcons.infoCircle),
              subtitle: Text('We would love to get your suggestions. The fact ill be attributed to you in the source.'),
              onTap: (){
                launch('mailto:$kContactEmail?subject=Suggestion title&body=Suggestion \n');
              },
            ),
            Divider(),
            ListTile(
              title: Text('Contact Us', style: titleStyle),
              leading: Icon(FontAwesomeIcons.infoCircle),
              onTap: (){
                launch('mailto:$kContactEmail?subject=Hello&body=$kAppName - $kAppVersion \n Hi.');
              },
            ),
            ListTile(
              title: Text('About', style: titleStyle),
              leading: Icon(FontAwesomeIcons.infoCircle),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AboutPage()));
              },
            )
          ],
        ));
  }
}