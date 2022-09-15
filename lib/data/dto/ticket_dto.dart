import 'package:json_annotation/json_annotation.dart';

part 'ticket_dto.g.dart';

@JsonSerializable()
class TicketDto {

  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "creator_id")
  int creator_id;

  @JsonKey(name: "title")
  String title;

  @JsonKey(name: "description")
  String description;

  @JsonKey(name: "priority")
  int priority;

  @JsonKey(name: "type")
  int type;

  factory TicketDto.fromJson(Map<String, dynamic> json) => _$TicketDtoFromJson(json);

  TicketDto({required this.id, required this.creator_id, required this.title,
    required this.description, required this.priority, required this.type});

  Map<String, dynamic> toJson() => _$TicketDtoToJson(this);
}