import 'dart:core';
import 'package:json_annotation/json_annotation.dart';
import 'package:play_flutter/model/models.dart';

part 'message_dto.g.dart';

@JsonSerializable()
class MessageDto {

  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "chat_id")
  int chat_id;

  @JsonKey(name: "read")
  int read;

  @JsonKey(name: "sender_id")
  int sender_id;

  @JsonKey(name: "content")
  String content;

  @JsonKey(name: "timeStamp")
  String timeStamp;

  factory MessageDto.fromJson(Map<String, dynamic> json) => _$MessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);

  MessageDto({required this.id, required this.chat_id, required this.read, required this.sender_id,
    required this.content,
    required this.timeStamp});

  Message toMsg() {
    return Message(id: this.id, sender_id: this.sender_id, room_id: this.chat_id, read: this.read,
        content: this.content,
      timeStamp: DateTime.parse(this.timeStamp));
  }
}
