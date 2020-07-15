import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:stack_trainer/storage_service.dart';
import 'package:stack_trainer/constants.dart' as CONST;

class GameRound with ChangeNotifier {
  static final random = new Random();
  static final subModes = [CONST.TrainModes.cards, CONST.TrainModes.indexes];
  CONST.TrainModes mode = CONST.TrainModes.mix;
  CONST.TrainModes subMode = CONST.TrainModes.indexes;

  String stackName = 'Mnemonica';
  Map<String, dynamic> stackOrder = CONST.stack;
  String card = '';
  int chosenPosition = -1;
  List<int> positions = [];
  bool showDialog = false;

  GameRound() {
    stackName = StorageService.getString('stack', defValue: 'Mnemonica');
    newRound();
  }

  List<int> getRandomPositions() {
    final l = List.generate(stackOrder.length, (i) => i + 1);
    l.shuffle();
    return [l[0], l[1], l[2], l[3]];
  }

  void newRound() {
    showDialog = false;
    chosenPosition = -1;
    final randomPositions = getRandomPositions();

    card = stackOrder.keys.elementAt(randomPositions[0] - 1);
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
    final correctChoice = stackOrder[card] == chosenPosition;

    if (correctChoice) {
      Timer(new Duration(milliseconds: 250), () => this.newRound());
    } else {
      chosenPosition = -1;
      showDialog = true;
    }
    notifyListeners();
  }

  setStack(name, order) {
    // stackName = name;
    // stackOrder = order;
    // StorageService.putString('stack', name);
    // newRound();
  }
}
