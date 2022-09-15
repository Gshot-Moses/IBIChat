import 'package:json_annotation/json_annotation.dart';
import 'package:play_flutter/model/user.dart';
//import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "identifier")
  String identifier;
  @JsonKey(name: "first_name")
  String first_name;
  @JsonKey(name: "last_name")
  String last_name;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "phone")
  String phone;

  UserDto({required this.id,  required this.identifier, required this.first_name, required this.last_name,
    required this.title,
    required this.phone});

  User toUserModel() {
    return User(id: this.id, identifier: this.identifier, first_name: this.first_name,
      last_name: this.last_name, title: this.title, phone: this.phone);
  }
}

@JsonSerializable()
class ServerResponse {
  String status;
  @JsonKey(name: "data")
  List<UserDto> data;

  ServerResponse({required this.status, required this.data});

  factory ServerResponse.fromJson(Map<String, dynamic> json) => _$ServerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ServerResponseToJson(this);
}
