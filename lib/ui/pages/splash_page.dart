import 'dart:async';
import 'package:flutter/material.dart';
import 'package:play_flutter/service/message_service.dart';
import 'package:play_flutter/service/providers.dart';
import 'package:play_flutter/service/ticket_service.dart';
import 'package:play_flutter/service/user_service.dart';
import 'package:play_flutter/state/app_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  AppState _state;
  MessageService _messageService;
  UserService _service;
  TicketService _ticketService;
  static const String PAGE_NAME = "Splash";

  static MaterialPage page(AppState state, MessageService messageService, UserService userService, TicketService ticketService) {
    return MaterialPage(child: SplashPage(userService, messageService, state, ticketService), name: PAGE_NAME, key: ValueKey(PAGE_NAME));
  }

  SplashPage(this._service, this._messageService, this._state, this._ticketService, {Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
  //var _state = Provider.of<AppState>(context, listen: false);
  bool goLogin = false;
  _init(ChatsProvider chatsProvider) {
    Timer(const Duration(seconds: 2), () async {
      var _state = widget._state;
      var _messageService = widget._messageService;
      var _userService = widget._service;
      var ticket_service = widget._ticketService;

      var pref = await SharedPreferences.getInstance();
      var user_id = await pref.get("user_id");
      if (user_id != null) {
        var login = await _userService.getLoginFromCache(user_id as int);
        var allUsers = await _userService.getAllUsersFromCache();
        allUsers ??= await _userService.getAllUsersFromApi();
        if (login != null)
          _state.setLoginTokenAndCurrentUser(login.user.toUserModel(), login.token);
        else {
          var loginApi = await _userService.getUserFromApi(user_id);
          var token = await pref.getString("token");
          if (loginApi != null)
            _state.setLoginTokenAndCurrentUser(loginApi, token!);
        }
        var tickets = await ticket_service.getTicketsForUser(_state.current_user!.id);
        if (tickets != null) {
          ticket_service.all_tickets.addAll(tickets);
        }
        allUsers = _userService.filterOutCurrentUserFromList(allUsers!, _state.current_user!.id);
        _state.setUserList(allUsers);
        var allChats = await _messageService.getAllChatsFromCache(_state.current_user!.id);
        allChats ??= await _messageService.getAllChatsFromApi(_state.current_user!.id);
        _state.setAllChats(allChats!.map((e) => e.toChatModel()).toList());
        chatsProvider.setChats(allChats.map((e) => e.toChatModel()).toList());
        //goLogin = false;
        widget._state.goToHomePage(true);
      }
      else {
        widget._state.goToLoginPage(true);
        //goLogin = true;
        //var login = await widget._service
      }
      print("executed");
    });
  }


  @override
  void initState() {
    super.initState();
    ChatsProvider chat_provider = Provider.of<ChatsProvider>(context, listen: false);
    _init(chat_provider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(image: AssetImage("chef.png"), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(strokeWidth: 3.0),
          ],
        ),
      ),
    );
  }
}
