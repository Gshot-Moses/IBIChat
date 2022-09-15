// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      id: json['id'] as int,
      identifier: json['identifier'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      title: json['title'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'id': instance.id,
      'identifier': instance.identifier,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'title': instance.title,
      'phone': instance.phone,
    };

ServerResponse _$ServerResponseFromJson(Map<String, dynamic> json) =>
    ServerResponse(
      status: json['status'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => UserDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServerResponseToJson(ServerResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
