import 'package:dailyfactsng/constants/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About $kAppName'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: 500,
                minHeight: MediaQuery.of(context).size.height - 100),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.png',
                    height: 95,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'DailyFactsNG gives you amazing facts about nigeria',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Writers', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 2,
                  ),
                  Text('Modestus Happiness Chiamaka', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
                  Text('Nony Bright', style: TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(color: Colors.grey),
                        text: 'Click ',
                        children: [
                          TextSpan(
                              text: 'here',
                              style: TextStyle(color: kSecondaryColor),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launch('mailto:$kContactEmail?subject=Hello&body=$kAppName - $kAppVersion \n Hi.');
                                }),
                          TextSpan(
                            text: ' to contact us',
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(color: Colors.grey),
                        text: 'Modelled after ',
                        children: [
                          TextSpan(
                              text: 'Ultimate Facts',
                              style: TextStyle(color: kSecondaryColor ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launch('http://play.google.com/store/apps/details?id=com.viyatek.ultimatefacts');
                                }),
                        ]),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        style: TextStyle(color: Colors.grey),
                        text: 'Developed by ',
                        children: [
                          TextSpan(
                              text: 'nonybrighto',
                              style: TextStyle(color: kSecondaryColor ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  launch('http://www.nonybrighto.com');
                                }),
                        ]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '© 2020',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
