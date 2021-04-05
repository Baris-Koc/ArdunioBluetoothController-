import 'package:control_pad/control_pad.dart';
import 'package:flutter/cupertino.dart';
import 'package:control_pad/models/gestures.dart';

class JoystickPadCallBack {
  final Function mesajGonder;

  JoystickPadCallBack({@required this.mesajGonder});
  PadButtonPressedCallback _padButtonPressedCallback = (
    int index,
    Gestures gesture,
  ) {
    print('buttonIndex: $index');
    // WriteButtonIndex.writeData(data: index, mesajGonder:mesajGonder);
  };

  Function get padButtonPressedCallback => _padButtonPressedCallback;
}
