//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget createMessageError(String message, {isCenter = true}) {
  return Container(
    padding: EdgeInsets.all(10.0),
    child: isCenter
        ? Center(
            child: Text(message,
                style: TextStyle(fontSize: 14, color: Colors.grey)),
          )
        : Text(message, style: TextStyle(fontSize: 14, color: Colors.grey)),
  );
}
