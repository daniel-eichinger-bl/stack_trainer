import 'package:flutter/material.dart';
import 'package:stack_trainer/constants.dart' as CONST;

class CardGridView extends StatelessWidget {
  final List<dynamic> cards;
  CardGridView(this.cards);

  Widget _buildCardDisplay(card) {
    String value = card[0] != '1' ? card[0] : card.substring(0, 2);
    String suit = CONST.suitDic[card[card.length - 1]]!;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
          border: Border.all(
            width: 2,
            color: Colors.white,
          )),
      margin: EdgeInsets.only(left: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          Image.asset(
            'images/poker_cards/$suit.png',
            width: 13,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.symmetric(horizontal: 16),
      childAspectRatio: 1.5,
      crossAxisCount: 4,
      children: List.generate(52, (index) {
        String card = '';
        if (cards.length > index) {
          card = cards[index];
        }
        index += 1;
        return Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$index',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w100)),
            if (card.length > 0) ...[_buildCardDisplay(card)]
          ],
        ));
      }).toList(),
    );
  }
}
