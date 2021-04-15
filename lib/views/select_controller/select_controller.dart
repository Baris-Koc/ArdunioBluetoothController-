import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';

import '../../models/consol_data.dart';
import '../konsol/consol.dart';
import 'select_card.dart';

class SelectController extends StatefulWidget {
  final BluetoothDevice server;
  SelectController({this.server});

  @override
  _SelectControllerState createState() => _SelectControllerState();
}

class _SelectControllerState extends State<SelectController> {
  final String appBarTitle = 'Select Controller';

  final String controllerImage = 'assets/sellect/controller.png';

  final String joystickImage = 'assets/sellect/joystick.webp';

  final String terminalImage = 'assets/sellect/terminal.webp';

  final String buttonImage = 'assets/sellect/button.webp';

  final String sliderImage = 'assets/sellect/slider.webp';

  final String controllerTitle = 'Controller';

  final String joystickTitle = 'Joystick';

  final String terminalTitle = 'Terminal';

  final String buttonTitle = 'Button';

  final String sliderTitle = 'Slider';
  BluetoothConnection _connection;
  bool _isConnecting;
  @override
  void initState() {
    super.initState();
    BluetoothConnection.toAddress(widget.server.address).then((connection) {
      print('Connected to the device');
      _connection = connection;
      Provider.of<ConsolData>(context, listen: false).connectionSet =
          _connection;
      setState(() {
        _isConnecting = false;
        Provider.of<ConsolData>(context, listen: false).isConnectingSet =
            _isConnecting;
        Provider.of<ConsolData>(context, listen: false).isDisconnectingSet =
            false;
      });

      Provider.of<ConsolData>(context)
          .connection
          .input
          .listen(Provider.of<ConsolData>(context).onDataReceived)
          .onDone(() {
        // Örnek: Bağlantıyı hangi tarafın kapattığını tespit edin
        // (yerel olarak) olduğumuzu göstermek için "isDisconnecting" bayrağı olmalı
        // ibağlantı kesme işleminin ortasında, çağırmadan önce ayarlanmalıdır
        // ` "dispose", "finish" veya "close", bunların tümü bağlantının kesilmesine neden olur.
        // Bağlantı kesilmesini hariç tutarsak, sonuç olarak "onDone" tetiklenmelidir.
        //  Bunun dışında kalmadıysak (bayrak ayarlanmadıysa), uzaktan kapama demektir.
        if (Provider.of<ConsolData>(context).isDisconnecting) {
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
    //  Provider.of<ConsolData>(context, listen: false).isConnectingSet = true;
    _connection.dispose();
    _connection = null;
    print(
        '------asdsadsadsa${widget.server.isConnected}'); //  Provider.of<ConsolData>(context, listen: false).connectionSet = null;

    print('çalıştı');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Column(children: [
        Expanded(
          child: SelectCard(
            image: controllerImage,
            title: controllerTitle,
            onTab: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Consol(server: widget.server),
                  ));
            },
          ),
        ),
        Expanded(
            child: SelectCard(
          image: joystickImage,
          title: joystickTitle,
        )),
        Expanded(
          child: SelectCard(
            image: terminalImage,
            title: terminalTitle,
          ),
        ),
        Expanded(
            child: SelectCard(
          image: buttonImage,
          title: buttonTitle,
        )),
        Expanded(
            child: SelectCard(
          image: sliderImage,
          title: sliderTitle,
        )),
      ]),
    );
  }
}
