import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_trainer/models/GameRound.dart';
import 'package:stack_trainer/stack_trainer_widgets/mode_slider.dart';
import 'package:stack_trainer/stack_creator.dart';

import 'stack_dropdown_button.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer();

  @override
  Widget build(BuildContext context) {
    final round = Provider.of<GameRound>(context);
    final activeStack = round.stackName;

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
              child: TextButton.icon(
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
            ),
            if (!['Aronson', 'Mnemonica', 'Memorandum']
                .contains(activeStack)) ...[
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 18),
                child: TextButton.icon(
                  onPressed: () => round.removeCurrentStack(),
                  icon: Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                  label: RichText(
                    text: TextSpan(
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: "Remove",
                          ),
                          TextSpan(
                              text: " $activeStack ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                          TextSpan(
                            text: "Stack",
                          )
                        ]),
                  ),
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
