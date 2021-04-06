import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../constants/baglan_text.dart';
//Bluethot cihazlarının sıralanırken nasıl bir görüntüde olduğunu gösteren widget

class BluetoothCihazListesiGirisi extends StatelessWidget {
  //bir fonksiyon ve Bluetooth cihazını alıyo
  final Function onTap;
  final BluetoothDevice cihaz;
//BluetoothDevice =Cihazla ilgili bilgileri temsil eder,
  BluetoothCihazListesiGirisi({this.onTap, @required this.cihaz});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Icon(Icons.devices), //sol Icon
        title: Text(cihaz.name ?? 'Bilinmeyen Cihaz'), //başlk cihazın ismi
        subtitle: Text(cihaz.address.toString()),
        trailing: TextButton(
          onPressed: onTap,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue)),
          child: kBaglanText,
        ),
      ),
    );
  }
}
