import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainErrorDisplay extends StatelessWidget {

  final String errorMessage;
  final String buttonText;
  final Function onErrorButtonTap;
 
  MainErrorDisplay({this.errorMessage, this.buttonText, this.onErrorButtonTap});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(FontAwesomeIcons.exclamationTriangle,size: 65, color: Theme.of(context).accentColor,),
            SizedBox(
              height: 5,
            ),
            Text(this.errorMessage ?? 'Error occured', style: TextStyle(fontSize: 15,),),
            if(onErrorButtonTap != null)FlatButton(
                child: Text(buttonText ?? 'RETRY', style: TextStyle(fontSize: 18),),
                onPressed: onErrorButtonTap,
            ),
          ],
        ),
    );
  }
}