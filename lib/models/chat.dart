import 'package:json_annotation/json_annotation.dart';
import 'package:minsk8/import.dart';

part 'chat.g.dart';

@JsonSerializable()
class ChatModel {
  ChatModel({
    this.unit,
    this.companion,
    this.messages,
    this.isUnitOwnerWritesNow,
    this.isCompanionWritesNow,
    this.isUnitOwnerReadAll,
    this.isCompanionReadAll,
  });

  final UnitModel unit;
  final MemberModel companion;
  final List<MessageModel> messages;
  final bool isUnitOwnerWritesNow;
  final bool isCompanionWritesNow;
  final bool isUnitOwnerReadAll;
  final bool isCompanionReadAll;

  String get id => '${unit.id} ${companion.id}';

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
