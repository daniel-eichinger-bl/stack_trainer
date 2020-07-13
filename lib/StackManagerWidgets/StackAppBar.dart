import 'package:flutter/material.dart';

class StackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  StackAppBar({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 28, left: 8, right: 8),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(Icons.add_to_photos, size: 35, color: Colors.red),
              onPressed: () => null,
              color: Colors.grey,
            ),
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
