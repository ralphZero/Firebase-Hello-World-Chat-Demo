import 'package:flutter/material.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/widgets/user_item.dart';

class Search extends StatelessWidget {
  final Color _backgroundColor = Color(0xFF333842);

  final List<User> items = [
    User(
        avatar:
            'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80',
        username: '@tonystark23'),
    User(
        avatar:
            'https://images.unsplash.com/photo-1537815749002-de6a533c64db?ixlib=rb-1.2.1&auto=format&fit=crop&w=545&q=80',
        username: '@doggolovr104'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        title: Text(
          'Search',
          style: TextStyle(
            fontSize: 24.0,
            fontFamily: 'Lobster',
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(25.0,25.0,25.0,0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Connect with friends.\nExpand your world.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontFamily: 'Lobster',
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30.0,
            ),
            TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: 'Search by username',
                hintStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                      color: Colors.black26,
                    )),
                fillColor: Colors.black26,
                filled: true,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return UserItem(item: items[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

