import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/consol_data.dart';
import 'views/acılıs_sayfası/home_page.dart';

void main() {
  runApp(ChangeNotifierProvider<ConsolData>(
    create: (context) => ConsolData(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arduino Bluetooth Controller',
      home: HomePage(),
    );
  }
}
