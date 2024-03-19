import 'package:fleetmanager/components/app_bar_view.dart';
import 'package:fleetmanager/resources/app_theme.dart';
import 'package:fleetmanager/services/theme_provider_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fleetmanager/services/authentication_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';

  // isLogin will be used to check if the page is the login page or the register page
  bool isLogin = true;

  // controllers for email and password
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // methods for signing in and creating a new user
  // sign in method
  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  // create user method
  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  // Widgets that will be used in the Scaffold method of the build override to create a UI
  Widget _title() {
    return Text(isLogin ? 'Log in' : 'Register');
  }

  // Widget for creating an input field
  Widget _entryField(
    String title,
    TextEditingController controller,
    bool isPassword,
    Color loginThemeColor,
  ) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(
          color: Colors.white, // Set the label text color
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white, // Set the underline color
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white, // Set the underline color when focused
          ),
        ),
      ),
      obscureText: isPassword,
      style: const TextStyle(
        color: Colors.white, // Set the input text and cursor color
      ),
      cursorColor: Colors.white, // Set the cursor color
    );
  }

  Widget _errorMessage() {
    return Text(
      errorMessage == '' ? '' : 'Oops... ? $errorMessage',
      style: const TextStyle(
        fontSize: 18,
        color: Colors.red,
      ),
    );
  }

  Widget _submitButton(Color buttonColor) {
    return ElevatedButton(
      onPressed:
          // check if it is currently the login page, if so sign in, else create a new user
          isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      // the text on the button will also change depending on if it is the login page or not
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor, // Set the background color of the button
      ),
      child: Text(
        isLogin ? 'Log in' : 'Register',
        style: const TextStyle(
          fontSize: 22,
          color: Colors.white,
        ),
      ),
    );
  }

  // button to change the state of this page to login or register
  Widget _loginOrRegisterButton(Color color) {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(
        isLogin ? 'Register instead' : 'Log in instead',
        style: TextStyle(
          fontSize: 22,
          color: color,
        ),
      ),
    );
  }

  // Build the login/register page UI
  @override
  Widget build(BuildContext context) {
    String title = isLogin ? 'Log in' : 'Register';
    // Theme color settings
    final themeProvider = Provider.of<ThemeProvider>(context);
    final textColor = themeProvider.isDarkMode ? Colors.white : Colors.white;
    final buttonColor = themeProvider.isDarkMode
        ? AppTheme.darkTheme.primaryColor
        : AppTheme.lightTheme.primaryColor;
    // UI configuration
    return Scaffold(
      // build appbar without the menu on the login page
      appBar: buildAppBar(context, title, showMenu: false),
      body: Stack(
        children: <Widget>[
          // Background image
          Image.asset(
            'lib/resources/assets/images/truck01.PNG',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            // Overlay for login/register UI
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.4),
          ),
          Center(
            // Center the login/register UI
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                // Column section settings
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                // Column section components
                children: <Widget>[
                  Text(
                    isLogin
                        ? 'Welcome to fleet manager!'
                        : 'Welcome to fleet manager!',
                    style: TextStyle(
                      fontSize: 22,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    isLogin
                        ? 'Please log in'
                        : 'Please register to gain access',
                    style: TextStyle(
                      fontSize: 22,
                      color: textColor,
                    ),
                  ),
                  // Input field with label and controller settings for e-mail
                  _entryField('email', _emailController, false, Colors.white),
                  // Input field with label and controller settings for password
                  _entryField(
                      'password', _passwordController, true, Colors.white),
                  // Placeholder for displaying errors
                  _errorMessage(),
                  // Button for forwarding login/registration
                  _submitButton(buttonColor),
                  // Button for changing from login to registration and vice versa
                  _loginOrRegisterButton(textColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
