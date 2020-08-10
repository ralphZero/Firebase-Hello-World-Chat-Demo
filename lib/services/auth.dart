import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:hello_world/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign up with email & password
  Future signUp(String email, String password) async {
    var map = Map();
    map["userId"] = null;
    map["errorCode"] = null;
    map["exception"] = null;
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      map["userId"] = result.user.uid;
    } on PlatformException catch (e) {
      map["errorCode"] = e.code;
    } on Exception catch (e) {
      map["exception"] = e.toString();
    }
    print("Map is-->" + map.toString());
    return map;
  }

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //sign in with email & password
  Future signIn(String email, String password) async {
    var map = Map();
    map["userId"] = null;
    map["errorCode"] = null;
    map["exception"] = null;
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      map["userId"] = result.user.uid;
      User curr = _userFromFirebaseUser(result.user);
      print("USER-->" + curr.toString());
    } on PlatformException catch (e) {
      map["errorCode"] = e.code;
    } on Exception catch (e) {
      map["exception"] = e.toString();
    }
    return map;
  }

  //log out
  Future logOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with google

  //sign up with google

}
