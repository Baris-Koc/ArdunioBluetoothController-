import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:arduinobtcontroller/controllers/joystick_controller.dart/left_joystick_write_data.dart';
import 'package:arduinobtcontroller/controllers/joystick_controller.dart/right_joystick_write_data.dart';
import 'package:arduinobtcontroller/models/message.dart';
import 'package:arduinobtcontroller/views/konsol/consol_appBar.dart';

import 'package:control_pad/control_pad.dart';
import 'package:control_pad/models/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';


import 'consol_body.dart';

class Consol extends StatefulWidget {
  final BluetoothDevice server;

  const Consol({this.server});


  @override
  _ConsolState createState() => _ConsolState();
}

class _ConsolState extends State<Consol> {
  static final clientID = 0;
  BluetoothConnection connection;

  List<Message> messages = [];
  String _messageBuffer = '';

  final TextEditingController textEditingController = TextEditingController();

  final ScrollController listScrollController = ScrollController();

  bool isConnecting = true;

  bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      connection.input.listen(_onDataReceived).onDone(() {
        // Örnek: Bağlantıyı hangi tarafın kapattığını tespit edin
        // (yerel olarak) olduğumuzu göstermek için "isDisconnecting" bayrağı olmalı
        // ibağlantı kesme işleminin ortasında, çağırmadan önce ayarlanmalıdır
        // ` "dispose", "finish" veya "close", bunların tümü bağlantının kesilmesine neden olur.
        // Bağlantı kesilmesini hariç tutarsak, sonuç olarak "onDone" tetiklenmelidir.
        //  Bunun dışında kalmadıysak (bayrak ayarlanmadıysa), uzaktan kapama demektir.
        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    final list = messages.map((_message) {
      return Row(
        mainAxisAlignment: _message.whom == clientID
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            width: 222.0,
            decoration: BoxDecoration(
                color:
                _message.whom == clientID ? Colors.blueAccent : Colors.grey,
                borderRadius: BorderRadius.circular(7.0)),
            child: Text(
                    (text) {
                  return text == '/shrug' ? '¯\\_(ツ)_/¯' : text;
                }(_message.text.trim()),
                style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    }).toList();
    // ignore: missing_return
    JoystickDirectionCallback onDirectionChanged(double degress,
        double distance) {
      var data = degress.round();
      WriteDerece.writeData(data: data, mesajGonder: _mesajGonder);
    }

    // ignore: missing_return
    PadButtonPressedCallback padButtonPressedCallback(int buttonIndex,
        Gestures gesture) {
      print('buttonIndex: $buttonIndex');
      WriteButtonIndex.writeData(data: buttonIndex, mesajGonder: _mesajGonder);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: consolAppBar(isConnecting: isConnecting, isConnected: isConnected, widgetServerName: widget.server.name),

      body: ConsolBody(onDirectionChanged: onDirectionChanged,
          context: context,
          list: list,
          isConnected: isConnected,
          mesajGonder: _mesajGonder,
          listScrollController: listScrollController,
          textEditingController: textEditingController,
          isConnecting: isConnecting),
    );
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

    // Create message if there is new line character
    var dataString = String.fromCharCodes(buffer);
    var index = buffer.indexOf(13);
    if (~index != 0) {
      setState(() {
        messages.add(
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

  void _mesajGonder(String text) async {
    text = text.trim();
    textEditingController.clear();

    if (text.isNotEmpty) {
      try {
        connection.output.add(utf8.encode(text + '\r\n'));
        await connection.output.allSent;

        setState(() {
          messages.add(Message(clientID, text));
        });

        await Future.delayed(Duration(milliseconds: 333)).then((_) {
          listScrollController.animateTo(
              listScrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 333),
              curve: Curves.easeOut);
        });
      } catch (e) {
        // Ignore error, but notify state
        setState(() {});
      }
    }
  }
}
