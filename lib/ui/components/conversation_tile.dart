import 'package:flutter/material.dart';
import 'package:play_flutter/service/message_service.dart';
import 'package:provider/provider.dart';
import 'package:play_flutter/state/app_state.dart';
import 'package:play_flutter/model/models.dart';
import 'package:play_flutter/ui/components/components.dart';
import 'package:play_flutter/service/providers.dart';

class ConversationTile extends StatelessWidget {
  final Chat chat;
  final int current_user_id;
  //final int index;

  const ConversationTile({Key? key, required this.chat,
    required this.current_user_id}): super(key: key);

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AppState>(context, listen: false);
    var message_service = Provider.of<MessageService>(context, listen: false);
    var chatsProvider = Provider.of<ChatsProvider>(context, listen: false);
    return Column(
      children: [
        InkWell(
          onTap: () {
            state.goToConverstationPage(chat.members[1] == current_user_id ? chat.members[0] : chat.members[1], chat.id);
          },
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //RoundedImage(_user_service.getUsernameFromId(state.selected_user_id, state.userList)),
                  const SizedBox(width: 10),
                  RoundedImage(message_service.mapChatToName(chat, state.current_user!.id, state.userList).name),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(message_service.mapChatToName(chat, state.current_user!.id, state.userList).name, style: const TextStyle(fontSize: 15)),
                      Text(getLatestMessage(chat.messages), style: const TextStyle(fontSize: 14, color: Colors.grey)),
                      //Text(chatsProvider.lastMessages[index].content, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(width: 150),
                  chat.messages.where((element) => (element.read == 0 && element.sender_id != state.current_user!.id)).length > 0 ?
                  Chip(
                    label: Text(chat.messages.where((element) => (element.read == 0 && element.sender_id != state.current_user!.id)).length.toString()),
                    labelStyle: const TextStyle(color: Colors.white),
                    backgroundColor: Colors.blue,
                  ): const SizedBox(width: 0, height: 0),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const Divider(height: 0),
      ],
    );
        //const Divider(height: 0),
  }

  String getLatestMessage(List<Message> messages) {
    //print(messages[messages.length - 1].content);
    if (messages.length == 1) {
      var output = prependUser(messages[0].sender_id);
      //if (messages[0].content.length > 30)
        //output += messages[0].content[30] + "...";
        //return output + messages[0].content[30] + "...";
      return output + messages[0].content;
    }
    var output = prependUser(messages[0].sender_id);
    //print(messages[messages.length - 1].content);
    //if (messages[messages.length - 1].content.length > 30)
    //  return output + messages[messages.length - 1].content[30] + "...";
    return output + messages[0].content;
    //return output + messages[0].content;
  }

  String prependUser(int sender_id) {
    if (sender_id == current_user_id)
      return "Vous: ";
    return "";
  }
}
