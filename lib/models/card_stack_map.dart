import 'package:json_annotation/json_annotation.dart';
import 'package:stack_trainer/models/Stack.dart';
import 'package:stack_trainer/constants.dart' as CONST;

part 'card_stack_map.g.dart';

@JsonSerializable()
class CardStackMap {
  final Map<String, CardStack> stacks;

  // CardStackMap(this.stacks);

  CardStackMap(stacks) : stacks = {'Mnemonica': CardStack(CONST.stack)};

  factory CardStackMap.fromJson(Map<String, dynamic> json) => _$CardStackMapFromJson(json);
  Map<String, dynamic> toJson() => _$CardStackMapToJson(this);

  void add(key, value) {
    stacks[key] = value;
  }

}