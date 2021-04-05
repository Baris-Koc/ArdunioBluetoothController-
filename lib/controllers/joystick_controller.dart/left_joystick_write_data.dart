import 'package:flutter/material.dart';

class WriteDerece {
  WriteDerece.writeData({@required int data, @required Function mesajGonder}) {
    var derece = data;
    var sDerece = derece / 10;
    if (sDerece > 0) {
      if (sDerece <= 9) {
        dataZamanlaYolla('N').listen((event) {
          mesajGonder(event.toString());
          print('stream çalıştı');
        });
      } else if (sDerece > 9) {
        if (sDerece <= 18) {
          dataZamanlaYolla('E').listen((event) {
            mesajGonder(event.toString());
            print('stream çalıştı');
          });
        }
      }
    }
    if (sDerece > 18) {
      if (sDerece <= 27) {
        dataZamanlaYolla('S').listen((event) {
          mesajGonder(event.toString());
          print('stream çalıştı');
        });
      }
    }
    if (sDerece > 27) {
      if (sDerece <= 36) {
        dataZamanlaYolla('W').listen((event) {
          mesajGonder(event.toString());
        });
      }
    }

    print('Classin icinde $derece');
  }
}

Stream<String> dataZamanlaYolla(var ileti) async* {
  for (var i = 0; i < 1; i++) {
    await Future.delayed(Duration(milliseconds: 300));
    var gi = await Future.value(ileti);
    yield gi;
  }
}

/*   
  static writeData(int data, Function mesajGonder) async {
    await data;
    var derece = data;

    if (data > 0) {
      mesajGonder(derece.toString());
    }
    print(derece);
  } */
/* else if (derece > 180) {
        if (derece <= 270) {
          dataZamanlaYolla(7).listen((event) {
            mesajGonder(event.toString());
            print("stream çalıştı");
          });
        }
      } else if (derece > 270) {
        if (derece <= 360) {
          dataZamanlaYolla(6).listen((event) {
            mesajGonder(event.toString());
            print("stream çalıştı");
          });
        }
      } */
