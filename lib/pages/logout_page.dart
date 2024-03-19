import 'package:fleetmanager/components/app_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleetmanager/services/authentication_service.dart';

class LogOutPage extends StatefulWidget {
  const LogOutPage({Key? key}) : super(key: key);

  @override
  _LogOutPageState createState() => _LogOutPageState();
}

class _LogOutPageState extends State<LogOutPage> {
  bool isLoggedOut = false;
  bool isLogOutButtonVisible = true;

  // Get user data
  final User? user = Auth().currentUser;

  // method for signing out
  Future<void> signOut() async {
    await Auth().signOut();
    setState(() {
      // toggle destination of back arrow  and the corresponding text values
      isLoggedOut = true;
      // toggle vissibility of log out button
      isLogOutButtonVisible = false;
    });
  }

  // Widgets that will be used in the Scaffold method of the build override to create a UI
  Widget _title() {
    return Text(isLoggedOut ? 'Go to the log in page' : 'Go back');
  }

  Widget _userUid() {
    String userName = user?.email ?? 'User email';
    return Text(
      isLoggedOut ? '$userName (Logged Out)' : userName,
      style: TextStyle(
        fontSize: 22,
        color: isLoggedOut ? Colors.white70 : Colors.green,
      ),
    );
  }

  Widget _signOutButton() {
    return Visibility(
      // Set visibility
      visible: isLogOutButtonVisible,
      child: ElevatedButton(
        onPressed: () {
          signOut();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
        ),
        child: const Text(
          'Log out',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Build the homepage UI
  @override
  Widget build(BuildContext context) {
    String title = isLoggedOut ? 'Go to the log in page' : 'Go back';
    return Scaffold(
      // Menu bar at the top of the homepage
      appBar: buildAppBar(context, title, showMenu: !isLoggedOut),
      // content body for the homepage
      body: Stack(
        children: <Widget>[
          // Background image
          Image.asset(
            'lib/resources/assets/images/truck01.PNG',
            // Replace with your image path
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            // Overlay for page content
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.6), // Adjust opacity as needed
          ),
          Center(
            // Center the page content
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _userUid(),
                  _signOutButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
