import 'package:flutter/material.dart';
import 'package:hello_world/models/convo.dart';
import 'package:hello_world/models/message.dart';
import 'package:hello_world/widgets/left_bubble.dart';
import 'package:hello_world/widgets/right_bubble.dart';

class Show extends StatefulWidget {
  final Convo convo;
  Show({this.convo});

  @override
  _ShowState createState() => _ShowState(convo);
}

class _ShowState extends State<Show> {
  Convo convo;
  List<Message> messageList;

  _ShowState(Convo conversation) {
    convo = conversation;
    messageList = [
      Message(
          message: 'Hello my bro!',
          convoId: convo.id,
          sender: convo.username,
          timestamp: 'yesterday'),
      Message(
          message: 'Hi how you doing',
          convoId: convo.id,
          sender: '@me',
          timestamp: '15:09'),
      Message(
          message: 'I saw you today.',
          convoId: convo.id,
          sender: convo.username,
          timestamp: 'now'),
    ].reversed.toList();
  }

  final Color _mainColor = Colors.blue;
  final Color _backgroundColor = Color(0xFF333842);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _mainColor,
        titleSpacing: 0.0,
        leading: null,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.blueAccent,
              backgroundImage: NetworkImage(
                '${widget.convo.avatar}',
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              '${widget.convo.username}',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: messageList.length,
              itemBuilder: (context, index) {
                String senderId = messageList[index].sender;
                if (senderId == '@me') {
                  return RightBubble(
                    message: messageList[index],
                  );
                } else {
                  return LeftBubble(
                    message: messageList[index],
                  );
                }
              },
              reverse: true,
            ),
          ),
          Container(
            color: Color(0xFF282C34),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.attach_file,
                    color: Colors.grey[500],
                  ),
                  onPressed: () {
                    print('attachment');
                  },
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'What\'s on your mind?',
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(color: Colors.grey[300], fontSize: 18.0),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    print('send');
                  },
                  child: Text(
                    'send'.toUpperCase(),
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
