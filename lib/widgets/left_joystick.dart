import 'package:control_pad/control_pad.dart';
import 'package:flutter/material.dart';

class LeftJoystick extends StatelessWidget {
  final bool _showArrows = true;
  final Color _colorBlack12 = Colors.black12;
  final Duration _birSaniye = Duration(seconds: 1);
  final Function onDirectionChanged;
  LeftJoystick({this.onDirectionChanged});

  @override
  Widget build(BuildContext context) {
    return JoystickView(
      onDirectionChanged: onDirectionChanged,
      innerCircleColor: _colorBlack12,
      showArrows: _showArrows,
      interval: _birSaniye,
    );
  }
}
