import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:play_flutter/state/app_state.dart';
import 'package:play_flutter/service/message_service.dart';
import 'pages.dart';

class Home extends StatefulWidget {
  //MessageService _message_service;
  Home({Key? key}): super(key: key);

  static const PAGE_NAME = "home";

  static MaterialPage page() {
    return MaterialPage(
      name: PAGE_NAME,
      key: ValueKey(PAGE_NAME),
      child: Home(),
    );
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    var _message_service = Provider.of<MessageService>(context, listen: false);
    var _state = Provider.of<AppState>(context, listen: false);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text("IBI"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.message)),
              Tab(icon: Icon(Icons.note)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ConversationListTab(_message_service, _state),
            TicketListTab(),
          ],
        ),
      ),
    );
  }
}
