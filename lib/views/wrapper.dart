import 'package:flutter/material.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/views/index_wrapper.dart';
import 'package:hello_world/views/login/login.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user != null) {
      return IndexWrapper();
    } else {
      return Login();
    }
  }
}
