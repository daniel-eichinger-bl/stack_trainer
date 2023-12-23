// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Stack.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardStack _$CardStackFromJson(Map<String, dynamic> json) {
  return CardStack(
    (json['order'] as Map<String, dynamic>).map(
      (k, e) => MapEntry(k, e as int),
    ),
  );
}

Map<String, dynamic> _$CardStackToJson(CardStack instance) => <String, dynamic>{
      'order': instance.order,
    };
