import 'package:flutter/material.dart';

import '../../widgets/left_joystick.dart';
import '../../widgets/mesaj_gonder_button.dart';
import '../../widgets/mesaj_textfield.dart';
import '../../widgets/right_joystick.dart';
import '../../widgets/textField_gonder_button.dart';

Row ConsolBody(
    {@required var onDirectionChanged,
    @required var padButtonPressedCallback,
    @required BuildContext context,
    @required bool isConnected,
    @required List list,
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
