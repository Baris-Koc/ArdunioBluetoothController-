import 'package:control_pad/control_pad.dart';
import 'package:control_pad/models/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';

import '../../controllers/joystick_controller.dart/left_joystick_write_data.dart';
import '../../controllers/joystick_controller.dart/right_joystick_write_data.dart';
import '../../models/consol_data.dart';
import '../../widgets/consol_appBar.dart';
import 'consol_body.dart';

class Consol extends StatefulWidget {
  final BluetoothDevice server;

  const Consol({this.server});

  @override
  _ConsolState createState() => _ConsolState();
}

class _ConsolState extends State<Consol> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    Provider.of<ConsolData>(context, listen: false).listSet =
        Provider.of<ConsolData>(context).messages.map((_message) {
      setState(() {});
      return Row(
        mainAxisAlignment:
            _message.whom == Provider.of<ConsolData>(context).clientID
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(12.0),
            margin: EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
            width: 222.0,
            decoration: BoxDecoration(
                color:
                    _message.whom == Provider.of<ConsolData>(context).clientID
                        ? Colors.blueAccent
                        : Colors.grey,
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
    JoystickDirectionCallback onDirectionChanged(
        double degress, double distance) {
      var data = degress.round();
      WriteDerece.writeData(
          data: data,
          mesajGonder:
              Provider.of<ConsolData>(context, listen: false).mesajGonder);
    }

    // ignore: missing_return
    PadButtonPressedCallback padButtonPressedCallback(
        int buttonIndex, Gestures gesture) {
      print('buttonIndex: $buttonIndex');
      WriteButtonIndex.writeData(
          data: buttonIndex,
          mesajGonder:
              Provider.of<ConsolData>(context, listen: false).mesajGonder);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: consolAppBar(
        isConnecting: Provider.of<ConsolData>(
          context,
        ).isConnecting,
        isConnected: Provider.of<ConsolData>(
          context,
        ).isConnected,
        widgetServerName: widget.server.name,
      ),
      body: ConsolBody(
          onDirectionChanged: onDirectionChanged,
          padButtonPressedCallback: padButtonPressedCallback,
          context: context,
          list: Provider.of<ConsolData>(context).list,
          isConnected: Provider.of<ConsolData>(context).isConnected,
          mesajGonder: Provider.of<ConsolData>(context).mesajGonder,
          listScrollController:
              Provider.of<ConsolData>(context).listScrollController,
          textEditingController:
              Provider.of<ConsolData>(context).textEditingController,
          isConnecting: Provider.of<ConsolData>(context).isConnecting),
    );
  }
}
