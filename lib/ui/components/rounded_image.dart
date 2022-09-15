import 'dart:math';

import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  String username;
  var colors = [Colors.blue, Colors.red, Colors.green, Colors.pink, Colors.purple];

  RoundedImage(this.username);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   constraints: const BoxConstraints.expand(width: 50, height: 50),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10),
    //     image: DecorationImage(
    //       image: AssetImage(image),
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    // );
    return CircleAvatar(
      backgroundColor: colors[Random().nextInt(colors.length - 1)],
      //backgroundColor: Colors.pink,
      child: Center(child: Text(username[0].toUpperCase(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),)),
    );
  }
}
