import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syaahhospitalsystem/Screens/home_screen.dart';

class AnswersPage extends StatefulWidget {
  const AnswersPage({Key? key}) : super(key: key);

  @override
  State<AnswersPage> createState() => _AnswersPageState();
}

class _AnswersPageState extends State<AnswersPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  Map<String, String> userAnswers = {};
  Map<String, String> userNotes = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _retrieveData();
  }

  void _getCurrentUser() async {
    final User? user = _auth.currentUser;
    setState(() {
      _currentUser = user;
    });
  }

  void _retrieveData() async {
    if (_currentUser == null) {
      return;
    }

    final String userId = _currentUser!.uid;
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('answers')
            .doc(userId)
            .get();

    if (snapshot.exists) {
      final Map<String, dynamic> data = snapshot.data()!;
      setState(() {
        userAnswers = Map<String, String>.from(data['userAnswers']);
        userNotes = Map<String, String>.from(data['userNotes']);
        isLoading = false;
      });
    } else {
      print('No data found for the user.');
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget _buildCircularShape(
      {required Color color,
      required IconData icon,
      required String name,
      required String value}) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(1),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              icon,
              size: 40,
              color: color,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          name,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffc08806),
        title: Text(
          'Health Blog',
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
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/back.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCircularShape(
                              color: Colors.red,
                              icon: Icons.favorite,
                              name: 'Heart Rate',
                              value: '80 BPM'),
                          _buildCircularShape(
                              color: Colors.blue,
                              icon: Icons.waves,
                              name: 'Oxygen Level',
                              value: '98%'),
                          _buildCircularShape(
                              color: Colors.green,
                              icon: Icons.show_chart,
                              name: 'Blood Pressure',
                              value: '120/80 mmHg'),
                        ],
                      ),
                      SizedBox(height: 33),
                      Expanded(
                        child: ListView.separated(
                          itemCount: userAnswers.length,
                          separatorBuilder: (context, index) => Divider(
                            height: 7,
                            color: Colors.transparent,
                            thickness: 0,
                          ),
                          itemBuilder: (context, index) {
                            final questionId = userAnswers.keys.toList()[index];
                            final answer = userAnswers[questionId];
                            final notes = userNotes[questionId];

                            return Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              color: Colors.white,
                              child: ListTile(
                                title: Text(
                                  '  $questionId',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 7),
                                    Text(
                                      '  >> Answer: $answer',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 7),
                                    Text(
                                      '  >> Notes: $notes',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
