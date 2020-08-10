import 'package:flutter/material.dart';
import 'package:hello_world/models/convo.dart';
import 'package:hello_world/widgets/convo_item.dart';
import 'package:hello_world/widgets/message_search.dart';

class Index extends StatelessWidget {
  final Color _mainColor = Colors.blue;
  final Color _backgroundColor = Color(0xFF333842);
  final List<Convo> items = [
    Convo(
        id: 'convo1',
        avatar:
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
        username: '@tonystark23',
        message: 'Hello how you doing?',
        timestamp: 'Now'),
    Convo(
        id: 'convo2',
        avatar:
            'https://images.unsplash.com/photo-1537815749002-de6a533c64db?ixlib=rb-1.2.1&auto=format&fit=crop&w=545&q=80',
        username: '@doggolovr104',
        message: 'I tried to call you today',
        timestamp: 'Yesterday')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _mainColor,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/me.png'),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/myaccount');
              },
            ),
          ),
        ),
        title: Text(
          'Hello world',
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'Lobster',
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person_add,
              semanticLabel: 'Add friend',
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new_chat');
        },
        backgroundColor: _mainColor,
        child: Icon(
          Icons.chat_bubble,
          color: Colors.white,
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.all(8.0),
            child: MessageSearch(),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Messages',
              style: TextStyle(fontSize: 16.0, color: Colors.blue),
            ),
          ),
          Container(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ConvoItem(
                  convo: items[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
