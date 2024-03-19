import 'package:fleetmanager/components/app_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'wannesmachiels@gmail.com',
      queryParameters: {
        'subject': 'Feedback for FleetManager App',
        'body': 'Hello Wannes,',
      },
    );

    final String emailLaunchUriString = emailLaunchUri.toString();

    if (await canLaunch(emailLaunchUriString)) {
      await launch(emailLaunchUriString);
    } else {
      throw 'Could not launch email';
    }
  }

  // Function to show the creator information in a popup
  void _showCreatorInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: Colors.white.withOpacity(0.9),
          title: const Text('About the Creator'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'As a dedicated coding enthusiast '
                'I\'m currently studying to become a full-stack app developer. '
                'With a passion for creating user-friendly applications '
                'and exploring new technologies, '
                'my unwavering commitment to coding '
                'and app development is at the core of my journey.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              // Display the image (me.jpg)
              Container(
                width: 100, // Set the width as needed
                height: 100, // Set the height as needed
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // Adjust the border radius as desired
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: const Offset(0, 3), // Offset in the Y direction
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  // Same as the border radius above
                  child: Image.asset(
                    'lib/resources/assets/images/me.jpg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover, // Adjust the fit as needed
                  ),
                ),
              ),

              const SizedBox(height: 5),
              GestureDetector(
                onTap: _launchEmail,
                child: const Text(
                  'wannesmachiels@gmail.com',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, 'About'),
      body: Stack(
        children: <Widget>[
          // Background image
          Image.asset(
            'lib/resources/assets/images/truck01.PNG',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            color: Colors.black.withOpacity(0.6),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 50),
                const Text(
                  'FleetManager App',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Version: 1.0.0',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Description:\n\nThis application serves as a robust tool for '
                  'fleet managers to efficiently record vehicle reservations.\n'
                  'It empowers vehicle drivers to access their schedules. '
                  '\nAdditionally, it offers a user-friendly interface for '
                  'others to inquire about vehicle availability '
                  'and submit reservation requests to the fleet manager.',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 50),
                // Button to show the creator information
                ElevatedButton(
                  onPressed: () {
                    _showCreatorInfo(context); // Show the popup
                  },
                  child: const Text('About the Creator'),
                ),
                const SizedBox(height: 20),
                // Add the copyright icon and text
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.copyright, color: Colors.white),
                    Text(' 2023 - Wannes Machiels',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
