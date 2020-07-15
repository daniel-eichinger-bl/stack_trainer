// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_stack_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardStackMap _$CardStackMapFromJson(Map<String, dynamic> json) {
  return CardStackMap(
    (json['stacks'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(
          k, e == null ? null : CardStack.fromJson(e as Map<String, dynamic>)),
    ),
  );
}

Map<String, dynamic> _$CardStackMapToJson(CardStackMap instance) =>
    <String, dynamic>{
      'stacks': instance.stacks,
    };
