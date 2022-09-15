//import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:play_flutter/service/ticket_service.dart';
import 'package:play_flutter/state/app_state.dart';
import 'package:provider/provider.dart';

class TicketCreationPage extends StatefulWidget {
  const TicketCreationPage({Key? key}) : super(key: key);

  static const String PAGE_NAME = "ticketCreation";

  static MaterialPage page() {
    return const MaterialPage(
        child: TicketCreationPage(),
        name: PAGE_NAME,
        key: ValueKey(PAGE_NAME)
    );
  }

  @override
  _TicketCreationState createState() => _TicketCreationState();
}

class _TicketCreationState extends State<TicketCreationPage> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController _titleTextController;
  late TextEditingController _descriptionTextController;
  String? priority = "Normale";
  String? type = "Demaande";

  List<DropdownMenuItem<String>> get typeItems {
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(child: Text("Incident"), value: "Incident"),
      DropdownMenuItem(child: Text("Demande"), value: "Demande"),
    ];
    return items;
  }

  List<DropdownMenuItem<String>> get priorityItems {
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(child: Text("Basse"), value: "Basse"),
      DropdownMenuItem(child: Text("Normale"), value: "Normale"),
      DropdownMenuItem(child: Text("Haute"), value: "Haute"),
    ];
    return items;
  }

  @override
  void initState() {
    super.initState();
    _titleTextController = TextEditingController();
    _descriptionTextController = TextEditingController();
  }

  int mapPriorityToInt(String priority) {
    if (type == "Basse")
      return 1;
    else if (type == "Normale")
      return 2;
    else return 3;
  }

  int mapTypeToInt(String type) {
    if (type == "DEmande")
      return 1;
    else return 2;
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AppState>(context, listen: false);
    var ticket_service = Provider.of<TicketService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Creation Ticket"),
        elevation: 0,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: "Titre", border: OutlineInputBorder(),
                      ),
                      controller: _titleTextController,
                      validator: (String? value) {},
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                        //borderSide: BorderSide(color: Colors.blue, width: 2),
                        //borderRadius: BorderRadius.circular(20),
                        ),
                        border: OutlineInputBorder(
                          //borderSide: BorderSide(color: Colors.blue, width: 2),
                          //borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) => value == null ? "Choisir" : null,
                      dropdownColor: Colors.blueAccent,
                      value: "Incident",
                      onChanged: (String? newValue) { type = newValue; },
                      items: typeItems
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            //borderSide: BorderSide(color: Colors.blue, width: 2),
                            //borderRadius: BorderRadius.circular(20),
                          ),
                          border: OutlineInputBorder(
                            //borderSide: BorderSide(color: Colors.blue, width: 2),
                            //borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) => value == null ? "Choisir" : null,
                        dropdownColor: Colors.blueAccent,
                        value: "Normale",
                        onChanged: (String? newValue) { priority = newValue; },
                        items: priorityItems
                    ),
                    const SizedBox(height: 10),
                    /*DropDownField(
                      value: "Normale",
                      items: ["Basse", "Normale", "Haute"],
                    ),*/
                    TextFormField(
                      obscureText: false,
                      decoration: const InputDecoration(
                        hintText: "Description",
                        border: OutlineInputBorder(),
                      ),
                      controller: _descriptionTextController,
                      validator: (String? value) {},
                      maxLines: 5,
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                        onPressed: () async {
                          String title = _titleTextController.text;
                          String description = _descriptionTextController.text;
                          if (type == null) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vous devez choisir un type")));
                            return;
                          }
                          if (priority == null) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vous devez choisir un priority")));
                            return;
                          }
                          int priorityInt = mapPriorityToInt(priority!);
                          int typeInt = mapTypeToInt(type!);
                          int result = await ticket_service.saveTicketToApi(state.current_user!.id, title,
                              description, priorityInt, typeInt);
                          if (result > 0) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Votre ticket a ete creer")));
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Echec de creation de ticket. Reesayez.")));
                          }
                        },
                        child: const Text("Creer")
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
