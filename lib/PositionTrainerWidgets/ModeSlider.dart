import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_trainer/PositionTrainerWidgets/SliderThumb.dart';
import 'package:stack_trainer/constants.dart' as CONST;
import 'package:stack_trainer/models/GameRound.dart';

class ModeSlider extends StatelessWidget {
  ModeSlider();

  @override
  Widget build(BuildContext context) {
    return Consumer<GameRound>(builder: (context, round, child) {
      return SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: Colors.red[700],
            inactiveTrackColor: Colors.red[700],
            trackShape: RectangularSliderTrackShape(),
            trackHeight: 5.0,
            thumbColor: Colors.redAccent,
            thumbShape: CustomSliderThumbRect(
                thumbHeight: 50, thumbRadius: 10, min: 0, max: 2),
            overlayColor: Colors.black,
            overlayShape: RoundSliderOverlayShape(overlayRadius: 22.0),
            tickMarkShape: RoundSliderTickMarkShape(tickMarkRadius: 5.0),
            activeTickMarkColor: Colors.white,
            inactiveTickMarkColor: Colors.white,
          ),
          child: Slider(
            min: 0,
            max: 2,
            divisions: 2,
            value: CONST.modeDic[round.mode],
            onChanged: (v) => round.setMode(CONST.modeDicRev[v.round()]),
          ));
    });
  }
}
