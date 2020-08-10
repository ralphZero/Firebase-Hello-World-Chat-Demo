import 'package:flutter/material.dart';
import 'package:hello_world/services/auth.dart';

class MyAccount extends StatelessWidget {
  final Color _backgroundColor = Color(0xFF333842);
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Builder(
          builder: (_context) => Scaffold(
        backgroundColor: _backgroundColor,
        appBar: AppBar(
          backgroundColor: _backgroundColor,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'My account',
            style: TextStyle(
              fontSize: 24.0,
              fontFamily: 'Lobster',
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 120.0,
                        width: 120.0,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/me.png'),
                          backgroundColor: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '@username',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'This is a dummy status just\n for fun and primarily for wasting time.',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                color: Colors.white,
                height: 30.0,
                indent: 25.0,
                endIndent: 25.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                title: Text(
                  'Account',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                subtitle: Text(
                  'Change profile, security and privacy settings',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14.0,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                title: Text(
                  'Preferences',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                subtitle: Text(
                  'Change preferences settings',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14.0,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.help,
                  color: Colors.white,
                ),
                title: Text(
                  'Help',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                subtitle: Text(
                  'FAQ, contact us and privacy policy.',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14.0,
                  ),
                ),
              ),
              Divider(
                color: Colors.white,
                height: 10.0,
                indent: 25.0,
                endIndent: 25.0,
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.red[600],
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.red[600],
                    fontSize: 18.0,
                  ),
                ),
                onTap: () async{
                  await _auth.logOut();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
