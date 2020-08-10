import 'package:flutter/material.dart';
import 'package:hello_world/models/user.dart';

class UserItemChat extends StatelessWidget {
  const UserItemChat({
    Key key,
    @required this.item,
  }) : super(key: key);

  final User item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.blue,
            backgroundImage: NetworkImage(item.avatar),
          ),
          SizedBox(width: 10.0,),
          Text(
            '${item.username}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
