import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User?> createAccount({required String fullName, required String email, required String password}) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);

      if(userCredential.user != null){
        userCredential.user!.updateDisplayName(fullName);
        return userCredential.user;
      } else {
        return null;
      }
    } catch(e) {
      return null;
    }
  }

  static Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch(e) {
      return null;
    }
  }

  static Future<bool> deleteAccount() async {
    try {
      await auth.currentUser?.delete();
      return true;
    } catch(e) {
      return false;
    }
  }

  static Future<bool> logout() async {
    try {
      await auth.signOut();
      return true;
    } catch(e) {
      return false;
    }
  }
}
