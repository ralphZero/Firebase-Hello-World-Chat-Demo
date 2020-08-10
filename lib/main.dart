import 'package:flutter/material.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/services/auth.dart';
import 'package:hello_world/views/index.dart';
import 'package:hello_world/views/login/create_username.dart';
import 'package:hello_world/views/login/login.dart';
import 'package:hello_world/views/login/loginwithemail.dart';
import 'package:hello_world/views/login/registerwithemail.dart';
import 'package:hello_world/views/my_account.dart';
import 'package:hello_world/views/new_chat.dart';
import 'package:hello_world/views/search.dart';
import 'package:hello_world/views/show.dart';
import 'package:hello_world/views/wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _routes = {
      '/login': (context) => Login(),
      '/loginemail': (context) => LoginEmail(),
      '/registeremail': (context) => RegisterEmail(),
      '/create_username': (context) => CreateUsername(),
      '/index': (context) => Index(),
      '/show': (context) => Show(),
      '/myaccount': (context) => MyAccount(),
      '/search': (context) => Search(),
      '/new_chat': (context) => NewChat()
    };

    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: _routes,
        home: Wrapper(),
      ),
    );
  }
}
