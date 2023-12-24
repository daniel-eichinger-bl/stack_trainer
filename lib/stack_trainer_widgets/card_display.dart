import 'package:flutter/material.dart';

class CardDisplay extends StatelessWidget {
  final String card;

  const CardDisplay(this.card, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.blueGrey,
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(3.0, 2.0))
        ]),
        margin: const EdgeInsets.only(top: 32, bottom: 32),
        alignment: Alignment.center,
        child: FadeInImage(
            fadeInDuration: const Duration(milliseconds: 200),
            fadeOutDuration: const Duration(milliseconds: 200),
            placeholder: const AssetImage('images/poker_cards/blank.png'),
            image: AssetImage('images/poker_cards/$card.png')));
  }
}
