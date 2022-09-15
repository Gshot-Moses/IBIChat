import 'package:flutter/material.dart';
import 'package:play_flutter/model/models.dart';
import 'package:play_flutter/service/ticket_service.dart';
import 'package:play_flutter/state/app_state.dart';
import 'package:play_flutter/ui/components/ticket_element.dart';
import 'package:provider/provider.dart';


class TicketListTab extends StatelessWidget {
  TicketListTab({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AppState>(context, listen: false);
    var ticket_service = Provider.of<TicketService>(context, listen: false);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Container(
              // child: StreamBuilder(
              //   stream: ticket_service.getTicketListForUser(state.current_user!.id),
              //   builder: (context, AsyncSnapshot<List<Ticket>> snapshot) {
              //     var tickets = snapshot.data;
              //     if (tickets != null) {
              //       return ListView.builder(
              //           itemCount: tickets.length,
              //           itemBuilder: (context, index) {
              //             return TicketElement(title: tickets[index].name, color: tickets[index].color);
              //           }
              //       );
              //     }
              //     else {
              //       return const Center(child: Text("Pas de ticktets"));
              //     }
              //     //if (snapshot.connectionState == ConnectionState.active) {
              //     //}
              //   },
              // ),
              child: ticket_service.all_tickets.isNotEmpty ?
              ListView.builder(
                itemCount: ticket_service.all_tickets.length,
                reverse: true,
                itemBuilder: (context, index) {
                  return TicketElement(title: ticket_service.all_tickets[index].name,
                      color: ticket_service.all_tickets[index].color,
                      description: ticket_service.all_tickets[index].description,
                  );
                }
              ): const Center(child: Text("Pas de ticktets")),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: FloatingActionButton(
                  onPressed: () {
                    state.goToTicketCreationPage(true);
                  },
                  child: const Icon(Icons.add, color: Colors.white)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
