// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intern_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
  final int id;
  final String identifier;
  final String first_name;
  final String last_name;
  final String title;
  final String phone;
  User(
      {required this.id,
      required this.identifier,
      required this.first_name,
      required this.last_name,
      required this.title,
      required this.phone});
  factory User.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      identifier: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}identifier'])!,
      first_name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}first_name'])!,
      last_name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}last_name'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      phone: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}phone'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['identifier'] = Variable<String>(identifier);
    map['first_name'] = Variable<String>(first_name);
    map['last_name'] = Variable<String>(last_name);
    map['title'] = Variable<String>(title);
    map['phone'] = Variable<String>(phone);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      identifier: Value(identifier),
      first_name: Value(first_name),
      last_name: Value(last_name),
      title: Value(title),
      phone: Value(phone),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      identifier: serializer.fromJson<String>(json['identifier']),
      first_name: serializer.fromJson<String>(json['first_name']),
      last_name: serializer.fromJson<String>(json['last_name']),
      title: serializer.fromJson<String>(json['title']),
      phone: serializer.fromJson<String>(json['phone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'identifier': serializer.toJson<String>(identifier),
      'first_name': serializer.toJson<String>(first_name),
      'last_name': serializer.toJson<String>(last_name),
      'title': serializer.toJson<String>(title),
      'phone': serializer.toJson<String>(phone),
    };
  }

  User copyWith(
          {int? id,
          String? identifier,
          String? first_name,
          String? last_name,
          String? title,
          String? phone}) =>
      User(
        id: id ?? this.id,
        identifier: identifier ?? this.identifier,
        first_name: first_name ?? this.first_name,
        last_name: last_name ?? this.last_name,
        title: title ?? this.title,
        phone: phone ?? this.phone,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('identifier: $identifier, ')
          ..write('first_name: $first_name, ')
          ..write('last_name: $last_name, ')
          ..write('title: $title, ')
          ..write('phone: $phone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, identifier, first_name, last_name, title, phone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.identifier == this.identifier &&
          other.first_name == this.first_name &&
          other.last_name == this.last_name &&
          other.title == this.title &&
          other.phone == this.phone);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> identifier;
  final Value<String> first_name;
  final Value<String> last_name;
  final Value<String> title;
  final Value<String> phone;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.identifier = const Value.absent(),
    this.first_name = const Value.absent(),
    this.last_name = const Value.absent(),
    this.title = const Value.absent(),
    this.phone = const Value.absent(),
  });
  UsersCompanion.insert({
    required int id,
    required String identifier,
    required String first_name,
    required String last_name,
    required String title,
    required String phone,
  })  : id = Value(id),
        identifier = Value(identifier),
        first_name = Value(first_name),
        last_name = Value(last_name),
        title = Value(title),
        phone = Value(phone);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? identifier,
    Expression<String>? first_name,
    Expression<String>? last_name,
    Expression<String>? title,
    Expression<String>? phone,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (identifier != null) 'identifier': identifier,
      if (first_name != null) 'first_name': first_name,
      if (last_name != null) 'last_name': last_name,
      if (title != null) 'title': title,
      if (phone != null) 'phone': phone,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? identifier,
      Value<String>? first_name,
      Value<String>? last_name,
      Value<String>? title,
      Value<String>? phone}) {
    return UsersCompanion(
      id: id ?? this.id,
      identifier: identifier ?? this.identifier,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      title: title ?? this.title,
      phone: phone ?? this.phone,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (identifier.present) {
      map['identifier'] = Variable<String>(identifier.value);
    }
    if (first_name.present) {
      map['first_name'] = Variable<String>(first_name.value);
    }
    if (last_name.present) {
      map['last_name'] = Variable<String>(last_name.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('identifier: $identifier, ')
          ..write('first_name: $first_name, ')
          ..write('last_name: $last_name, ')
          ..write('title: $title, ')
          ..write('phone: $phone')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _identifierMeta = const VerificationMeta('identifier');
  @override
  late final GeneratedColumn<String?> identifier = GeneratedColumn<String?>(
      'identifier', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _first_nameMeta = const VerificationMeta('first_name');
  @override
  late final GeneratedColumn<String?> first_name = GeneratedColumn<String?>(
      'first_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _last_nameMeta = const VerificationMeta('last_name');
  @override
  late final GeneratedColumn<String?> last_name = GeneratedColumn<String?>(
      'last_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String?> phone = GeneratedColumn<String?>(
      'phone', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, identifier, first_name, last_name, title, phone];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('identifier')) {
      context.handle(
          _identifierMeta,
          identifier.isAcceptableOrUnknown(
              data['identifier']!, _identifierMeta));
    } else if (isInserting) {
      context.missing(_identifierMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
          _first_nameMeta,
          first_name.isAcceptableOrUnknown(
              data['first_name']!, _first_nameMeta));
    } else if (isInserting) {
      context.missing(_first_nameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_last_nameMeta,
          last_name.isAcceptableOrUnknown(data['last_name']!, _last_nameMeta));
    } else if (isInserting) {
      context.missing(_last_nameMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    return User.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class Login extends DataClass implements Insertable<Login> {
  final int id;
  final int user_id;
  final String token;
  Login({required this.id, required this.user_id, required this.token});
  factory Login.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Login(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      user_id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}user_id'])!,
      token: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}token'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(user_id);
    map['token'] = Variable<String>(token);
    return map;
  }

  LoginsCompanion toCompanion(bool nullToAbsent) {
    return LoginsCompanion(
      id: Value(id),
      user_id: Value(user_id),
      token: Value(token),
    );
  }

  factory Login.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Login(
      id: serializer.fromJson<int>(json['id']),
      user_id: serializer.fromJson<int>(json['user_id']),
      token: serializer.fromJson<String>(json['token']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'user_id': serializer.toJson<int>(user_id),
      'token': serializer.toJson<String>(token),
    };
  }

  Login copyWith({int? id, int? user_id, String? token}) => Login(
        id: id ?? this.id,
        user_id: user_id ?? this.user_id,
        token: token ?? this.token,
      );
  @override
  String toString() {
    return (StringBuffer('Login(')
          ..write('id: $id, ')
          ..write('user_id: $user_id, ')
          ..write('token: $token')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, user_id, token);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Login &&
          other.id == this.id &&
          other.user_id == this.user_id &&
          other.token == this.token);
}

class LoginsCompanion extends UpdateCompanion<Login> {
  final Value<int> id;
  final Value<int> user_id;
  final Value<String> token;
  const LoginsCompanion({
    this.id = const Value.absent(),
    this.user_id = const Value.absent(),
    this.token = const Value.absent(),
  });
  LoginsCompanion.insert({
    this.id = const Value.absent(),
    required int user_id,
    required String token,
  })  : user_id = Value(user_id),
        token = Value(token);
  static Insertable<Login> custom({
    Expression<int>? id,
    Expression<int>? user_id,
    Expression<String>? token,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (user_id != null) 'user_id': user_id,
      if (token != null) 'token': token,
    });
  }

  LoginsCompanion copyWith(
      {Value<int>? id, Value<int>? user_id, Value<String>? token}) {
    return LoginsCompanion(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      token: token ?? this.token,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (user_id.present) {
      map['user_id'] = Variable<int>(user_id.value);
    }
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoginsCompanion(')
          ..write('id: $id, ')
          ..write('user_id: $user_id, ')
          ..write('token: $token')
          ..write(')'))
        .toString();
  }
}

class $LoginsTable extends Logins with TableInfo<$LoginsTable, Login> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoginsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _user_idMeta = const VerificationMeta('user_id');
  @override
  late final GeneratedColumn<int?> user_id = GeneratedColumn<int?>(
      'user_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String?> token = GeneratedColumn<String?>(
      'token', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, user_id, token];
  @override
  String get aliasedName => _alias ?? 'logins';
  @override
  String get actualTableName => 'logins';
  @override
  VerificationContext validateIntegrity(Insertable<Login> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_user_idMeta,
          user_id.isAcceptableOrUnknown(data['user_id']!, _user_idMeta));
    } else if (isInserting) {
      context.missing(_user_idMeta);
    }
    if (data.containsKey('token')) {
      context.handle(
          _tokenMeta, token.isAcceptableOrUnknown(data['token']!, _tokenMeta));
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Login map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Login.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LoginsTable createAlias(String alias) {
    return $LoginsTable(attachedDatabase, alias);
  }
}

class Chat extends DataClass implements Insertable<Chat> {
  final int id;
  final int member1;
  final int member2;
  final String name;
  Chat(
      {required this.id,
      required this.member1,
      required this.member2,
      required this.name});
  factory Chat.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Chat(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      member1: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}member1'])!,
      member2: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}member2'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['member1'] = Variable<int>(member1);
    map['member2'] = Variable<int>(member2);
    map['name'] = Variable<String>(name);
    return map;
  }

  ChatsCompanion toCompanion(bool nullToAbsent) {
    return ChatsCompanion(
      id: Value(id),
      member1: Value(member1),
      member2: Value(member2),
      name: Value(name),
    );
  }

  factory Chat.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chat(
      id: serializer.fromJson<int>(json['id']),
      member1: serializer.fromJson<int>(json['member1']),
      member2: serializer.fromJson<int>(json['member2']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'member1': serializer.toJson<int>(member1),
      'member2': serializer.toJson<int>(member2),
      'name': serializer.toJson<String>(name),
    };
  }

  Chat copyWith({int? id, int? member1, int? member2, String? name}) => Chat(
        id: id ?? this.id,
        member1: member1 ?? this.member1,
        member2: member2 ?? this.member2,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Chat(')
          ..write('id: $id, ')
          ..write('member1: $member1, ')
          ..write('member2: $member2, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, member1, member2, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chat &&
          other.id == this.id &&
          other.member1 == this.member1 &&
          other.member2 == this.member2 &&
          other.name == this.name);
}

class ChatsCompanion extends UpdateCompanion<Chat> {
  final Value<int> id;
  final Value<int> member1;
  final Value<int> member2;
  final Value<String> name;
  const ChatsCompanion({
    this.id = const Value.absent(),
    this.member1 = const Value.absent(),
    this.member2 = const Value.absent(),
    this.name = const Value.absent(),
  });
  ChatsCompanion.insert({
    required int id,
    required int member1,
    required int member2,
    required String name,
  })  : id = Value(id),
        member1 = Value(member1),
        member2 = Value(member2),
        name = Value(name);
  static Insertable<Chat> custom({
    Expression<int>? id,
    Expression<int>? member1,
    Expression<int>? member2,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (member1 != null) 'member1': member1,
      if (member2 != null) 'member2': member2,
      if (name != null) 'name': name,
    });
  }

  ChatsCompanion copyWith(
      {Value<int>? id,
      Value<int>? member1,
      Value<int>? member2,
      Value<String>? name}) {
    return ChatsCompanion(
      id: id ?? this.id,
      member1: member1 ?? this.member1,
      member2: member2 ?? this.member2,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (member1.present) {
      map['member1'] = Variable<int>(member1.value);
    }
    if (member2.present) {
      map['member2'] = Variable<int>(member2.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatsCompanion(')
          ..write('id: $id, ')
          ..write('member1: $member1, ')
          ..write('member2: $member2, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $ChatsTable extends Chats with TableInfo<$ChatsTable, Chat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _member1Meta = const VerificationMeta('member1');
  @override
  late final GeneratedColumn<int?> member1 = GeneratedColumn<int?>(
      'member1', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _member2Meta = const VerificationMeta('member2');
  @override
  late final GeneratedColumn<int?> member2 = GeneratedColumn<int?>(
      'member2', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, member1, member2, name];
  @override
  String get aliasedName => _alias ?? 'chats';
  @override
  String get actualTableName => 'chats';
  @override
  VerificationContext validateIntegrity(Insertable<Chat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('member1')) {
      context.handle(_member1Meta,
          member1.isAcceptableOrUnknown(data['member1']!, _member1Meta));
    } else if (isInserting) {
      context.missing(_member1Meta);
    }
    if (data.containsKey('member2')) {
      context.handle(_member2Meta,
          member2.isAcceptableOrUnknown(data['member2']!, _member2Meta));
    } else if (isInserting) {
      context.missing(_member2Meta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Chat map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Chat.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ChatsTable createAlias(String alias) {
    return $ChatsTable(attachedDatabase, alias);
  }
}

class Message extends DataClass implements Insertable<Message> {
  final int id;
  final int chat_id;
  final int sender_id;
  final String content;
  final DateTime timeStamp;
  Message(
      {required this.id,
      required this.chat_id,
      required this.sender_id,
      required this.content,
      required this.timeStamp});
  factory Message.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Message(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      chat_id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}chat_id'])!,
      sender_id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sender_id'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
      timeStamp: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}time_stamp'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['chat_id'] = Variable<int>(chat_id);
    map['sender_id'] = Variable<int>(sender_id);
    map['content'] = Variable<String>(content);
    map['time_stamp'] = Variable<DateTime>(timeStamp);
    return map;
  }

  MessagesCompanion toCompanion(bool nullToAbsent) {
    return MessagesCompanion(
      id: Value(id),
      chat_id: Value(chat_id),
      sender_id: Value(sender_id),
      content: Value(content),
      timeStamp: Value(timeStamp),
    );
  }

  factory Message.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Message(
      id: serializer.fromJson<int>(json['id']),
      chat_id: serializer.fromJson<int>(json['chat_id']),
      sender_id: serializer.fromJson<int>(json['sender_id']),
      content: serializer.fromJson<String>(json['content']),
      timeStamp: serializer.fromJson<DateTime>(json['timeStamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'chat_id': serializer.toJson<int>(chat_id),
      'sender_id': serializer.toJson<int>(sender_id),
      'content': serializer.toJson<String>(content),
      'timeStamp': serializer.toJson<DateTime>(timeStamp),
    };
  }

  Message copyWith(
          {int? id,
          int? chat_id,
          int? sender_id,
          String? content,
          DateTime? timeStamp}) =>
      Message(
        id: id ?? this.id,
        chat_id: chat_id ?? this.chat_id,
        sender_id: sender_id ?? this.sender_id,
        content: content ?? this.content,
        timeStamp: timeStamp ?? this.timeStamp,
      );
  @override
  String toString() {
    return (StringBuffer('Message(')
          ..write('id: $id, ')
          ..write('chat_id: $chat_id, ')
          ..write('sender_id: $sender_id, ')
          ..write('content: $content, ')
          ..write('timeStamp: $timeStamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, chat_id, sender_id, content, timeStamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == this.id &&
          other.chat_id == this.chat_id &&
          other.sender_id == this.sender_id &&
          other.content == this.content &&
          other.timeStamp == this.timeStamp);
}

class MessagesCompanion extends UpdateCompanion<Message> {
  final Value<int> id;
  final Value<int> chat_id;
  final Value<int> sender_id;
  final Value<String> content;
  final Value<DateTime> timeStamp;
  const MessagesCompanion({
    this.id = const Value.absent(),
    this.chat_id = const Value.absent(),
    this.sender_id = const Value.absent(),
    this.content = const Value.absent(),
    this.timeStamp = const Value.absent(),
  });
  MessagesCompanion.insert({
    this.id = const Value.absent(),
    required int chat_id,
    required int sender_id,
    required String content,
    required DateTime timeStamp,
  })  : chat_id = Value(chat_id),
        sender_id = Value(sender_id),
        content = Value(content),
        timeStamp = Value(timeStamp);
  static Insertable<Message> custom({
    Expression<int>? id,
    Expression<int>? chat_id,
    Expression<int>? sender_id,
    Expression<String>? content,
    Expression<DateTime>? timeStamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (chat_id != null) 'chat_id': chat_id,
      if (sender_id != null) 'sender_id': sender_id,
      if (content != null) 'content': content,
      if (timeStamp != null) 'time_stamp': timeStamp,
    });
  }

  MessagesCompanion copyWith(
      {Value<int>? id,
      Value<int>? chat_id,
      Value<int>? sender_id,
      Value<String>? content,
      Value<DateTime>? timeStamp}) {
    return MessagesCompanion(
      id: id ?? this.id,
      chat_id: chat_id ?? this.chat_id,
      sender_id: sender_id ?? this.sender_id,
      content: content ?? this.content,
      timeStamp: timeStamp ?? this.timeStamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (chat_id.present) {
      map['chat_id'] = Variable<int>(chat_id.value);
    }
    if (sender_id.present) {
      map['sender_id'] = Variable<int>(sender_id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (timeStamp.present) {
      map['time_stamp'] = Variable<DateTime>(timeStamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessagesCompanion(')
          ..write('id: $id, ')
          ..write('chat_id: $chat_id, ')
          ..write('sender_id: $sender_id, ')
          ..write('content: $content, ')
          ..write('timeStamp: $timeStamp')
          ..write(')'))
        .toString();
  }
}

class $MessagesTable extends Messages with TableInfo<$MessagesTable, Message> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessagesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _chat_idMeta = const VerificationMeta('chat_id');
  @override
  late final GeneratedColumn<int?> chat_id = GeneratedColumn<int?>(
      'chat_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _sender_idMeta = const VerificationMeta('sender_id');
  @override
  late final GeneratedColumn<int?> sender_id = GeneratedColumn<int?>(
      'sender_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _timeStampMeta = const VerificationMeta('timeStamp');
  @override
  late final GeneratedColumn<DateTime?> timeStamp = GeneratedColumn<DateTime?>(
      'time_stamp', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, chat_id, sender_id, content, timeStamp];
  @override
  String get aliasedName => _alias ?? 'messages';
  @override
  String get actualTableName => 'messages';
  @override
  VerificationContext validateIntegrity(Insertable<Message> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('chat_id')) {
      context.handle(_chat_idMeta,
          chat_id.isAcceptableOrUnknown(data['chat_id']!, _chat_idMeta));
    } else if (isInserting) {
      context.missing(_chat_idMeta);
    }
    if (data.containsKey('sender_id')) {
      context.handle(_sender_idMeta,
          sender_id.isAcceptableOrUnknown(data['sender_id']!, _sender_idMeta));
    } else if (isInserting) {
      context.missing(_sender_idMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('time_stamp')) {
      context.handle(_timeStampMeta,
          timeStamp.isAcceptableOrUnknown(data['time_stamp']!, _timeStampMeta));
    } else if (isInserting) {
      context.missing(_timeStampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Message map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Message.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MessagesTable createAlias(String alias) {
    return $MessagesTable(attachedDatabase, alias);
  }
}

class Ticket extends DataClass implements Insertable<Ticket> {
  final int id;
  final int creator_id;
  final String title;
  final String description;
  final int type;
  final int priority;
  Ticket(
      {required this.id,
      required this.creator_id,
      required this.title,
      required this.description,
      required this.type,
      required this.priority});
  factory Ticket.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Ticket(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      creator_id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}creator_id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      description: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}description'])!,
      type: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      priority: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}priority'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['creator_id'] = Variable<int>(creator_id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['type'] = Variable<int>(type);
    map['priority'] = Variable<int>(priority);
    return map;
  }

  TicketsCompanion toCompanion(bool nullToAbsent) {
    return TicketsCompanion(
      id: Value(id),
      creator_id: Value(creator_id),
      title: Value(title),
      description: Value(description),
      type: Value(type),
      priority: Value(priority),
    );
  }

  factory Ticket.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ticket(
      id: serializer.fromJson<int>(json['id']),
      creator_id: serializer.fromJson<int>(json['creator_id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      type: serializer.fromJson<int>(json['type']),
      priority: serializer.fromJson<int>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'creator_id': serializer.toJson<int>(creator_id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'type': serializer.toJson<int>(type),
      'priority': serializer.toJson<int>(priority),
    };
  }

  Ticket copyWith(
          {int? id,
          int? creator_id,
          String? title,
          String? description,
          int? type,
          int? priority}) =>
      Ticket(
        id: id ?? this.id,
        creator_id: creator_id ?? this.creator_id,
        title: title ?? this.title,
        description: description ?? this.description,
        type: type ?? this.type,
        priority: priority ?? this.priority,
      );
  @override
  String toString() {
    return (StringBuffer('Ticket(')
          ..write('id: $id, ')
          ..write('creator_id: $creator_id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, creator_id, title, description, type, priority);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ticket &&
          other.id == this.id &&
          other.creator_id == this.creator_id &&
          other.title == this.title &&
          other.description == this.description &&
          other.type == this.type &&
          other.priority == this.priority);
}

class TicketsCompanion extends UpdateCompanion<Ticket> {
  final Value<int> id;
  final Value<int> creator_id;
  final Value<String> title;
  final Value<String> description;
  final Value<int> type;
  final Value<int> priority;
  const TicketsCompanion({
    this.id = const Value.absent(),
    this.creator_id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.type = const Value.absent(),
    this.priority = const Value.absent(),
  });
  TicketsCompanion.insert({
    this.id = const Value.absent(),
    required int creator_id,
    required String title,
    required String description,
    required int type,
    required int priority,
  })  : creator_id = Value(creator_id),
        title = Value(title),
        description = Value(description),
        type = Value(type),
        priority = Value(priority);
  static Insertable<Ticket> custom({
    Expression<int>? id,
    Expression<int>? creator_id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? type,
    Expression<int>? priority,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (creator_id != null) 'creator_id': creator_id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (type != null) 'type': type,
      if (priority != null) 'priority': priority,
    });
  }

  TicketsCompanion copyWith(
      {Value<int>? id,
      Value<int>? creator_id,
      Value<String>? title,
      Value<String>? description,
      Value<int>? type,
      Value<int>? priority}) {
    return TicketsCompanion(
      id: id ?? this.id,
      creator_id: creator_id ?? this.creator_id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      priority: priority ?? this.priority,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (creator_id.present) {
      map['creator_id'] = Variable<int>(creator_id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TicketsCompanion(')
          ..write('id: $id, ')
          ..write('creator_id: $creator_id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('type: $type, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }
}

class $TicketsTable extends Tickets with TableInfo<$TicketsTable, Ticket> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TicketsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _creator_idMeta = const VerificationMeta('creator_id');
  @override
  late final GeneratedColumn<int?> creator_id = GeneratedColumn<int?>(
      'creator_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String?> description = GeneratedColumn<String?>(
      'description', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<int?> type = GeneratedColumn<int?>(
      'type', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _priorityMeta = const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int?> priority = GeneratedColumn<int?>(
      'priority', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, creator_id, title, description, type, priority];
  @override
  String get aliasedName => _alias ?? 'tickets';
  @override
  String get actualTableName => 'tickets';
  @override
  VerificationContext validateIntegrity(Insertable<Ticket> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('creator_id')) {
      context.handle(
          _creator_idMeta,
          creator_id.isAcceptableOrUnknown(
              data['creator_id']!, _creator_idMeta));
    } else if (isInserting) {
      context.missing(_creator_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ticket map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Ticket.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $TicketsTable createAlias(String alias) {
    return $TicketsTable(attachedDatabase, alias);
  }
}

abstract class _$InternDb extends GeneratedDatabase {
  _$InternDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UsersTable users = $UsersTable(this);
  late final $LoginsTable logins = $LoginsTable(this);
  late final $ChatsTable chats = $ChatsTable(this);
  late final $MessagesTable messages = $MessagesTable(this);
  late final $TicketsTable tickets = $TicketsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, logins, chats, messages, tickets];
}
