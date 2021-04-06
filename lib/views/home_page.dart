import 'bluetooth_aktifmi.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
  final String _appBartitle = 'Seçenekler';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        appBar: AppBar(
          title: Text(_appBartitle),
        ),
        body: Column(
          //Anasayfa değişicek burası şimdili böyle
          children: [
            Card(
              child: ListTile(
                title: Text('Bluetooth Kontrol'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BtAktiflerstir()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Arduino Proje'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
