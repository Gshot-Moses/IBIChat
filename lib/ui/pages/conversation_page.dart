import 'package:flutter/material.dart';
import 'package:play_flutter/data/dto/dto.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:play_flutter/service/providers.dart';
import 'package:play_flutter/service/user_service.dart';
import 'package:play_flutter/ui/components/components.dart';
import 'package:play_flutter/service/message_service.dart';
import 'package:play_flutter/model/models.dart';
import 'package:play_flutter/state/app_state.dart';
import 'package:provider/provider.dart';

class ConversationPage extends StatefulWidget {
  static const PAGE_NAME = "room";

  static MaterialPage page() => MaterialPage(
    key: const ValueKey(PAGE_NAME),
    name: PAGE_NAME,
    child: ConversationPage(),
  );

  ConversationPage({Key? key}): super(key: key);

  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<ConversationPage> {

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Message> messages = [];
  //MessageDto? send = null;
  late AppState _state;
  late MessageService _message_service;
  late UserService _user_service;
  late ChatsProvider _chatsProvider;
  Chat? chat = null;


  @override
  void initState() {
    _state = Provider.of<AppState>(context, listen: false);
    _message_service = Provider.of<MessageService>(context, listen: false);
    _user_service = Provider.of(context, listen: false);
    _chatsProvider = Provider.of(context, listen: false);

    super.initState();
    if (_state.chat_id > -1) {
      //var chat = _message_service.getChatFromId(_state.all_chats, _state.chat_id);
      chat = _chatsProvider.chats.firstWhere((element) => element.id == _state.chat_id);
      //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      //print(messages);
    }
    //_scrollController.position
    if (!_message_service.isInitDone)
      _message_service.init();
    /*_message_service.onReceiveMessage((data) {
      var message = MessageDto.fromJson(data["data"]);
      if (message.chat_id == _state.chat_id) {
        var chat = _message_service.getChatFromId(_state.all_chats, _state.chat_id);
        //var msg = chat.messages.singleWhere((element) => element.timeStamp.toString() == message.timeStamp);
        _state.addMessageToChat(message.toMsg(), chat);
          setState(() {
            messages.insert(messages.length - 1, message.toMsg());
            //_scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          });
      }
    });*/

    //_message_service.onChatCreated(_state);
  }

  _onSendPressed() {
    final content = _controller.text;
    _message_service.to_send = MessageDto(
      id: 0,
      read: 0,
      sender_id: _state.current_user!.id,
      chat_id: _state.chat_id, content: content,
      timeStamp: DateTime.now().toString());

    if (_state.chat_id == -1) {
      _message_service.emitCreateEvent(_state.current_user!.id, _state.selected_user_id);
    }
    else {
      _message_service.emitMessage(
        _message_service.to_send!.sender_id,
        _message_service.to_send!.chat_id,
        _message_service.to_send!.content,
        _message_service.to_send!.timeStamp,
      );
      _message_service.to_send = null;
    }
    //print(DateTime.now().toString());
    _controller.clear();
  }

  Widget _messageBubble(String content, int hour, int minute, Alignment align, Color color, bool isSender) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
          child: Column(
            children: [
              BubbleSpecialThree(
                text: content,
                tail: false,
                isSender: isSender,
                color: color,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              Align(alignment: align, child: Text("$hour:$minute", style: const TextStyle(fontSize: 11))),
            ],
          ),
        ),
      );
  }

  Widget _sendTextField() {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.send,
      decoration: const InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
        prefixIcon: Icon(Icons.message),
        //labelText: "Ecrivez votre message",
        hintText: "Ecrivez votre message",
        contentPadding: EdgeInsets.only(left: 5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //messages = messages.reversed.toList();
    //var display = state.all_chats.firstWhere((element) => element.id == state.chat_id).messages.reversed.toList();
    _chatsProvider = Provider.of(context, listen: true);
    late Chat? chat_obj;
    try {
      chat_obj = _chatsProvider.chats.firstWhere((e) => e.id == _state.chat_id);
    }
    catch( Exception) {
      chat_obj = null;
    }
    /*if (_chatsProvider.chats.isNotEmpty)
      var chat_obj = _chatsProvider.chats.firstWhere((e) => e.id == _state.chat_id);
    else var chat_obj = null;*/
    if (chat_obj != null) {
      chat!.messages.forEach((element) {
        if (element.sender_id != _state.current_user!.id && element.read == 0) {
          _message_service.markMsgRead(element.id);
        }
      });
      _message_service.onMsgRead((data) {
        var msg = chat!.messages.firstWhere((element) => element.id == data["data"]);
        _chatsProvider.markMsgRead(msg);
      });
    }
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            RoundedImage(_user_service.getUsernameFromId(_state.selected_user_id, _state.userList)),
            const SizedBox(width: 10),
            Text(_user_service.getUsernameFromId(_state.selected_user_id, _state.userList)),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("wallpaper.png"), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Expanded(
              child: chat_obj != null ? ListView.builder(
                  itemCount: _chatsProvider.chats.firstWhere((e) => e.id == _state.chat_id).messages.length,//messages.length,
                  controller: _scrollController,
                  reverse: true,
                  itemBuilder: (context, index) {
                    var msg = _chatsProvider.chats.firstWhere((e) => e.id == _state.chat_id).messages[index];//messages[index]; const Color(0xFFC0C0C0)
                    if (msg.sender_id == _state.current_user!.id)
                      return _messageBubble(msg.content, msg.timeStamp.hour, msg.timeStamp.minute, Alignment.bottomRight, const Color(0xFF1B97F3), true);
                    else
                      return _messageBubble(msg.content, msg.timeStamp.hour, msg.timeStamp.minute, Alignment.bottomLeft, const Color(0xFF5c8266), false);
                  }
              ) : Container(),
              //child: SingleChildScrollView(
              //controller: _scrollController,
              //child: Column(
              //children: messages.map((msg) {
              //if (msg.sender_id == _state.current_user!.id) {
              //return _messageBubble(msg.content, msg.timeStamp.hour, msg.timeStamp.minute, Alignment.bottomRight, const Color(0xFF1B97F3), true);
              //} else {
              //  return _messageBubble(msg.content, msg.timeStamp.hour, msg.timeStamp.minute, Alignment.bottomLeft, const Color(0xFFC0C0C0), false);
              //}
              //}).toList(),
              //),
              //),
            ),
            Container(
              width: size.width,
              height: 70,
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: _sendTextField()),
                    const SizedBox(width: 5),
                    Center(child:
                    _sendBtn(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    //return
  }

  Widget _sendBtn() {
    return Container(
      constraints: const BoxConstraints.tightFor(width: 50, height: 50),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: IconButton(
        onPressed: _onSendPressed,
        iconSize: 25,
        icon: const Icon(Icons.send, color: Colors.white),
      ),
    );
  }
}
