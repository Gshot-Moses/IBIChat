import 'dart:convert';
import 'package:play_flutter/data/dto/dto.dart';
import 'package:play_flutter/model/models.dart';
import 'package:play_flutter/data/repo.dart';
import 'package:play_flutter/data/dto/login_data.dart';

class UserService {
  AbstractRepo _repo;

  String _token = "";
  String get token => _token;

  UserService(this._repo);

  Future<List<User>?> getAllUsersFromCache() async {
     return await _repo.getAllUsersFromCache().then((users) => users?.map((e) => e.toUserModel()).toList());
  }

  Future<List<User>?> getAllUsersFromApi() async {
    var users = await _repo.getAllUsersFromApi();
    if (users != null)
      await _repo.saveUsersToCache(users);
    return users?.map((e) => User(id: e.id, identifier: e.identifier,
        first_name: e.first_name, last_name: e.last_name, title: e.title, phone: e.phone)).toList();
  }

  Future<LoginDto?> getLoginFromCache(int user_id) async {
    return await _repo.getLoginFromCache(user_id);
  }

  Future<int> saveLoginToCache(LoginDto loginDto) async {
    return await _repo.saveLoginToCache(loginDto);
  }

  Future<LoginDto?> login(String identifier, String password) async {
    return await _repo.loginApi(identifier, password).then((value) {
      if (value != null) return LoginDto(user: value.user, token: value.token);
    });
  }

  Future<User?> getUserFromApi(int id) async {
    return await _repo.getUserFromApi(id).then((value) { if (value != null) return value.toUserModel();});
  }

  List<User> filterOutCurrentUserFromList(List<User> users, int current_user_id) {
    var to_get_rid_of = users.firstWhere((element) => element.id == current_user_id);
    users.remove(to_get_rid_of);
    return users;
  }

  String getUsernameFromId(int id, List<User> users) {
    return users.firstWhere((element) => element.id == id).first_name;
  }
}
