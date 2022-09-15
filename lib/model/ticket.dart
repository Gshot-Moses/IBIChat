import 'package:flutter/material.dart';

class Ticket {
  int creator_id;
  String name;
  String description;
  int priority;
  int type;
  Color color;

  Ticket({required this.creator_id, required this.name, required this.description,
    required this.priority, required this.type, required this.color});
}