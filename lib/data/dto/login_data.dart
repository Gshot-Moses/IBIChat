import 'user_dto.dart';

class LoginDto {
  String token;
  UserDto user;

  LoginDto({required this.user, required this.token});
}