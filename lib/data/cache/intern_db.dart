import 'package:drift/drift.dart';

part 'intern_db.g.dart';

class Users extends Table {
  IntColumn get id => integer()();
  TextColumn get identifier => text()();
  TextColumn get first_name => text()();
  TextColumn get last_name => text()();
  TextColumn get title => text()();
  TextColumn get phone => text()();
}

class Logins extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get user_id => integer()();
  TextColumn get token => text()();
}

class Chats extends Table {
  IntColumn get id => integer()();
  IntColumn get member1 => integer()();
  IntColumn get member2 => integer()();
  TextColumn get name => text()();
}

class Messages extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get chat_id => integer()();
  IntColumn get sender_id => integer()();
  TextColumn get content => text()();
  DateTimeColumn get timeStamp => dateTime()();
}

class Tickets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get creator_id => integer()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  IntColumn get type => integer()();
  IntColumn get priority => integer()();
}

@DriftDatabase(tables: [Users, Logins, Chats, Messages, Tickets])
class InternDb extends _$InternDb {
  InternDb(QueryExecutor e): super(e);

  @override
  int get schemaVersion => 1;

  Future<int> insertTicket(TicketsCompanion companion) {
    return into(tickets).insert(companion);
  }

  Stream<List<Ticket>> getTicketsForUser(int user_id) {
    return (select(tickets)..where((tbl) => tbl.creator_id.equals(user_id))).watch();
  }

  Future<List<User>> getAllUsers() => select(users).get();

  Future<List<Message>> getAllMessagesForChat(int id) {
    return (select(messages)..where((t) => t.chat_id.equals(id))).get();
  }


  Future<List<Chat>> getAllChatsForUser(int id) {
    return (select(chats)..where((t) => t.member1.equals(id) | t.member2.equals(id))).get();
  }

  Future<int> insertChat(ChatsCompanion companion) {
    return into(chats).insert(companion);
  }

  Future<int> insertMessage(MessagesCompanion companion) {
    return into(messages).insert(companion);
  }

  Future<void> insertMessages(List<MessagesCompanion> entries) async {
    await batch((b) {
      b.insertAll(chats, entries);
    });
  }

  Future<void> insertAllChats(List<ChatsCompanion> entries) async {
    await batch((b) {
      b.insertAll(chats, entries);
    });
  }

  Future<void> insertAllUsers(List<UsersCompanion> entries) async {
    await batch((b) {
      b.insertAll(users, entries);
    });
  }

  Future<int> insertLogin(LoginsCompanion entry) {
    return into(logins).insert(entry);
  }

  Future<User> getUserFromIdentifier(String identifier) {
    return (select(users)..where((tbl) => tbl.identifier.equals(identifier))).getSingle();
  }

  Future<LoginDataModel?> getLoginFromUserId(int user_id) async {
    var user = await (select(users)..where((tbl) => tbl.id.equals(user_id))).getSingle();
    var login = await (select(logins)..where((tbl) => tbl.user_id.equals(user_id))).getSingleOrNull();
    if (login != null)
      return LoginDataModel(user, login.token);
    else return null;
  }

  Future<LoginDataModel?> login(String identifier, String password) async {
    var user = await getUserFromIdentifier(identifier);
    var login = await (select(logins)..where((tbl) => tbl.user_id.equals(user.id))).getSingleOrNull();
    if (login != null)
      return LoginDataModel(user, login.token);
    else return null;
  }
}

class LoginDataModel {
  User user;
  String token;

  LoginDataModel(this.user, this.token);
}
