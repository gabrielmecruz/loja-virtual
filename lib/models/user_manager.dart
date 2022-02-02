import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual/helpers/firebase_errors.dart';
import 'package:loja_virtual/models/user_app.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  User? firebaseUser;

  final FirebaseAuth auth = FirebaseAuth.instance;
  bool _loading = false;
  bool get loading => _loading;

  Future<void> signIn(
      {required UserApp userApp, Function? onFail, Function? onSuccess}) async {
    loading = true;

    try {
      UserCredential userCredential = await auth
          .signInWithEmailAndPassword(
              email: userApp.email, password: userApp.password)
          .timeout(const Duration(seconds: 10));

      firebaseUser = userCredential.user;
      onSuccess!();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      onFail!(getErrorString(e.code));
    }
    loading = false;
  }

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> _loadCurrentUser() async {
    /*Deprecated FirebaseUser*/
    final User? currentUser = await auth.currentUser;
    if (currentUser != null) {
      firebaseUser = currentUser;
      print(firebaseUser!.uid);
    }
    notifyListeners();
  }
}
