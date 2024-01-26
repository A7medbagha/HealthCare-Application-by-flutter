import 'package:flutter/material.dart';
import 'package:syaahhospitalsystem/Screens/login_screen.dart';
import 'package:syaahhospitalsystem/Screens/registration_screen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/back.jpg'), fit: BoxFit.cover)),
        child: Column(
          children: [
            SizedBox(
              height: 68,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                'images/delta.png',
                width: double.infinity,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 56,
            ),
            Center(
              child: Text(
                'Welcome to Fusion Hospital Management System',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                'Where Your Health is Our Priority',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 120,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                primary: Color(0xffc08806),
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistrationScreen(),
                  ),
                );
              },
              icon: Icon(Icons.arrow_forward, color: Colors.black),
              label: Text(
                'Sign Up',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildIconCircle(
                  Icons.phone,
                ),
                SizedBox(width: 20.0),
                buildIconCircle(Icons.help),
                SizedBox(width: 20.0),
                buildIconCircle(Icons.feedback),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIconCircle(IconData icon) {
    return CircleAvatar(
      radius: 30.0,
      backgroundColor: Color(0xffc08806),
      child: Icon(
        icon,
        color: Colors.black,
      ),
    );
  }
}
