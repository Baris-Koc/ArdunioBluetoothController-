import 'package:flutter/material.dart';

AppBar consolAppBar(
    {@required bool isConnecting,
    @required bool isConnected,
    @required String widgetServerName}) {
  const baglaniyor='Cihaza Bağlanıyor ';
  const String baglandi= ' Bağlandı';
  const baglantiKesildi=' Bağlanti Kesildi!';
  return AppBar(
    title: (isConnecting
        ? Text(baglaniyor + widgetServerName + '...')
        : isConnected
            ? Text( widgetServerName + baglandi )
            : Text( widgetServerName + baglantiKesildi)),
  );
}
