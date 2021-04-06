import 'package:control_pad/models/pad_button_item.dart';
import 'package:control_pad/views/pad_button_view.dart';
import 'package:flutter/material.dart';

import '../constants/right_joystick_icon.dart';

class ButtonJoystick extends StatelessWidget {
  final Function padButtonPressedCallback;
  final Color _blueGrey = Colors.blueGrey;
  ButtonJoystick({this.padButtonPressedCallback});

  @override
  Widget build(BuildContext context) {
    return PadButtonsView(
      padButtonPressedCallback: padButtonPressedCallback,
      backgroundPadButtonsColor: _blueGrey,
      buttons: [
        PadButtonItem(
          index: 0,
          buttonIcon: kArrowForwardIcon,
          backgroundColor: _blueGrey,
        ),
        PadButtonItem(
          index: 1,
          buttonIcon: kArrowDownwardIcon,
          backgroundColor: _blueGrey,
        ),
        PadButtonItem(
          index: 2,
          buttonIcon: kArrowBackIcon,
          backgroundColor: _blueGrey,
        ),
        PadButtonItem(
          index: 3,
          buttonIcon: kArrowUpwardIcon,
          backgroundColor: _blueGrey,
        )
      ],
    );
  }
}
