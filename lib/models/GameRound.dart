import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:stack_trainer/StorageUtil.dart';
import 'package:stack_trainer/constants.dart' as CONST;

class GameRound with ChangeNotifier {
  static final random = new Random();
  static final subModes = [CONST.TrainModes.cards, CONST.TrainModes.indexes];
  CONST.TrainModes mode = CONST.TrainModes.mix;
  CONST.TrainModes subMode = CONST.TrainModes.indexes;

  String stack = 'Mnemonica';
  String card = '';
  int chosenPosition = -1;
  var positions = [];
  bool showDialog = false;

  GameRound() {
    stack = StorageService.getString('stack', defValue: 'Mnemonica');
    newRound();
  }

  List<int> getRandomPositions() {
    final l = List.generate(52, (i) => i + 1);
    l.shuffle();
    return [l[1], l[2], l[3], l[4]];
  }

  void newRound() {
    showDialog = false;
    chosenPosition = -1;
    final randomPositions = getRandomPositions();

    card = CONST.stack.keys.elementAt(randomPositions[0] - 1);
    randomPositions.shuffle();
    positions = randomPositions;

    if (mode == CONST.TrainModes.mix) {
      subMode = subModes[random.nextInt(subModes.length)];
    } else {
      subMode = mode;
    }
    notifyListeners();
  }

  void setMode(newMode) {
    mode = newMode;
    newRound();
    notifyListeners();
  }

  void setChosenPosition(pos) {
    chosenPosition = pos;
    final correctChoice = CONST.stack[card] == chosenPosition;

    if (correctChoice) {
      Timer(new Duration(milliseconds: 250), () => this.newRound());
    } else {
      chosenPosition = -1;
      showDialog = true;
    }
    notifyListeners();
  }

  setStack(newStack) {
    stack = newStack;
    StorageService.putString('stack', newStack);
    newRound();
  }
}
