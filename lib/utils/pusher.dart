import 'package:flutter/material.dart';

class Pusher {
  static final instance = Pusher._internal();
  Pusher._internal();

  static push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return page;
      },
    ));
  }

  static pushReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return page;
      },
    ));
  }

  static pushAndRemoveAll(BuildContext context, Widget page) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) {
          return page;
        },
      ),
      (route) => false,
    );
  }

  static pop(BuildContext context) {
    Navigator.pop(context);
  }
}
