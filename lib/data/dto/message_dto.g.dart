// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDto _$MessageDtoFromJson(Map<String, dynamic> json) => MessageDto(
      id: json['id'] as int,
      chat_id: json['chat_id'] as int,
      read: json['read'] as int,
      sender_id: json['sender_id'] as int,
      content: json['content'] as String,
      timeStamp: json['timeStamp'] as String,
    );

Map<String, dynamic> _$MessageDtoToJson(MessageDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chat_id': instance.chat_id,
      'read': instance.read,
      'sender_id': instance.sender_id,
      'content': instance.content,
      'timeStamp': instance.timeStamp,
    };
