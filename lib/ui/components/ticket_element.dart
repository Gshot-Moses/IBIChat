import 'package:flutter/material.dart';

class TicketElement extends StatelessWidget {

  final String title;
  final description;
  final Color color;

  const TicketElement({Key? key, required this.title, required this.color, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 40,
                maxWidth: MediaQuery.of(context).size.width - 10,
                minHeight: 40,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: 30,
                      width: 10,
                      color: color
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 3),
                        Text(description, style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              )
          ),
          const Divider(height: 1,color: Colors.grey),
        ],
      )
    );
  }
}