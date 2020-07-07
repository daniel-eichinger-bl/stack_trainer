import 'package:flutter/material.dart';
import 'package:stack_trainer/PositionTrainerWidgets/SliderThumb.dart';
import 'package:stack_trainer/constants.dart' as CONST;

class ModeSlider extends StatefulWidget {
  final _sliderCallback;

  ModeSlider(this._sliderCallback);

  @override
  _ModeSliderState createState() => _ModeSliderState();
}

class _ModeSliderState extends State<ModeSlider> {
  var _sliderValue = 1.0;

  void setMode(value) {
    setState(() {
      _sliderValue = value;
    });

    var mode = CONST.TrainModes.mix;
    switch (value.round()) {
      case 0:
        mode = CONST.TrainModes.cards;
        break;
      case 1:
        mode = CONST.TrainModes.mix;
        break;
      case 2:
        mode = CONST.TrainModes.indexes;
        break;
    }
    widget._sliderCallback(mode);
  }

  @override
  Widget build(BuildContext context) {
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
          value: _sliderValue,
          onChanged: setMode,
        ));
  }
}
