import 'dart:async';
import 'package:flutter/material.dart';
import 'package:play_flutter/data/repo.dart';
import 'package:play_flutter/model/models.dart';

class TicketService {
  AbstractRepo _repo;
  //StreamController<List<Ticket>> _streamController = StreamController.broadcast();
  //late Stream<List<Ticket>> _ticketStream;
  List<Ticket> all_tickets = [];

  TicketService(this._repo);

  Future<int> saveTicketToApi(int creator_id, String title, String description,
      int priority, int type) async {
    var output = await _repo.createTicket(creator_id, title, description, priority, type);
    Color color = Colors.greenAccent;
    if (priority == 1)
      Color color = Colors.greenAccent;
    else if (priority == 2)
      Color color = Colors.blue;
    else
      Color color = Colors.red;
    var ticket = Ticket(creator_id: creator_id, name: title, description: description,
        priority: priority, type: type, color: color);
    all_tickets.add(ticket);
    //_streamController.sink.add(all_tickets);
    return output;
  }

  // Stream<List<Ticket>> getTicketListForUser(int user_id) {
  //   var tickets = _repo.getTicketsForUser(user_id).then((value) {
  //     if (value != null) {
  //       value.map((e) {
  //         Color color = Colors.greenAccent;
  //         if (e.priority == 1)
  //           Color color = Colors.greenAccent;
  //         else if (e.priority == 2)
  //           Color color = Colors.blue;
  //         else
  //           Color color = Colors.red;
  //         return Ticket(creator_id: e.creator_id, name: e.title, description: e.description,
  //             priority: e.priority, type: e.type, color: color);
  //       });
  //     }
  //   });
  //   //all_tickets.addAll()
  //   _ticketStream = _streamController.stream;
  //   return _ticketStream.where((event) => event.any((element) => element.creator_id == user_id));
  // }

  Future<List<Ticket>?> getTicketsForUser(int user_id) async {
    var output = await _repo.getTicketsForUser(user_id);
    if (output != null) {
      return output.map((e) {
        Color color = Colors.greenAccent;
        if (e.priority == 1)
          Color color = Colors.greenAccent;
        else if (e.priority == 2)
          Color color = Colors.blue;
        else
          Color color = Colors.red;
        return Ticket(creator_id: e.creator_id,
            name: e.title,
            description: e.description,
            priority: e.priority,
            type: e.type,
            color: color);
      }).toList();
    }
    else
        return null;
  }
}