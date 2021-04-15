import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../constants/bluetooth_icon.dart';

class BtSettingsFloatAxtionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        FlutterBluetoothSerial.instance.openSettings();
      },
      child: btIcon2,
    );
  }
}
