import 'package:flutter/material.dart';
import 'package:stack_trainer/PositionTrainerWidgets/ModeSlider.dart';
import 'package:stack_trainer/stack_creator.dart';

import 'StackDropdownButton.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(48, 48, 48, 1.0),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 8, right: 8),
                      child: Icon(
                        Icons.settings_applications,
                        color: Colors.red,
                        size: 50,
                      )),
                  Text('Settings',
                      style: TextStyle(color: Colors.white, fontSize: 26)),
                ],
              ),
              decoration:
                  BoxDecoration(color: Theme.of(context).backgroundColor),
            ),
            Container(
                margin: EdgeInsets.only(top: 8, left: 8),
                child: Text(
                  '[Questions]',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ModeSlider(),
            ),
            Container(
              margin: EdgeInsets.only(top: 8, left: 8),
              child: Text(
                '[Stack]',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: StackDropdownButton(),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 18),
              child: FlatButton.icon(
                onPressed: () =>
                    Navigator.pushNamed(context, StackCreator.routeName),
                icon: Icon(
                  Icons.add,
                  color: Colors.red,
                ),
                label: Text(
                  "Add Stack",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
