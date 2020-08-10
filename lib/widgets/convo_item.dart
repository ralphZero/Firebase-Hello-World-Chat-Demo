import 'package:flutter/material.dart';
import 'package:hello_world/models/convo.dart';
import 'package:hello_world/views/show.dart';

class ConvoItem extends StatelessWidget {

  final Convo convo;
  ConvoItem({this.convo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blueAccent,
        backgroundImage: NetworkImage('${convo.avatar}'),
      ),
      title: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '${convo.username}',
              style: TextStyle(
                color: Colors.grey[100],
                fontSize: 18.0,
              ),
            ),
          ),
          Text(
            '${convo.timestamp}',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 12.0,
            ),
          ),
        ],
      ),
      subtitle: Text(
        '${convo.message}',
        style: TextStyle(
          color: Colors.grey[500],
          fontSize: 16.0,
        ),
      ),
      onTap: (){
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => Show(convo: this.convo,)
          ),
        );
      },
    );
  }
}