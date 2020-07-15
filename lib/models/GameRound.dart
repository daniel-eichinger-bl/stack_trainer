import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:stack_trainer/models/Stack.dart';
import 'package:stack_trainer/models/card_stack_map.dart';
import 'package:stack_trainer/storage_service.dart';
import 'package:stack_trainer/constants.dart' as CONST;

class GameRound with ChangeNotifier {
  static final random = new Random();
  static final subModes = [CONST.TrainModes.cards, CONST.TrainModes.indexes];
  CONST.TrainModes mode = CONST.TrainModes.mix;
  CONST.TrainModes subMode = CONST.TrainModes.indexes;

  String stackName;
  CardStackMap map;
  CardStack stack;

  String card = '';
  int chosenPosition = -1;
  List<int> positions = [];
  bool showDialog = false;

  GameRound() {
    String jsonString = StorageService.getString('stacks', defValue: '{}');
    Map decoded = jsonDecode(jsonString);
    if (decoded.length == 0) {
      map = CardStackMap({});
    } else {
      map = CardStackMap.fromJson(decoded);
    }

    stackName = StorageService.getString('stack', defValue: 'Mnemonica');
    stack = map.stacks[stackName];
    newRound();
  }

  List<int> getRandomPositions() {
    final l = List.generate(stack.order.length, (i) => i + 1);
    l.shuffle();
    return [l[0], l[1], l[2], l[3]];
  }

  void newRound() {
    showDialog = false;
    chosenPosition = -1;
    final randomPositions = getRandomPositions();

    card = stack.order.keys.elementAt(randomPositions[0] - 1);
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
    final correctChoice = stack.order[card] == chosenPosition;

    if (correctChoice) {
      Timer(new Duration(milliseconds: 250), () => this.newRound());
    } else {
      chosenPosition = -1;
      showDialog = true;
    }
    notifyListeners();
  }

  setStack(String n, CardStack s) {
    stackName = n;
    stack = s;
    StorageService.putString('stack', stackName);
    newRound();
  }

  void addStack(String stackName, CardStack stack) {
    map.add(stackName, stack);

    String json = jsonEncode(map);
    StorageService.putString('stacks', json);

    notifyListeners();
  }
}
