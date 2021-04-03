import 'package:flutter/material.dart';

class MesajDonderenIcon extends StatelessWidget {
  final Function mesajGonder;
  final String mesaj;
  final bool isConnected;
  MesajDonderenIcon({
    @required this.mesajGonder,
    @required this.mesaj,
    @required this.isConnected,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isConnected ? () => mesajGonder(mesaj) : null,
      child: Text(mesaj),
    );
  }
}
