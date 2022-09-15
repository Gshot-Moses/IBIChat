import 'package:flutter/foundation.dart';
import 'package:play_flutter/model/models.dart';

class ChatsProvider extends ChangeNotifier{
  List<Chat> _chats = [];
  List<Chat> get chats => _chats;
  List<Message> lastMessages = [];

  void setChats(List<Chat> chats) {
    if (_chats.isNotEmpty)
      _chats.clear();
    _chats.addAll(chats);
    notifyListeners();
  }

  void addChat(Chat chat) {
    _chats.insert(0, chat);
    notifyListeners();
  }

  void addMsgToChat(Chat chat, Message msg) {
    var obj = _chats.singleWhere((e) => e.id == chat.id);
    obj.add_message(msg);
    _chats.remove(obj);
    _chats.insert(0, obj);
    notifyListeners();
  }

  void markMsgRead(Message msg) {
    msg.markMessageAsRead();
  }
}
