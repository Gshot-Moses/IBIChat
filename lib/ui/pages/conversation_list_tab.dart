import 'package:flutter/material.dart';
import 'package:play_flutter/service/providers.dart';
import 'package:provider/provider.dart';
//import 'package:play_flutter/data/repo.dart';
import 'package:play_flutter/state/app_state.dart';
//import 'package:play_flutter/service/socket_io_client.dart';
import 'package:play_flutter/ui/components/components.dart';
import 'package:play_flutter/model/models.dart';
import 'package:play_flutter/data/dto/dto.dart';
import 'package:play_flutter/service/message_service.dart';
import 'package:play_flutter/service/providers.dart';


class ConversationListTab extends StatefulWidget {
  MessageService _message_service;
  AppState _state;
  ConversationListTab(this._message_service, this._state, {Key? key}): super(key: key);

  static const PAGE_NAME = "conversation";

  static MaterialPage page(MessageService service, AppState state) => MaterialPage(
    key: ValueKey(PAGE_NAME),
    name: PAGE_NAME,
    child: ConversationListTab(service, state)
  );

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<ConversationListTab> {

  late AppState _state;
  late MessageService _message_service;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _state = Provider.of<AppState>(context, listen: true);
    _message_service = Provider.of<MessageService>(context, listen: false);
  }

  @override
  void initState() {
    var chatsProvider = Provider.of<ChatsProvider>(context, listen: false);
    super.initState();
    //var message_service =
    //var state =
    if (!widget._message_service.isInitDone)
      widget._message_service.init();
    widget._message_service.onReceiveMessage((data) {
      var message = MessageDto.fromJson(data["data"]);
      var chat = widget._message_service.getChatFromId(widget._state.all_chats, message.chat_id);
      if (chat != null) {
        //chat.messages.add(message.toMsg());
        //var msg = chat.messages.singleWhere((element) => element.timeStamp.toString() == message.timeStamp);
        //if (msg == null)
        //widget._state.addMessageToChat(message.toMsg(), chat);
        chatsProvider.addMsgToChat(chat, message.toMsg());
        //setState(() {});
      }
    });
    widget._message_service.onChatCreated(widget._state);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatsProvider>(
        builder: (context, provider, child) {
          //state.all_chats.retainWhere((element) => element.messages.isNotEmpty);
          var items = provider.chats;
          Widget body = ListView.builder(
            itemCount: provider.chats.length,
            itemBuilder: (context, index) {
              if (items[index].messages.isEmpty)
                return const SizedBox(width: 0, height: 0);
              else
                return ConversationTile(chat: items[index], current_user_id: widget._state.current_user!.id);
            },
          );
          Widget empty = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.message_outlined, size: 100, color: Colors.grey[200]),
                const Text("Pas de conversations"),
              ],
            ),
          );
          return Stack(
            children: [
              provider.chats.every((element) => element.messages.isEmpty) ? empty : body,
              Positioned(
                right: 15,
                bottom: 15,
                child: FloatingActionButton(
                  onPressed: () {
                    widget._state.goToUsersListPage(true);
                  },
                  child: const Icon(Icons.person),
                ),
              ),
            ],
          );
        }
      //child:
    );
  }
}
