import 'message.dart';

class Chat {
  int id;
  String name;
  List<int> members;
  List<Message> messages;

  Chat({required this.id, required this.name, required this.members, required this.messages});

  void add_message(Message msg) {
    messages.insert(0, msg);
  }

  @override
  bool operator ==(Object other) {
    if (other is Chat) {
      if (this.id == other.id) {
        return true;
      }
      return false;
    }
    return false;
  }
}
