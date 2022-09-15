// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketDto _$TicketDtoFromJson(Map<String, dynamic> json) => TicketDto(
      id: json['id'] as int,
      creator_id: json['creator_id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      priority: json['priority'] as int,
      type: json['type'] as int,
    );

Map<String, dynamic> _$TicketDtoToJson(TicketDto instance) => <String, dynamic>{
      'id': instance.id,
      'creator_id': instance.creator_id,
      'title': instance.title,
      'description': instance.description,
      'priority': instance.priority,
      'type': instance.type,
    };
