import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:play_flutter/service/message_service.dart';
import 'package:play_flutter/service/ticket_service.dart';
import 'package:play_flutter/service/user_service.dart';
import 'package:provider/provider.dart';
import 'package:play_flutter/state/app_state.dart';
import 'package:play_flutter/service/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {

  static const PAGE_NAME = "login";

  static MaterialPage page() => MaterialPage(
    key: const ValueKey(PAGE_NAME),
    name: PAGE_NAME,
    child: LoginPage(),
  );

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  late TextEditingController _loginTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    super.initState();
    _loginTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  void displayDialog(BuildContext context) {
    /*return Container(
      width: 50,
      height: 50,
      child: Center(child: CircularProgressIndicator()),
    );*/
    
    showDialog(context : context, barrierDismissible : false,
        builder : (BuildContext inDialogContext) {
          return Dialog(
            child: Container(width: 100, height: 100, child: Center(child:CircularProgressIndicator())),
          );
        }
    );
  }

  Widget _loginBox(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
            child: _contentField(context),
          ),
        ],
      );
    }
    else {
      return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: 410,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        child: _contentField(context),
      );
    }
  }

  Widget _contentField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints.expand(width: 150, height: 150),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage("chef.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Identifiant", border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  controller: _loginTextController,
                  validator: (String? value) {},
                ),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Mot de passe",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.password),
                  ),
                  controller: _passwordTextController,
                  validator: (String? value) {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _loginButton(context),
        ],
      ),
    );
  }

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        var state = Provider.of<AppState>(context, listen: false);
        var user_service = Provider.of<UserService>(context, listen: false);
        var message_service = Provider.of<MessageService>(context, listen: false);
        var chat_provider = Provider.of<ChatsProvider>(context, listen: false);
        var ticket_service = Provider.of<TicketService>(context, listen: false);

        String loginText = _loginTextController.text;
        String passwordText = _passwordTextController.text;
        if (loginText == "") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Remplir le champs identifiant")));
          return;
        }
        if (passwordText == "") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Remplir le champs mot de passe")));
          return;
        }
        //displayDialog(context);
        var login = await user_service.login(loginText, passwordText);
        if (login == null) {
          _showSnackBar(context, "Connexion echouee");
          Navigator.pop(context);
          return;
        }
        var pref = await SharedPreferences.getInstance();
        await pref.setInt("user_id", login.user.id);
        await pref.setString("token", login.token);
        await user_service.saveLoginToCache(login);
        state.setLoginTokenAndCurrentUser(login.user.toUserModel(), login.token);
        var users = await user_service.getAllUsersFromApi();
        //print(users);
        if (users == null) {
          _showSnackBar(context, "Trouble de connectivite, Reessayez ulterieurement");
          Navigator.pop(context);
          return;
        }
        var chats = await message_service.getAllChatsFromApi(state.current_user!.id);
        if (chats == null) {
          _showSnackBar(context, "Trouble de connectivite, Reessayez ulterieurement");
          Navigator.pop(context);
          return;
        }
        var tickets = await ticket_service.getTicketsForUser(state.current_user!.id);
        if (tickets != null) {
          ticket_service.all_tickets.addAll(tickets);
        }
        print(ticket_service.all_tickets);
        state.setUserList(user_service.filterOutCurrentUserFromList(users, state.current_user!.id));
        state.setAllChats(message_service.mapChatsToName(chats.map((e) => e.toChatModel()).toList(),
            state.current_user!.id, state.userList));
        chat_provider.setChats(chats.map((e) => e.toChatModel()).toList());
        Navigator.of(context).pop();
        message_service.init();

        state.goToHomePage(true);

      },
      child: const Padding(padding: EdgeInsets.all(10), child: Text("Connexion")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: _loginBox(context),
      ),
    );
  }

  _showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
