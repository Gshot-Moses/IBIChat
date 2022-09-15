import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:go_router/go_router.dart';
import 'package:play_flutter/state/app_state.dart';
import 'components.dart';

class UserTile extends StatelessWidget {
  final user;

  UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AppState>(context, listen: false);
    return InkWell(
      onTap: () {
        List<int> members = [state.current_user!.id, user.id];
        var chat = state.getChatFromMembers(members);
        if (chat != null)
          state.goToConverstationPage(user.id, chat.id);
        else state.goToConverstationPage(user.id, -1);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoundedImage(user.first_name),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(user.first_name, style: const TextStyle(fontSize: 15)),
                    const SizedBox(height: 5),
                    Text(user.title, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                    //ListTile(
                    //  title: Text(user.first_name, style: TextStyle(fontSize: 14)),
                    //  subtitle: Text(user.title, style: TextStyle(fontSize: 13)),
                    //),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 0),
        ],
      ),
    );
  }
}
