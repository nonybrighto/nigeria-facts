import 'package:dailyfactsng/bloc/fact_bloc.dart';
import 'package:dailyfactsng/constants/constants.dart';
import 'package:dailyfactsng/services/local/fact_local.dart';
import 'package:flutter/material.dart';
import 'package:dailyfactsng/pages/about_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  FactBloc factBloc = FactBloc(fetchType: null, factLocal: FactLocal(dbHelper: null));
  double ff = 5;
  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 15);
     return SingleChildScrollView(
        child:  Column(
          children: <Widget>[
           StreamBuilder<bool>(
              initialData: false,
              stream: factBloc.showNotification,
              builder: (context, showNotificationSnapshot) {
                bool showNotification = showNotificationSnapshot.data;
                return ListTile(
                  title: Text((showNotification) ? 'Turn off Notifications' : 'Show Notifications'),
                  subtitle: Text('turn on/off notification'),
                  trailing: Switch(
                    value: (showNotification) ? true : false,
                    onChanged: (value) {
                      factBloc.toggleShowNotification();
                    },
                  ),
                );
              }),
             
           StreamBuilder<int>(
              initialData: 5,
              stream: factBloc.factsPerDay,
              builder: (context, factsPerDaySnapshot) {
                int factsPerDay = factsPerDaySnapshot.data;
                return ListTile(
                  title: Text('Facts per day $factsPerDay'),
                  subtitle: Slider(
                    value: factsPerDay.toDouble(),
                    min: 0,
                    max: 10,
                    divisions: 5,
                    label: '$factsPerDay',
                    onChanged: (newValue){
                        factBloc.changeFactsPerDay(newValue.toInt());
                  },)
                );
              }),
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