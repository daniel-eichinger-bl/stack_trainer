import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_trainer/models/GameRound.dart';
import 'package:stack_trainer/stack_trainer_widgets/mode_slider.dart';
import 'package:stack_trainer/stack_creator.dart';

import 'stack_dropdown_button.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final round = Provider.of<GameRound>(context);
    final activeStack = round.stackName;

    return Drawer(
      child: Container(
        color: const Color.fromRGBO(48, 48, 48, 1.0),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.surface),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      child: const Icon(
                        Icons.settings_applications,
                        color: Colors.red,
                        size: 50,
                      )),
                  const Text('Settings',
                      style: TextStyle(color: Colors.white, fontSize: 26)),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 8, left: 8),
                child: const Text(
                  '[Questions]',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: ModeSlider(),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8, left: 8),
              child: const Text(
                '[Stack]',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: StackDropdownButton(),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(left: 18),
              child: TextButton.icon(
                onPressed: () =>
                    Navigator.pushNamed(context, StackCreator.routeName),
                icon: const Icon(
                  Icons.add,
                  color: Colors.red,
                ),
                label: const Text(
                  "Add Stack",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            if (!['Aronson', 'Mnemonica', 'Memorandum']
                .contains(activeStack)) ...[
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 18),
                child: TextButton.icon(
                  onPressed: () => round.removeCurrentStack(),
                  icon: const Icon(
                    Icons.remove,
                    color: Colors.red,
                  ),
                  label: RichText(
                    text: TextSpan(
                        style: const TextStyle(color: Colors.white),
                        children: [
                          const TextSpan(
                            text: "Remove",
                          ),
                          TextSpan(
                              text: " $activeStack ",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                          const TextSpan(
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
