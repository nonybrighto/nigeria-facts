import 'package:dailyfactsng/bloc/bloc_provider.dart';
import 'package:dailyfactsng/bloc/fact_bloc.dart';
import 'package:dailyfactsng/constants/constants.dart';
import 'package:dailyfactsng/models/fact.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShareButton extends StatefulWidget {
  final Fact fact;
   final FactBloc factBloc;
  ShareButton({this.fact, this.factBloc});

  @override
  _ShareButtonState createState() => _ShareButtonState();
}

class _ShareButtonState extends State<ShareButton> {
  // bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
          icon: Icon(FontAwesomeIcons.shareSquare),
          color: kSecondaryColor,
          onPressed: () async{
            // setState(() {
            //   loading = true;
            // });
            FactBloc bloc = widget.factBloc != null ? widget.factBloc : BlocProvider.of<FactBloc>(context);
            await bloc.shareFact(
                fact: widget.fact,
                shareCallback: (shared) {
                 if(!shared){
                    Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('Failed to share fact'),
                  ));
                 }
                });
          }),
    );
  }
}
