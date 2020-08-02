import 'package:json_annotation/json_annotation.dart';
import 'package:stack_trainer/models/Stack.dart';
import 'package:stack_trainer/constants.dart' as CONST;

part 'card_stack_map.g.dart';

@JsonSerializable()
class CardStackMap {
  final Map<String, CardStack> stacks;

  CardStackMap(s)
      : stacks = {
          ...s,
          'Aronson': CardStack(CONST.aronson),
          'Memorandum': CardStack(CONST.memorandum),
          'Mnemonica': CardStack(CONST.mnemonica),
        };

  factory CardStackMap.fromJson(Map<String, dynamic> json) =>
      _$CardStackMapFromJson(json);
  Map<String, dynamic> toJson() => _$CardStackMapToJson(this);

  void add(key, value) {
    stacks[key] = value;
  }

  void remove(key) {
    stacks.remove(key);
  }
}
