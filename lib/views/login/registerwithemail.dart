import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hello_world/services/auth.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterEmail extends StatefulWidget {
  @override
  _RegisterEmailState createState() => _RegisterEmailState();
}

class _RegisterEmailState extends State<RegisterEmail>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final Color _backgroundColor = Color(0xFF333842);
  final _passwordController = TextEditingController();
  final _confirmationController = TextEditingController();
  final _emailController = TextEditingController();
  AnimationController _controller;
  bool _inAsyncCall = false;
  bool _isEmailInvalid = false;
  bool _isEmailTaken = false;
  bool _isPasswordInvalid = false;
  bool _canRegister = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmationController.dispose();
    _emailController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.isCompleted) {
      print("ANIM --->IS COMPLETED");
      Future.delayed(Duration(milliseconds: 1000), () {
        Navigator.popUntil(context, (route) => route.isFirst);
      });
    }

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
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                margin: EdgeInsets.only(top: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Welcome',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32.0,
                              fontFamily: 'Lobster'),
                        ),
                        Text(
                          'Sign up with your email',
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
                    buildRegisterForm(_context),
                  ],
                ),
              ),
            ),
            opacity: 0.7,
            color: _backgroundColor,
            progressIndicator: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Widget buildRegisterForm(BuildContext context) {
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
              if (value.isEmpty) {
                return 'This field cannot be empty.';
              }
              if (_isEmailInvalid) {
                _isEmailInvalid = false;
                return 'Email is invalid';
              }
              if (_isEmailTaken) {
                _isEmailTaken = false;
                return 'This email is already in use.';
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
              if (value.isEmpty) return 'This field cannot be empty.';
              if (_isPasswordInvalid) {
                _isPasswordInvalid = false;
                return "Password must be at least 6 characters";
              } else
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
              hintText: 'Confirm password',
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
            controller: _confirmationController,
            validator: (value) {
              if (value.isEmpty)
                return 'This field cannot be empty.';
              else if (value != _passwordController.text)
                return 'The password does not match';
              else
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
                'continue'.toUpperCase(),
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

                checkValues(
                    context, _emailController.text, _passwordController.text);
              }
            },
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
    AuthService _auth = AuthService();
    _auth.signUp(email, password).then((value) {
      Map map = value;
      setState(() {
        if (map["userId"] != null) {
          //the process is successful
          _canRegister = true;
        } else {
          _canRegister = false;
          if (map["errorCode"] != null) {
            //error code is not null
            if (map["errorCode"] == "ERROR_INVALID_EMAIL") {
              _isEmailInvalid = true;
            } else if (map["errorCode"] == "ERROR_EMAIL_ALREADY_IN_USE") {
              _isEmailTaken = true;
            } else if (map["errorCode"] == "ERROR_WEAK_PASSWORD") {
            } else {
              printMessage(context, map["errorCode"]);
            }
          } else {
            if (map["exception"] != null) {
              //other error not from Firebase
              printException(context, map["exception"]);
            }
          }
        }
        _inAsyncCall = false;
      });
      if (_canRegister) {
        showSuccessDialog();
      }
    });
  }

  Future showSuccessDialog() {
    return showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Material(
            child: Container(
              padding: EdgeInsets.all(20),
              color: _backgroundColor,
              child: lottieBuilder(),
            ),
          );
        });
  }

  Widget lottieBuilder() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        LottieBuilder.asset(
          'assets/success_check.json',
          controller: _controller,
          repeat: false,
          onLoaded: (composition) {
            _controller.duration = composition.duration;
            _controller.forward();
          },
        ),
        Text(
          'Your account has been created.',
          style: TextStyle(
              color: Colors.grey[300], fontSize: 28.0, fontFamily: 'Lobster'),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          'Please click the button below to go back to the login screen.',
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 18.0,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20.0,
        ),
        FlatButton(
          onPressed: () {
            //todo : pop back until initialroutes and pushname loginemail
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/loginemail', ModalRoute.withName('/login'));
          },
          padding: EdgeInsets.all(8.0),
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Go back to login'.toUpperCase(),
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[100],
              ),
            ),
          ),
        ),
      ],
    );
  }

  printMessage(BuildContext context, String code) {
    String message;
    switch (code) {
      case "ERROR_WRONG_PASSWORD":
        message = "Your password is wrong.";
        break;
      case "ERROR_USER_NOT_FOUND":
        message = "User with this email doesn't exist.";
        break;
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
