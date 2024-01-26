import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syaahhospitalsystem/Screens/Models/user.dart';
import 'package:syaahhospitalsystem/Screens/home_screen.dart';

class Profilescreen extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profilescreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedhome = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("MobileApp_Users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedhome = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffc08806),
        title: Text(
          'Profile Page',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              },
              icon: const Icon(
                Icons.home,
                color: Colors.black,
              ))
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/back.jpg'), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    CircleAvatar(
                        radius: 111,
                        backgroundImage: loggedhome.gender == 'Male'
                            ? AssetImage(
                                'images/man.png') 
                            : AssetImage(
                                'images/woman.png') 
                        ),
                    SizedBox(height: 20),

                    Text(
                      '${loggedhome.firstName} ${loggedhome.lastName}',
                      style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),

                    Text(
                      '${loggedhome.email}',
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 10),

                    Text(
                      '${loggedhome.phoneNumber}',
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 10),

                    Text(
                      'Gender: ${loggedhome.gender}',
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 10),

                    Text(
                      'Birthday: ${loggedhome.birthDate}',
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 10),

                    Text(
                      '${loggedhome.address}',
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
