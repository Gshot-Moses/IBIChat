
class Page {}

class SplashNav extends Page{}

class LoginNav extends Page {}

class HomeNav extends Page {}

class UserListNav extends Page {}

class TicketCreationNav extends Page{}

class ConversationNav extends Page {
  int chat_id;
  int user_id;

  ConversationNav(this.chat_id, this.user_id);
}
