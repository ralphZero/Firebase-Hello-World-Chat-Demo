import 'package:flutter/material.dart';
import 'package:hello_world/services/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginEmail extends StatefulWidget {
  @override
  _LoginEmailState createState() => _LoginEmailState();
}

class _LoginEmailState extends State<LoginEmail> {
  final Color _backgroundColor = Color(0xFF333842);
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _inAsyncCall = false;
  bool _isInvalidEmail = false;
  bool _isEmailExists = false;
  bool _isInvalidPassword = false;
  //bool _canLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        elevation: 0.0,
      ),
      body: Builder(
        builder: (_context) => SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: _inAsyncCall,
            opacity: 0.7,
            color: _backgroundColor,
            progressIndicator: CircularProgressIndicator(),
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 50.0),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Welcome back',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32.0,
                              fontFamily: 'Lobster'),
                        ),
                        Text(
                          'Your world is waiting for you',
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 22.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    buildForm(_context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Form buildForm(BuildContext contextf) {
    _formKey.currentState?.validate();
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildOAuthColumn(),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.grey[300],
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: 'Email',
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
                Icons.email,
                color: Colors.grey[400],
              ),
            ),
            controller: _emailController,
            validator: (value) {
              if (value.isEmpty) return 'Field cannot be empty.';
              if (_isInvalidEmail) {
                _isInvalidEmail = false;
                return 'Incorrect email address';
              }
              if(_isEmailExists){
                _isEmailExists = false;
                return 'No account linked with this email';
              }
              return null;
            },
          ),
          SizedBox(
            height: 15.0,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            obscureText: true,
            style: TextStyle(
              color: Colors.grey[300],
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: 'Password',
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
                Icons.lock,
                color: Colors.grey[400],
              ),
            ),
            controller: _passwordController,
            validator: (value) {
              if (value.isEmpty) return 'Field cannot be empty.';
              if (_isInvalidPassword) {
                _isInvalidPassword = false;
                return 'Password is invalid';
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
                'login'.toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[700],
                ),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                FocusScope.of(context).requestFocus(new FocusNode());

                // start the modal progress HUD
                setState(() {
                  _inAsyncCall = true;
                });
                checkValues(contextf, _emailController.text, _passwordController.text);
              }
            },
          ),
          SizedBox(
            height: 15.0,
          ),
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/registeremail',
              );
            },
            padding: EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'no account? register'.toUpperCase(),
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

  Widget buildOAuthColumn() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                onPressed: () {},
                color: Color(0xFF3B5998),
                padding: EdgeInsets.all(5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'facebook'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: RaisedButton(
                onPressed: () {},
                color: Colors.grey[200],
                padding: EdgeInsets.all(5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'google'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[650],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Divider(
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'or'.toUpperCase(),
                  style: TextStyle(color: Colors.white30),
                ),
              ),
              Expanded(
                child: Divider(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  checkValues(BuildContext context, String email, String password) {
    AuthService _authService = AuthService();
    _authService.signIn(email, password).then((value) {
      Map map = value;
      setState(() {
        if(map["userId"]!=null){
          //login successful
          Navigator.pop(context);
        }else{
          if(map["errorCode"]!=null){
            if(map["errorCode"] == "ERROR_INVALID_EMAIL"){
              _isInvalidEmail = true;
            }else if(map["errorCode"] == "ERROR_WRONG_PASSWORD"){
              _isInvalidPassword = true;
            }else if(map["errorCode"] == "ERROR_USER_NOT_FOUND"){
              _isEmailExists = true;
            }else{
              printMessage(context, map["errorCode"]);
            }
          }else{
            printException(context, map["exception"]);
          }
        }
        _inAsyncCall = false;
      });
    });
  }

  printMessage(BuildContext context, String code) {
    String message = "";
    switch (code) {
      case "ERROR_USER_DISABLED":
        message = "User with this email has been disabled.";
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        message = "Too many requests. Try again later.";
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        message = "Signing in with Email and Password is not enabled.";
        break;
      default:
        message = "An unexpected error happened.";
        break;
    }

    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  printException(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
