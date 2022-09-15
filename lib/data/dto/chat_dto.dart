import 'package:json_annotation/json_annotation.dart';
import 'package:play_flutter/model/models.dart';
import 'message_dto.dart';

part 'chat_dto.g.dart';

@JsonSerializable()
class ChatDto {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "ref")
  String name;

  @JsonKey(name: "member1")
  int member1;

  @JsonKey(name: "member2")
  int member2;

  @JsonKey(name: "messages")
  List<MessageDto> messages;

  factory ChatDto.fromJson(Map<String, dynamic> json) => _$ChatDtoFromJson(json);

  ChatDto({required this.id, required this.messages, required this.name,
    required this.member1, required this.member2});

  Chat toChatModel() {
    List<Message> converted = [];
    for (var m in this.messages) {
      converted.add(m.toMsg());
    }
    return Chat(id: this.id, name: this.name, members: [this.member1, this.member2], messages: converted);
  }
}
