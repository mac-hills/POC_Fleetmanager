// methods for signing in, signing out and creating users with firebase auth
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  //instantiate a instance of firebase authentication to be able to use the service
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // get the current user (if available) from firebase authentication
  User? get currentUser => _firebaseAuth.currentUser;

  // a stream to access the sate changes of the authentication service
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // method for signing in with e-mail and password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // method for signing in users as fleetmanager users -> used in user_manager_service.dart
  Future<User?> signInWithEmailAndPasswordForUserManager({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential authResult =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return authResult.user;
    } catch (e) {
      print('Authentication error: $e');
      return null;
    }
  }

  // method for creating a new user with e-mail and password
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // method for signing out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
