import 'package:flutter/foundation.dart';
import 'package:play_flutter/model/models.dart';
import 'package:play_flutter/navigation/page.dart';

class AppState extends ChangeNotifier {

  int _selected_user_id = -1;
  int get selected_user_id => _selected_user_id;

  String _login_token = "";
  String get login_token => _login_token;

  bool _go_to_user_list_page = false;
  bool get go_user_list_page => _go_to_user_list_page;

  bool _go_to_home_page = false;
  bool get go_to_home_page => _go_to_home_page;

  var selected_user_pic = "chef.jpg";
  List<User> userList = [];

  User? _current_user = null;
  User? get current_user => _current_user;

  List<Chat> _all_chats = [];
  List<Chat> get all_chats => _all_chats;

  int _chat_id = -2;
  int get chat_id => _chat_id;

  bool _go_to_login_page = false;
  bool get go_to_login_page => _go_to_login_page;

  bool _go_to_ticket_creation_page = false;
  bool get go_to_ticket_creation_page => _go_to_ticket_creation_page;

  Page page = SplashNav();

  AppState();

  void setLoginTokenAndCurrentUser(User user, String token) {
    _current_user = user;
    _login_token = token;
    notifyListeners();
  }

  Chat? getChatFromMembers(List<int> members) {
    for (var chat in all_chats) {
      if ((chat.members[0] == members[0] && chat.members[1] == members[1])
        || (chat.members[0] == members[1] && chat.members[1] == members[0])) {
        return chat;
      }
    }
    return null;
  }

  void addMessageToChat(Message msg, Chat chat) {
    chat.messages.add(msg);
    notifyListeners();
  }

  void goToLoginPage(bool flag) {
    _go_to_login_page = flag;
    //page = LoginNav();
    notifyListeners();
  }

  void setUserList(List<User> users) {
    userList = users;
  }

  void setAllChats(List<Chat> chats) {
    _all_chats = chats;
    notifyListeners();
  }

  void goToTicketCreationPage(bool flag) {
    _go_to_ticket_creation_page = flag;
    _go_to_user_list_page = false;
    notifyListeners();
  }

  void goToUsersListPage(bool flag) {
    _go_to_user_list_page = flag;
    //goToConverstationPage(-1, -2);
    //page = UserListNav();
    notifyListeners();
  }

  void setChatId(int id) {
    _chat_id = id;
  }

  void goToHomePage(bool flag) {
    _go_to_home_page = flag;
    //page = HomeNav();
    notifyListeners();
  }

  void goToConverstationPage(int id, int chat_id) {
    _selected_user_id = id;
    _chat_id = chat_id;
    _go_to_user_list_page = false;
    //goToUsersListPage(false);
    //page = ConversationNav(chat_id, id);
    notifyListeners();
  }
}
