import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:play_flutter/ui/components/components.dart';
import 'package:play_flutter/state/app_state.dart';

class UserListPage extends StatelessWidget {
  static const String PAGE_NAME = "users";

  UserListPage({Key? key}) : super(key: key);

  static MaterialPage page() => MaterialPage(child: UserListPage(), key: ValueKey(PAGE_NAME));

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AppState>(context, listen: false);
    print(state.current_user!.id);
    return Scaffold(
      appBar: AppBar(title: Text("Membres"), elevation: 0),
      body: UsersList(users: state.userList),
    );
  }
}
