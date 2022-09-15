import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:play_flutter/data/cache/shared.dart';
import 'package:play_flutter/data/cache/intern_db.dart';
import 'package:play_flutter/data/network/api_client.dart';
import 'package:play_flutter/navigation/page.dart';
import 'package:play_flutter/service/ticket_service.dart';
import 'package:play_flutter/ui/pages/ticket_creation_page.dart';
import 'package:provider/provider.dart';
import 'package:play_flutter/data/repo.dart';
import 'package:play_flutter/state/app_state.dart';
import 'package:play_flutter/service/message_service.dart';
import 'package:play_flutter/service/user_service.dart';
import 'package:play_flutter/ui/pages/pages.dart';
import 'package:play_flutter/data/network/socket_io_client.dart';
import 'package:play_flutter/service/providers.dart';
//import 'dart:ffi';

void main() async {
  //setTargetPlatformForDesktop();
  _setupLogging();
  APIClient _client = APIClient.create();
  late AbstractRepo _repo;
  if (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) {
    InternDb _db = openConnection();
    _repo = Repo(_client, _db);
  }
  else {
    _repo = WebRepo(_client);
  }
  runApp(Demo(_repo));
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

void setTargetPlatformForDesktop({TargetPlatform? platform}) {
  TargetPlatform? targetPlatform;
  if (platform != null) {
    targetPlatform = platform;
  }
  if (targetPlatform == null) {
    if (Platform.isMacOS) {
      targetPlatform = TargetPlatform.iOS;
    } else if (Platform.isLinux || Platform.isWindows) {
      targetPlatform = TargetPlatform.android;
    }
  }
  debugDefaultTargetPlatformOverride = targetPlatform;
}

class Demo extends StatefulWidget {
  AbstractRepo _repo;

  Demo(this._repo, {Key? key}): super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  late AppState _app_state;
  late SocketIOClient _io_client;
  late MessageService _message_service;
  late UserService _user_service;
  late TicketService _ticket_service;
  late ChatsProvider _chats_provider;

  @override
  void initState() {
    super.initState();
    _app_state = AppState();
    _io_client = SocketIOClient(state: _app_state);
    _chats_provider = ChatsProvider();
    _message_service = MessageService(widget._repo, _io_client, _chats_provider);
    _user_service = UserService(widget._repo);
    _ticket_service = TicketService(widget._repo);
  }

  /*LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final folder = await getApplicationDocumentsDirectory();
      final file = File(p.join(folder.path, "intern.sqlite"));
      return NativeDatabase(file);
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserService>(
          create: (context) => _user_service
        ),
        Provider<MessageService>(
          create: (context) => _message_service,
        ),
        Provider<TicketService>(
          create: (context) => _ticket_service,
        ),
        ChangeNotifierProvider<AppState>(
          create: (context) => _app_state,
        ),
        ChangeNotifierProvider<ChatsProvider>(
            create: (context) => _chats_provider,
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            home:Consumer<AppState>(
              builder: (mcontext, state, child) {
                return Navigator(
                  onPopPage: (route, result) {
                    if (!route.didPop(result))
                      return false;
                    if (route.settings.name == Home.PAGE_NAME)
                      state.goToHomePage(false);
                    if (route.settings.name == ConversationPage.PAGE_NAME)
                      state.goToConverstationPage(-1, -2);
                    if (route.settings.name == UserListPage.PAGE_NAME)
                      state.goToUsersListPage(false);
                    if (route.settings.name == SplashPage.PAGE_NAME)
                      state.goToLoginPage(false);
                    if (route.settings.name == TicketCreationPage.PAGE_NAME)
                      state.goToTicketCreationPage(false);
                    return true;
                  },
                  pages: [
                    SplashPage.page(_app_state, _message_service, _user_service, _ticket_service),
                    if (_app_state.go_to_login_page)
                      LoginPage.page(),
                    if (state.go_to_home_page)
                      Home.page(),
                    if (state.selected_user_id != -1 && state.chat_id != -2)
                      ConversationPage.page(),
                    if (state.go_user_list_page)
                      UserListPage.page(),
                    if (state.go_to_ticket_creation_page)
                      TicketCreationPage.page(),
                  ],
                );
              },
            )
          );
        },
      ),
    );
  }
}
