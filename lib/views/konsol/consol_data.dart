
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/material.dart';
 class ConsolData {

  final clientID = 0;
  BluetoothConnection connection;

   List messages=[];
  String messageBuffer = '';

  final TextEditingController textEditingController = TextEditingController();

  final ScrollController listScrollController = ScrollController();

  bool isConnecting = true;

  bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;


 }


/* Yeni satır karakteri varsa mesaj oluştur
   var dataString = String.fromCharCodes(buffer);
   var index = buffer.indexOf(13);
   if (~index != 0) {
  setState(() {
   data.messages.add(
   Message(
   1,
   backspacesCounter > 0
   ? _messageBuffer.substring(
   0, _messageBuffer.length - backspacesCounter)
       : _messageBuffer + dataString.substring(0, index),
   ),
   );
   _messageBuffer = dataString.substring(index);
   });
   } else {
   _messageBuffer = (backspacesCounter > 0
   ? _messageBuffer.substring(
   0, _messageBuffer.length - backspacesCounter)
       : _messageBuffer + dataString);
   }

}

*/