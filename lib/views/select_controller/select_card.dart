import 'package:flutter/material.dart';

class SelectCard extends StatelessWidget {
  final String title;
  final String image;
  final Function onTab;
  const SelectCard({
    @required this.image,
    @required this.title,
    @required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: ListTile(
        onTap: onTab,
        leading: Image(
          image: AssetImage(image),
        ),
        title: Text(title),
      ),
    );
  }
}
