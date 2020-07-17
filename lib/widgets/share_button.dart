import 'package:dailyfactsng/constants/constants.dart';
import 'package:dailyfactsng/models/fact.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShareButton extends StatelessWidget {
  final Fact fact;
  ShareButton({this.fact});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
          child: IconButton(
          icon: Icon(FontAwesomeIcons.shareSquare),
          color: kSecondaryColor,
          onPressed: () {
             print(fact);
          }),
    );
  }
}
