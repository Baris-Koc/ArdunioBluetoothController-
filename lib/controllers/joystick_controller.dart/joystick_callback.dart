import 'package:control_pad/control_pad.dart';
import 'package:control_pad/models/gestures.dart';

class JoystickPadCallBack {
  PadButtonPressedCallback _padButtonPressedCallback = (
    int index,
    Gestures gesture,
  ) {
    print('buttonIndex: $index');
  };

  Function get padButtonPressedCallback => _padButtonPressedCallback;
}
