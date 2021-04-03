import 'package:flutter/material.dart';

class MesajGonderIcon extends StatelessWidget {
  final Function mesajGonder;
  MesajGonderIcon({
    @required this.mesajGonder,
    @required this.isConnected,
    @required this.textEditingController,
  });

  final bool isConnected;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: IconButton(
          icon: const Icon(Icons.send),
          onPressed: isConnected
              ? () => mesajGonder(textEditingController.text)
              : null),
    );
  }
}
