import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fleetmanager/services/authentication_service.dart';
import 'package:fleetmanager/pages/home_page_admin.dart';
import 'package:fleetmanager/pages/home_page_drivers.dart';
import 'package:fleetmanager/pages/home_page_users.dart';
import 'package:fleetmanager/pages/login_register_page.dart';

// with this class the app can check which role a user has on login
// and then forward them to their role specific pages after login
class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          // These will be used to check the role of a user
          bool isAdmin = false;
          bool isDriver = false;
          // check if there's a user (then there will de data in the snapshot)
          if (snapshot.hasData) {
            // Get the User object from the snapshot
            final User user = snapshot.data as User;
            // check if the user is an admin, a driver or a regular user
            if (user.email != null) {
              if (user.email!.contains('admin')) {
                isAdmin = true;
              } else if (user.email!.contains('driver')) {
                isDriver = true;
              }
            }
            // navigate to the correct page depending on user role
            if (isAdmin) {
              // Navigate to the admin page
              return const HomePageAdmin();
            } else if (isDriver) {
              // Navigate to the driver page
              return const HomePageDrivers();
            } else {
              // navigate to regular user page
              return const HomePageUsers();
            }
            // if there's no user logged in (then the snapshot doesn't contain data) go to the loginpage
          } else {
            return const LoginPage();
          }
        });
  }
}
