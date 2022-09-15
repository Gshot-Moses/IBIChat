import 'package:flutter/material.dart';
import 'package:play_flutter/data/dto/dto.dart';
import 'package:play_flutter/data/repo.dart';
import 'package:play_flutter/model/models.dart';
import 'package:play_flutter/data/network/socket_io_client.dart';
import 'package:play_flutter/state/app_state.dart';
import 'providers.dart';

class MessageService {
  AbstractRepo _repo;
  SocketIOClient _io_client;
  ChatsProvider _chatsProvider;
  bool isInitDone = false;

  MessageDto? to_send = null;

  MessageService(this._repo, this._io_client, this._chatsProvider);

  void init() {
    _io_client.connect();
    isInitDone = true;
  }

  void onChatCreated(AppState app_state) {
    _io_client.onChatCreated((data) {
      print("Event received");
      Chat chat = ChatDto.fromJson(data["data"]).toChatModel();
      if (chat.members.any((element) => element == app_state.current_user!.id)) {
        print(chat.messages);
        app_state.setChatId(chat.id);
        if (to_send != null) {
          to_send!.chat_id = chat.id;
          _io_client.emitMessage(to_send!);
          to_send = null;
        }
        _chatsProvider.addChat(chat);
        print(_chatsProvider.chats);
        app_state.all_chats.add(mapChatToName(chat, app_state.current_user!.id, app_state.userList));
      }
    });
  }

  void onReceiveMessage(Function callback) {
    _io_client.receiveMessage((data) {
        callback(data);
        //setState(() { messages.add(message.toMsg()); });
    });
  }

  void markMsgRead(int msg_id) {
    _io_client.markMsgRead(msg_id);
  }

  void onMsgRead(Function callback) {
    _io_client.onMsgRead(callback);
  }

  void addMessageToChat(Chat chat, Message message) {
    chat.messages.add(message);
  }

  Chat getChatFromId(List<Chat> chats, int chat_id) {
    return chats.firstWhere((element) => element.id == chat_id);
  }

  void emitMessage(int sender_id, int chat_id, String content, String timeStamp) {
    var msg = MessageDto(id: 0, chat_id: chat_id, read: 0, sender_id: sender_id, content: content, timeStamp: timeStamp);
    _io_client.emitMessage(msg);
  }

  void emitCreateEvent(int member1, int member2) {
    _io_client.sendCreateChatEvent([member1, member2]);
  }

  Future<List<ChatDto>?> getAllChatsFromCache(int user_id) async {
    var chats = await _repo.getAllChatsFromCache(user_id).then((value) => value?.map((e) =>
      ChatDto(id: e.id, messages: e.messages, name: e.name, member1: e.member1, member2: e.member2)).toList());
    chats?.forEach((element) async {
      var messages = await _repo.getMessagesForChatCache(element.id);
      if (messages != null)
        element.messages = messages;
      else element.messages = [];
    });
    return chats;
  }

  Future<List<ChatDto>?> getAllChatsFromApi(int user_id) async {
    var chats = await _repo.getAllChatsFromApi(user_id);
    chats?.forEach((element) async {
      await _repo.saveMessagesForChat(element.messages, element.id);
    });
    if (chats != null) await _repo.saveChatsToCache(chats);
    return chats;
  }

  String getUsernameFromId(int id, List<User> users) {
    return users.firstWhere((element) => element.id == id).first_name;
  }

  Chat mapChatToName(Chat chat, int current_user_id, List<User> users) {
    String name = chat.members[0] == current_user_id ?
    getUsernameFromId(chat.members[1], users): getUsernameFromId(chat.members[0], users);
    chat.name = name;
    return chat;
  }

  List<Chat> mapChatsToName(List<Chat> chats, int current_user_id, List<User> users) {
    chats.forEach((chat) {
      String name = chat.members[0] == current_user_id ?
      getUsernameFromId(chat.members[1], users): getUsernameFromId(chat.members[0] ,users);
      chat.name = name;
    });
    return chats;
  }

  List<Map<String, List<Message>>> arrangeMessagesByDate(List<Message> messages) {
    var dates = Set<String>();
    messages.forEach((element) {
      dates.add(element.timeStamp.toString().substring(0, 9));
    });
    List<Map<String, List<Message>>> output = [];
   for (var i in dates) {
     var msg = <Message>[];
     Map<String, List<Message>> map = {};
     messages.forEach((element) {
       if (element.timeStamp.toString().substring(0, 9) == i) {
         msg.add(element);
         map[i] = msg;
       }
     });
     output.add(map);
   }
   return output;
  }
}
