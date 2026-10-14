import 'package:flutter/material.dart';

showMessageDialog(BuildContext context, String message, {Function onPressed}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message??""),
            ],
          ),
        ),
        actions: <Widget>[
          SizedBox(
            width: 90,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if(onPressed != null) {
                  onPressed();
                }
              },
              child: Text(
                "OK",
              ),
            ),
          ),
        ],
      );
    },
  );
}
