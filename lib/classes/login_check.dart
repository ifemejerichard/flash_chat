import 'package:firebase_auth/firebase_auth.dart';

class loginChecker {

  final FirebaseAuth _auth = FirebaseAuth.instance; // firebase auth object

  Future<String> checker () async{
    if (_auth.currentUser == null) {
      return '/';
    }
    else {
      return '/chatscreen';
    }
  }
}