import 'package:flutter/material.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/services/database.dart';
import 'package:hello_world/views/index.dart';
import 'package:hello_world/views/login/create_username.dart';
import 'package:hello_world/widgets/loading.dart';
import 'package:provider/provider.dart';

class IndexWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: FirestoreService(uid: user.uid).userData,
      builder: (_context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        } else {
          if (snapshot.hasData) {
            return Index();
          } else {
            return CreateUsername();
          }
        }
      },
    );
  }
}
