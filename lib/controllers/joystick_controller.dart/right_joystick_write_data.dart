import 'package:flutter/material.dart';

class WriteButtonIndex {
  WriteButtonIndex.writeData(
      {@required int data, @required Function mesajGonder}) {
    if (data == 0) {
      mesajGonder('O');
    } else if (data == 1) {
      mesajGonder('X');
    } else if (data == 2) {
      mesajGonder('M');
    } else if (data == 3) {
      mesajGonder('V');
    }
  }
}
