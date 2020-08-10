import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color _backgroundColor = Color(0xFF333842);
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Hello world',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 42.0,
                      fontFamily: 'Lobster'),
                ),
                CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
