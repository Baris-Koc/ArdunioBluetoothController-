import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BtSettingsFloatAxtionButton extends StatelessWidget {
  final Icon icon = Icon(Icons.add);
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        FlutterBluetoothSerial.instance.openSettings();
      },
      child: icon,
    );
  }
}
