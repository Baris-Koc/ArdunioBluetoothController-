import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../controllers/bluetooth_controllers/ba%C4%9Flant%C4%B1.dart';
import '../widgets/bt_settings_float.dart';
import 'konsol/consol.dart';

class CihazSecimSayfasi extends StatelessWidget {
  final String _appBarTitle = 'Bluetooth Cihazı Seçiniz';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: BtSettingsFloatAxtionButton(),
        appBar: AppBar(
          title: Text(_appBarTitle),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.refresh))],
        ),
        body: Container(child:
            //Bağlantıların listelendiği Sınıf
            BagliCihazSayfasiniSecin(
          onCahtPage: (device1) {
            //Cihazla ilgili bilgileri temsil eder
            BluetoothDevice device = device1;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  //Bağlan butununa basınca ChatPage sayfasını bağlı cihaz bilgileri ile gidiyo.
                  return Consol(server: device);
                },
              ),
            );
          },
        )),
      ),
    );
  }
}
