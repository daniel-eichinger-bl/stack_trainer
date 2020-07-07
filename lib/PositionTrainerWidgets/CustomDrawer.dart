import 'package:flutter/material.dart';
import 'package:stack_trainer/PositionTrainerWidgets/ModeSlider.dart';

class CustomDrawer extends StatelessWidget {
  var _sliderCallback;
  var _mode;
  CustomDrawer(this._mode, this._sliderCallback);

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
              child: Text('[Questions]', style: TextStyle(color: Colors.white, fontSize: 16),)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ModeSlider(_mode, _sliderCallback),
            )
          ],
        ),
      ),
    );
  }
}
