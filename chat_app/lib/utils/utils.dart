import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

push(context, screen) {
  Navigator.push(
    context,
    CupertinoPageRoute(builder: (context) => screen),
  );
}

pushUntil(context, screen) {
  Navigator.pushAndRemoveUntil(
      context, CupertinoPageRoute(builder: (_) => screen), (route) => false);
}
