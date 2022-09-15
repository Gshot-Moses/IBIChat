import 'dart:convert';
import 'package:play_flutter/data/cache/intern_db.dart';
import 'package:play_flutter/data/network/api_client.dart';
import 'package:play_flutter/data/dto/dto.dart';
import 'package:play_flutter/model/message.dart';

abstract class AbstractRepo {

  Future<List<UserDto>?> getAllUsersFromCache();
  Future<List<UserDto>?> getAllUsersFromApi();
  Future<void> saveUsersToCache(List<UserDto> users);
  Future<LoginDto?> loginApi(String identifier, String password);
  Future<LoginDto?> getLoginFromCache(int user_id);
  Future<int> saveLoginToCache(LoginDto loginDto);
  Future<List<ChatDto>?> getAllChatsFromCache(int id);
  Future<List<ChatDto>?> getAllChatsFromApi(int id);
  Future<void> saveChatsToCache(List<ChatDto> chats);
  Future<List<MessageDto>?> getMessagesForChatCache(int id);
  Future<UserDto?> getUserFromApi(int id);
  Future<void> saveMessagesForChat(List<MessageDto> messages, int chat_id);
  Future<int> createTicket(int creator_id, String title, String description,
      int priority, int type);
  Future<List<TicketDto>?> getTicketsForUser(int user_id);
  //Future<Result<int>> postMessage(sender_id, receiver_id, content);
}

class Repo extends AbstractRepo {
  APIClient _client;
  InternDb _db;

  Repo(this._client, this._db);


  @override
  Future<List<TicketDto>?> getTicketsForUser(int user_id) async {
    var response = await _client.getTicketsForUser(user_id);
    if (response.isSuccessful) {
      var data = json.decode(response.body);
      var tickets = convertResponseToTicketList(data["tickets"]);
      return tickets;
    }
    return null;
  }

  @override
  Future<int> createTicket(int creator_id, String title, String description,
      int priority, int type) async {
    var payload = {"creator_id": creator_id,
      "title": title, "description": description,
      "priority": priority, "type": type};
    var response = await _client.createTicket(json.encode(payload));
    if (response.isSuccessful) {
      var body = json.decode(response.body);
      return body["id"];
    }
    return 0;
  }

  @override
  Future<UserDto?> getUserFromApi(int id) async {
    var response = await _client.getUserFromApi(id);
    if (response.isSuccessful) {
      var body = json.decode(response.body);
      return UserDto.fromJson(body["user"]);
    }
    else return null;
  }

  @override
  Future<LoginDto?> loginApi(String identifier, String password) async {
    var payload = {"identifier": identifier, "password": password};
    var response = await _client.login(json.encode(payload));
    if (response.isSuccessful) {
      var body = json.decode(response.body);
      var user = UserDto.fromJson(body["data"]["user"]);
      var token = body["data"]["token"];
      LoginDto loginDto = LoginDto(user: user, token: token);
      await _db.insertLogin(LoginsCompanion.insert(user_id: user.id, token: token));
      return loginDto;
    }
    else return null;
  }

  @override
  Future<List<UserDto>?> getAllUsersFromApi() async {
    var response = await _client.getUsers();
    if (response.isSuccessful) {
      var body = json.decode(response.body);
      //print(body["data"]);
      var data = convertResponseToUserList(body["data"]);
      return data;
    }
    else return null;
  }


  @override
  Future<List<ChatDto>?> getAllChatsFromApi(int id) async {
    var response = await _client.getHistory(id);
    if (response.isSuccessful) {
      var body = json.decode(response.body);
      var data = convertResponseToChatList(body["data"]);
      return data;
    }
    else return null;
  }


  @override
  Future<List<UserDto>?> getAllUsersFromCache() async {
    return await _db.getAllUsers().then((value) =>
        value.map((e) => UserDto(id: e.id, identifier: e.identifier, first_name: e.first_name,
            last_name: e.last_name, title: e.title, phone: e.phone)).toList());
  }


  @override
  Future<List<MessageDto>?> getMessagesForChatCache(int id) async {
    return await _db.getAllMessagesForChat(id).then((value) =>
        value.map((e) =>
            MessageDto(id: e.id, chat_id: e.chat_id, read: 0, sender_id: e.sender_id, content: e.content,
                timeStamp: e.timeStamp.toString())).toList());
  }

  @override
  Future<void> saveUsersToCache(List<UserDto> users) async {
    return await _db.insertAllUsers(users.map((e) =>
        UsersCompanion.insert(id: e.id, identifier: e.identifier, first_name: e.first_name,
            last_name: e.last_name, title: e.title, phone: e.phone)).toList());
  }

  @override
  Future<LoginDto?> getLoginFromCache(int user_id) async {
    return await _db.getLoginFromUserId(user_id).then((value) { if (value != null)
        LoginDto(user: UserDto(id: value.user.id, identifier: value.user.identifier,
            first_name: value.user.first_name, last_name: value.user.last_name,
            title: value.user.title, phone: value.user.phone), token: value.token); });
  }

  @override
  Future<int> saveLoginToCache(LoginDto loginDto) async {
    return await _db.insertLogin(LoginsCompanion.insert(user_id: loginDto.user.id, token: loginDto.token));
  }

  @override
  Future<List<ChatDto>?> getAllChatsFromCache(int id) async {
    return await _db.getAllChatsForUser(id).
    then((value) =>
        value.map((e) =>
            ChatDto(id: e.id, messages: [], name: e.name, member1: e.member1, member2: e.member2)).toList());
  }

  @override
  Future<void> saveChatsToCache(List<ChatDto> chats) async {
    return await _db.insertAllChats(
        chats.map((e) =>
            ChatsCompanion.insert(id: e.id, member1: e.member1, member2: e.member2, name: e.name)).toList());
  }

  @override
  Future<void> saveMessagesForChat(List<MessageDto> messages, int chat_id) async {
    return await _db.insertMessages(
        messages.map((e) =>
            MessagesCompanion.insert(chat_id: chat_id, sender_id: e.sender_id,
                content: e.content, timeStamp: DateTime.parse(e.timeStamp))).toList());
  }
}

List<ChatDto> convertResponseToChatList(List<dynamic> data) {
  List<ChatDto> output = [];
  for (var temp in data) {
    var chat = ChatDto.fromJson(temp);
    output.add(chat);
  }
  return output;
}

List<UserDto> convertResponseToUserList(List<dynamic> data) {
  List<UserDto> output = [];
  for (var temp in data) {
    var user = UserDto.fromJson(temp);
    output.add(user);
  }
  return output;
}

List<TicketDto> convertResponseToTicketList(List<dynamic> data) {
  List<TicketDto> output = [];
  for (var temp in data) {
    var ticket = TicketDto.fromJson(temp);
    output.add(ticket);
  }
  return output;
}

class WebRepo extends AbstractRepo {
  APIClient _client;

  WebRepo(this._client);

  @override
  Future<int> createTicket(int creator_id, String title, String description,
      int priority, int type) async {
    var payload = {"creator_id": creator_id,
      "title": title, "description": description,
      "priority": priority, "type": type};
    var response = await _client.createTicket(json.encode(payload));
    if (response.isSuccessful) {
      var body = json.decode(response.body);
      return body["id"];
    }
    return 0;
  }


  @override
  Future<List<TicketDto>?> getTicketsForUser(int user_id) async {
    var response = await _client.getTicketsForUser(user_id);
    if (response.isSuccessful) {
      var data = json.decode(response.body);
      var tickets = convertResponseToTicketList(data["tickets"]);
      return tickets;
    }
    return null;
  }

  @override
  Future<List<UserDto>?> getAllUsersFromCache() {
    return Future.value();
  }

  @override
  Future<void> saveMessagesForChat(List<MessageDto> messages, int chat_id) {
    return Future.value();
  }

  @override
  Future<List<MessageDto>?> getMessagesForChatCache(int id) {
    return Future.value();
  }

  @override
  Future<void> saveChatsToCache(List<ChatDto> chats) {
    return Future.value();
  }

  @override
  Future<List<ChatDto>?> getAllChatsFromApi(int id) async {
    var response = await _client.getHistory(id);
    if (response.isSuccessful) {
      var body = json.decode(response.body);
      var data = convertResponseToChatList(body["data"]);
      return data;
    }
    else return null;
  }

  @override
  Future<List<ChatDto>?> getAllChatsFromCache(int id) {
    return Future.value();
  }

  @override
  Future<int> saveLoginToCache(LoginDto loginDto) {
    return Future.value(1);
  }

  @override
  Future<LoginDto?> getLoginFromCache(int user_id) {
    return Future.value();
  }

  @override
  Future<LoginDto?> loginApi(String identifier, String password) async {
    var payload = {"identifier": identifier, "password": password};
    var response = await _client.login(json.encode(payload));
    if (response.isSuccessful) {
      var body = json.decode(response.body);
      var user = UserDto.fromJson(body["data"]["user"]);
      var token = body["data"]["token"];
      LoginDto loginDto = LoginDto(user: user, token: token);
      //await _db.insertLogin(LoginsCompanion.insert(user_id: user.id, token: token));
      return loginDto;
    }
    else return null;
  }

  @override
  Future<void> saveUsersToCache(List<UserDto> users) {
    return Future.value();
  }

  @override
  Future<List<UserDto>?> getAllUsersFromApi() async {
    var response = await _client.getUsers();
    if (response.isSuccessful) {
      var body = json.decode(response.body);
      //print(body["data"]);
      var data = convertResponseToUserList(body["data"]);
      return data;
    }
    else return null;
  }

  @override
  Future<UserDto?> getUserFromApi(int id) async {
    var response = await _client.getUserFromApi(id);
    if (response.isSuccessful) {
      var body = json.decode(response.body);
      return UserDto.fromJson(body["user"]);
    }
    else return null;
  }
}
