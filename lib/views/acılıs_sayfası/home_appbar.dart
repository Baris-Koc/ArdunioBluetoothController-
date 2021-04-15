import 'package:flutter/material.dart';

AppBar homeAppBar(BuildContext context, String title) {
  return AppBar(
    title: Text(
      title,
      style:
          Theme.of(context).textTheme.headline6.copyWith(color: Colors.white),
    ),
  );
}
