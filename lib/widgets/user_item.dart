import 'package:flutter/material.dart';
import 'package:hello_world/models/user.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    Key key,
    @required this.item,
  }) : super(key: key);

  final User item;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
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
          SizedBox(
            width: 10.0,
          ),
          RaisedButton(
            onPressed: () {
              print('connect');
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
            ),
            color: Colors.blue[600],
            textColor: Colors.white,
            child: Text('Connect'),
          ),
        ],
      ),
    );
  }
}
