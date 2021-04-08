import 'package:arduinobtcontroller/controllers/joystick_controller.dart/joystick_callback.dart';
import 'package:arduinobtcontroller/widgets/left_joystick.dart';
import 'package:arduinobtcontroller/widgets/mesaj_gonder_button.dart';
import 'package:arduinobtcontroller/widgets/mesaj_textfield.dart';
import 'package:arduinobtcontroller/widgets/right_joystick.dart';
import 'package:arduinobtcontroller/widgets/textField_gonder_button.dart';
import 'package:control_pad/control_pad.dart';

import 'package:flutter/material.dart';

Row ConsolBody(
    {@required var onDirectionChanged,
    @required var padButtonPressedCallback,
    @required BuildContext context,
    @required List<Row> list,
    @required bool isConnected,
    @required Function mesajGonder,
    @required ScrollController listScrollController,
    @required TextEditingController textEditingController,
    @required bool isConnecting}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Expanded(
        child: LeftJoystick(onDirectionChanged: onDirectionChanged),
      ),
      Expanded(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              height: MediaQuery.of(context).size.width * 0.1,
              width: double.infinity,
              child: FittedBox(
                child: Row(
                  children: [
                    MesajDonderenIcon(
                      isConnected: isConnected,
                      mesajGonder: mesajGonder,
                      mesaj: '1',
                    ),
                    MesajDonderenIcon(
                        mesajGonder: mesajGonder,
                        mesaj: '0',
                        isConnected: isConnected)
                  ],
                ),
              ),
            ),
            Flexible(
              child: ListView(
                  padding: const EdgeInsets.all(12.0),
                  controller: listScrollController,
                  children: list),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  child: MesajGonderTextField(
                      textEditingController: textEditingController,
                      isConnecting: isConnecting,
                      isConnected: isConnected),
                ),
                MesajGonderIcon(
                  isConnected: isConnected,
                  textEditingController: textEditingController,
                  mesajGonder: mesajGonder,
                ),
              ],
            )
          ],
        ),
      ),
      Expanded(
        child: ButtonJoystick(
          padButtonPressedCallback: padButtonPressedCallback,
        ),
      ),
    ],
  );
}
