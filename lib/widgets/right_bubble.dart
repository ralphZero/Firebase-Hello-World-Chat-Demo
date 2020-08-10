import 'package:flutter/material.dart';
import 'package:hello_world/models/message.dart';

class RightBubble extends StatelessWidget {

  final Message message;
  RightBubble({this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '${message.timestamp} - ${message.sender}',
                style: TextStyle(
                  color: Colors.blue[500],
                  fontSize: 16.0
                ),
              ),
              Text(
                '${message.message}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0
                ),
              )
            ],
          ),
          SizedBox(width: 10.0,),
          CircleAvatar(
            backgroundColor: Colors.blue,
          )
        ],
      ),
    );
  }
}