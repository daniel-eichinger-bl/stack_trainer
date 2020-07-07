import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final scaffoldKey;

  CustomAppBar({
    Key key,
    @required this.height,
    @required this.scaffoldKey,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 8, right: 8),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(Icons.settings_applications, size: 35, color: Colors.red),
              onPressed: () => scaffoldKey.currentState.openDrawer(),
              color: Colors.grey,
            ),
          ),
          Text('Stack Trainer',
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
