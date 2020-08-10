import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hello_world/models/user.dart';

class FirestoreService {
  final String uid;
  final CollectionReference _users = Firestore.instance.collection("users");

  FirestoreService({this.uid});

  Future updateUserData(String avatar, String username, String bio) async {
    return await _users
        .document(uid)
        .setData({"avatar": avatar, "username": username, "bio": bio});
  }

  Future<DocumentSnapshot> doesUserDataExists() async {
    DocumentSnapshot snap = await _users.document(uid).get();
    return snap;
  }

  Future<QuerySnapshot> checkUsername(String username) async {
    return await _users.where('username', isEqualTo: username).getDocuments();
  }

  UserData _userDataFromDocumentSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      username: snapshot.data['username'],
      avatar: snapshot.data['avatar'],
      bio: snapshot.data['bio'],
    );
  }

  Stream<UserData> get userData {
    return _users.document(uid).snapshots().map(_userDataFromDocumentSnapshot);
  }
}
