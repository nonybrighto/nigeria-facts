import 'package:dailyfactsng/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

// class CustomAppBar extends StatelessWidget {

//   final Widget title;
//   final List<Widget> actions;

//   CustomAppBar({this.title, this.actions});
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

buildCustomAppBar({Widget title, List<Widget> actions}){
    double appBarHeight = AppBar().preferredSize.height;
    return  PreferredSize(
            preferredSize:Size.fromHeight(appBarHeight),
            child: GradientAppBar(
        title: title,
        actions: actions,
        gradient: LinearGradient(colors: [kGradientFirstColor, kGradientSecondColor])
      )
          );
}