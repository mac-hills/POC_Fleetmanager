import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleetmanager/domain/fleetmanager_user.dart';
import 'package:fleetmanager/domain/user_roles_enum.dart';
import 'authentication_service.dart'; // Your Auth class

//seperate service for mapping authenticated users to fleetmanager users
class UserManager {
  final Auth _auth = Auth();

  // Sign in with email and password and create FleetmanagerUser
  Future<FleetmanagerUser?> signInAndCreateFleetmanagerUser({
    required String email,
    required String password,
  }) async {
    User? firebaseUser = await _auth.signInWithEmailAndPasswordForUserManager(email: email, password: password);

    if (firebaseUser != null) {
      return FleetmanagerUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        role: UserRole.guest,
      );
    } else {
      return null;
    }
  }

// Other user management methods...
}
