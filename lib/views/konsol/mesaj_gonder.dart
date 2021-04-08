
import 'dart:convert';

import 'package:arduinobtcontroller/models/message.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'consol.dart';

 class MesajGonder {

     void mesajGonder(String text, ) async {
      text = text.trim();
      data.textEditingController.clear();

      if (text.isNotEmpty) {
        try {
          data.connection.output.add(utf8.encode(text + '\r\n'));
          await data.connection.output.allSent;

            data.messages.add(Message(data.clientID, text));


          await Future.delayed(Duration(milliseconds: 333)).then((_) {
            data.listScrollController.animateTo(
                data.listScrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 333),
                curve: Curves.easeOut);
          });
        } catch (e) {
          // Ignore error, but notify state

        }
      }
    }
  }


