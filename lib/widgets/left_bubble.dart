import 'package:flutter/material.dart';
import 'package:hello_world/models/message.dart';

class LeftBubble extends StatelessWidget {

  final Message message;
  LeftBubble({this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.lime,
          ),
          SizedBox(width: 10.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${message.sender} - ${message.timestamp}',
                style: TextStyle(
                  color: Colors.lime[500],
                  fontSize: 16.0
                ),
              ),
              Text(
                '${message.message}',
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 18.0
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}