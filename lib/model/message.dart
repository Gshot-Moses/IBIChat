//import 'dart:core';

class Message {
  int id;
  int sender_id;
  int room_id;
  int read;
  String content;
  DateTime timeStamp;

  Message({required this.id, required this.sender_id, required this.room_id, required this.read,
    required this.content,
    required this.timeStamp});

  void markMessageAsRead() {
    read = 1;
  }
}
