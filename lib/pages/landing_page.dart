import 'package:flutter/material.dart';
import 'package:note_ninja/pages/sign_up_page.dart';
import '../main.dart';

class LandingPage extends StatelessWidget {
  const LandingPage();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const LandingScreen(),
        '/sign_up': (context) => const SignUpScreen(),
        '/welcome': (context) => GlobalApp(),
      },
    );
  }
}

class LandingScreen extends StatelessWidget {
  const LandingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Note Ninja'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/welcome');
              },
              child: Text('Continue as Guest'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up');
              },
              child: Text('Proceed to Sign In'),
            ),
          ],
        ),
      ),
    );
  }
//Landing Page Background
}
