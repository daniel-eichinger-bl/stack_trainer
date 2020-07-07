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
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      leading: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: IconButton(
          icon: Icon(
            Icons.settings,
            size: 26,
          ),
          onPressed: () => scaffoldKey.currentState.openDrawer(),
          color: Colors.grey,
        ),
      ),
      titleSpacing: 0.0,
      title: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('Stack Trainer',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
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
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
