import 'package:flutter/material.dart';

import '../ac%C4%B1l%C4%B1s_sayfas%C4%B1/container_image.dart';
import '../ac%C4%B1l%C4%B1s_sayfas%C4%B1/home_appbar.dart';
import '../bluetooth_aktifmi.dart';

class HomePage extends StatelessWidget {
  final String appBarTitle = 'Arduino Controller';
  final String image1 = 'assets/home/joystick.png';
  final String title1 = 'Bluetooth Controller';
  final String image2 = 'assets/home/arduino.png';
  final String title2 = 'Arduino';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context, appBarTitle),
      body: Column(
        children: [
          Expanded(
            child: ContainerSelect(
              image: image1,
              title: title1,
              onTab: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BtAktiflerstir()));
              },
            ),
          ),
          Expanded(
              child: ContainerSelect(
            image: image2,
            title: title2,
            onTab: () {},
          )),
        ],
      ),
    );
  }
}

/* class HomePage extends StatelessWidget {
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
 */
