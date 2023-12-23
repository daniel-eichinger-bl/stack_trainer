import 'package:json_annotation/json_annotation.dart';

part 'Stack.g.dart';

// https://flutter.dev/docs/development/data-and-backend/json
@JsonSerializable()
class CardStack {
  final Map<String, int> order;

  CardStack(this.order);

  factory CardStack.fromJson(Map<String, dynamic> json) =>
      _$CardStackFromJson(json);

  Map<String, dynamic> toJson() => _$CardStackToJson(this);
}
