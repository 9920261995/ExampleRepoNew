import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final Function presentDatePicker;

  AdaptiveFlatButton(this.presentDatePicker);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: presentDatePicker,
            child: Text(
              "Choose date",
              style: TextStyle(fontWeight: FontWeight.bold),
            ))
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            onPressed: presentDatePicker,
            child: Text(
              "Choose date",
              style: TextStyle(fontWeight: FontWeight.bold),
            ));
  }
}
