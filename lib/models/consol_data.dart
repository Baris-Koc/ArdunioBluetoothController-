import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'message.dart';

class ConsolData with ChangeNotifier {
  int _clientID = 0;
  BluetoothConnection _connection;

  List<Message> _messages = [];

  String _messageBuffer = '';

  bool ofpage = false;

  List<Row> _list;

  BluetoothDevice device;
  TextEditingController _textEditingController = TextEditingController();

  ScrollController _listScrollController = ScrollController();

  bool _isConnecting = true;

  bool get isConnected => _connection != null && _connection.isConnected;

  bool _isDisconnecting = false;

  int get clientID => _clientID;

  BluetoothConnection get connection => _connection;

  List get messages => _messages;

  String get messageBuffer => _messageBuffer;

  TextEditingController get textEditingController => _textEditingController;

  ScrollController get listScrollController => _listScrollController;

  bool get isConnecting => _isConnecting;

  bool get isDisconnecting => _isDisconnecting;

  List get list => _list;
  set isDisconnectingSet(bool value) {
    _isDisconnecting = value;
    notifyListeners();
  }

  set isConnectingSet(bool value) {
    _isConnecting = value;
    notifyListeners();
  }

  set listScrollControllerSet(ScrollController value) {
    _listScrollController = value;
    notifyListeners();
  }

  set textEditingControllerSet(TextEditingController value) {
    _textEditingController = value;
    notifyListeners();
  }

  set messageBufferSet(String value) {
    _messageBuffer = value;
    notifyListeners();
  }

  set messagesSet(List value) {
    _messages = value;
    notifyListeners();
  }

  set connectionSet(BluetoothConnection value) {
    _connection = value;
    notifyListeners();
  }

  set isConected(BluetoothConnection value) {
    _connection = value;
    notifyListeners();
  }

  set clientIDSet(int value) {
    _clientID = value;
    notifyListeners();
  }

  set deviceSet(bool value) {
    _isConnecting = value;
    notifyListeners();
  }

  set listSet(List value) {
    _list = value;
  }

  void mesajGonder(
    String text,
  ) async {
    text = text.trim();
    _textEditingController.clear();

    if (text.isNotEmpty) {
      try {
        _connection.output.add(utf8.encode(text + '\r\n'));
        await _connection.output.allSent;

        _messages.add(Message(_clientID, text));
        notifyListeners();
        await Future.delayed(Duration(milliseconds: 333)).then((_) {
          _listScrollController.animateTo(
              _listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        notifyListeners();
      }
    }
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    var backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    var buffer = Uint8List(data.length - backspacesCounter);
    var bufferIndex = buffer.length;
    notifyListeners();
    // Apply backspace control character
    backspacesCounter = 0;
    for (var i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }
    notifyListeners();
    var dataString = String.fromCharCodes(buffer);
    var index = buffer.indexOf(13);
    if (~index != 0) {
      _messages.add(
        Message(
          1,
          backspacesCounter > 0
              ? _messageBuffer.substring(
                  0, _messageBuffer.length - backspacesCounter)
              : _messageBuffer + dataString.substring(0, index),
        ),
      );
      _messageBuffer = dataString.substring(index);
    } else {
      _messageBuffer = (backspacesCounter > 0
          ? _messageBuffer.substring(
              0, _messageBuffer.length - backspacesCounter)
          : _messageBuffer + dataString);
    }
    notifyListeners();
  }

  Function get onDataReceived => _onDataReceived;
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
