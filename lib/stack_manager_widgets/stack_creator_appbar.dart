import 'package:flutter/material.dart';

class StackCreatorAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  StackCreatorAppBar({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 28, left: 16, right: 8),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8),
            child: Icon(Icons.add_to_photos, size: 35, color: Colors.red),
            ),
          Text('Stack Creator',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              )),
          Container(
              padding: EdgeInsets.only(left: 10),
              child: Image.asset(
                'images/icons/card_icon_red.png',
                width: 60,
              )),
        ],
      ),
    );
  }
}
