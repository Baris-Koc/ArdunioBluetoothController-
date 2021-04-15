import '../../constants/bluetooth_icon.dart';
import 'package:flutter/material.dart';

class ContainerSelect extends StatelessWidget {
  final String image;
  final String title;
  final Function onTab;
  const ContainerSelect({
    @required this.image,
    @required this.title,
    @required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white70,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        image: DecorationImage(
          image: (AssetImage(image)),
        ),
      ),
      child: ListTile(
        onTap: onTab,
        title: Text(title),
        leading: btIcon2,
      ),
    );
  }
}
