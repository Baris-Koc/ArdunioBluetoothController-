import 'package:flutter/material.dart';

class MesajGonderTextField extends StatelessWidget {
  const MesajGonderTextField({
    Key key,
    @required this.textEditingController,
    @required this.isConnecting,
    @required this.isConnected,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final bool isConnecting;
  final bool isConnected;
  final String _s1 = 'Bağlanan Kadar Bekleyiniz...';
  final String _s2 = 'Mesajınızı Yazınız...';
  final String _s3 = 'Bağlantı Kesildi';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0),
      child: TextField(
        style: const TextStyle(fontSize: 15.0),
        controller: textEditingController,
        decoration: InputDecoration.collapsed(
          hintText: isConnecting
              ? _s1
              : isConnected
                  ? _s2
                  : _s3,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        enabled: isConnected,
      ),
    );
  }
}
