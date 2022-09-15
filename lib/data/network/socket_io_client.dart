import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:play_flutter/model/models.dart';
import 'package:play_flutter/state/app_state.dart';
import 'package:play_flutter/data/dto/dto.dart';

class SocketIOClient {
  String server_url = "http://localhost:5000";

  late Socket _io_client;
  Socket get io_client => _io_client;
  AppState state;

  SocketIOClient({required this.state});

  void connect() {
    _io_client = io(server_url, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    _io_client.connect();
  }

  void emitMessage(MessageDto message) {
    _io_client.emit("msg", message.toJson());
  }

  void receiveMessage(Function callback) {
    _io_client.on("msg", (data) {
        callback(data);
    });
  }

  bool checkChatExist(int chat_id, List<Chat> chats) {
    for (var chat in chats) {
      if (chat.id == chat_id)
        return true;
    }
    return false;
  }

  void sendCreateChatEvent(List<int> members) {
    _io_client.emit("create", {"members": members});
  }

  void onChatCreated(Function callback) {
    _io_client.on("create", (data) {
      print(data);
      callback(data);
    });
  }

  void markMsgRead(int msg_id) {
    _io_client.emit("read", {"msg_id": msg_id});
  }

  void onMsgRead(Function callback) {
    _io_client.on("read", (data) {
      callback(data);
    });
  }
}
