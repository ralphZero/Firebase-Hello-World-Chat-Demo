import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/models/user.dart';
import 'package:hello_world/services/auth.dart';
import 'package:hello_world/services/database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class CreateUsername extends StatefulWidget {
  @override
  _CreateUsernameState createState() => _CreateUsernameState();
}

class _CreateUsernameState extends State<CreateUsername>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final Color _backgroundColor = Color(0xFF333842);
  final _usernameController = TextEditingController();
  User user;
  String email, password;
  bool _inAsyncCall = false;
  bool _isUsernameTaken = false;
  bool _canContinue = false;
  Map args = {};

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        elevation: 0.0,
      ),
      body: Builder(
        builder: (_context) => SafeArea(
          child: ModalProgressHUD(
            opacity: 0.7,
            progressIndicator: CircularProgressIndicator(),
            color: _backgroundColor,
            inAsyncCall: _inAsyncCall,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'One last step...',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontFamily: 'Lobster'),
                      ),
                      Text(
                        'Choose a cool username',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 22.0,
                        ),
                      ),
                    ],
                  ),
                  buildUsernameForm(_context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUsernameForm(BuildContext _context) {
    _formKey.currentState?.validate();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.grey[300],
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: 'Username',
              hintStyle: TextStyle(
                color: Colors.grey[400],
              ),
              fillColor: Colors.grey[400],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[400],
                  width: 2,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.grey[400],
              ),
            ),
            controller: _usernameController,
            validator: (value) {
              if (value.isEmpty) return 'This field cannot be empty.';
              if (_isUsernameTaken) {
                _isUsernameTaken = false;
                return 'Username already taken';
              }
              if (value.length <= 3) {
                return 'Username should be at least 4 characters';
              }
              return null;
            },
          ),
          SizedBox(
            height: 15.0,
          ),
          RaisedButton(
            color: Colors.lime,
            padding: EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'getting started'.toUpperCase(),
                style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // dismiss keyboard during async call
                FocusScope.of(context).requestFocus(new FocusNode());
                // start the modal progress HUD
                setState(() {
                  _inAsyncCall = true;
                });
                checkUsername(_usernameController.text, _context);
              }
            },
          ),
          SizedBox(
            height: 15.0,
          ),
          FlatButton(
            onPressed: () {
              AuthService().logOut();
            },
            padding: EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'or sign out'.toUpperCase(),
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void checkUsername(String username, BuildContext m_context) {
    FirestoreService().checkUsername(username).then((value) {
      setState(() {
        if (value.documents.length != 0) {
          _isUsernameTaken = true;
          _canContinue = false;
        } else {
          _canContinue = true;
        }
      });
      _inAsyncCall = false;
    });
    if (_canContinue) {
      FirestoreService(uid: user.uid)
          .updateUserData("", username, "Hello world")
          .then((value) {
        Navigator.pushReplacementNamed(m_context, '/index');
      });
    }
  }
}
