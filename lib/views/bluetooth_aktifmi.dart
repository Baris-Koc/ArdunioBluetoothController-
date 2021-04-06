import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../constants/bluetooth_icon.dart';
import 'cihaz_secim_sayfasi.dart';

class BtAktiflerstir extends StatelessWidget {
  final double size200 = 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Gelecek bekleyen bir buildir kurmuş
      body: FutureBuilder(
        // future kısmına bt aktif mi diye kontro eder açık değiş ise izin ister .
        future: FlutterBluetoothSerial.instance.requestEnable(),
        builder: (context, future) {
          // izin ekranda ise ve bir cevap verilmedi ise arkada bt simgesi gözükür
          // eğer(gelecek.yüklemedurumu)== YüklemeDurumu.bekleme
          if (future.connectionState == ConnectionState.waiting) {
            //Cevap Verilmedi ise arkada bt simgesi döndüren fonk
            return Scaffold(
              body: Container(
                height: double.infinity,
                child: Center(child: btIcon),
              ),
            );
            //
            //Bt izini bitti ise cevap hayır da olsa evet te olsa Home sınıfı döner
          } else if (future.connectionState == ConnectionState.done) {
            // return MyHomePage(title: 'Flutter Demo Home Page');MyHomePage'e dön (başlık: 'Flutter Demo Ana Sayfası'
            return CihazSecimSayfasi();
          } else {
            return CihazSecimSayfasi();
          }
        },
        //
      ),
    );
  }
}
