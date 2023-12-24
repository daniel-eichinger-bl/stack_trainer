import 'package:flutter/material.dart';

import 'package:stack_trainer/constants.dart' as CONST;

class CardButtons extends StatelessWidget {
  const CardButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: const Color.fromRGBO(48, 48, 48, 1.0),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: GridView.count(
            crossAxisCount: 5,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
            children: List.generate(CONST.newDeck.length, (i) {
              final card = CONST.newDeck[i];

              String suit = '';
              String value = '';
              if (card.isNotEmpty) {
                value = card[0] != '1' ? card[0] : card.substring(0, 2);
                suit = CONST.suitDic[card[card.length - 1]]!;
              }

              return TextButton(
                  onPressed: card.isNotEmpty ? () {} : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        value,
                        style: const TextStyle(color: Colors.white),
                      ),
                      if (card.isNotEmpty) ...[
                        Image.asset(
                          'images/poker_cards/$suit.png',
                          width: 12,
                        )
                      ]
                    ],
                  ));
            }).toList()),
      ),
    );
  }
}
