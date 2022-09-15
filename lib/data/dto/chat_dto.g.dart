// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatDto _$ChatDtoFromJson(Map<String, dynamic> json) => ChatDto(
      id: json['id'] as int,
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MessageDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['ref'] as String,
      member1: json['member1'] as int,
      member2: json['member2'] as int,
    );

Map<String, dynamic> _$ChatDtoToJson(ChatDto instance) => <String, dynamic>{
      'id': instance.id,
      'ref': instance.name,
      'member1': instance.member1,
      'member2': instance.member2,
      'messages': instance.messages,
    };
