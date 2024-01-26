import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syaahhospitalsystem/Screens/home_screen.dart';

class Question {
  final String id;
  final String text;
  String notes;

  Question(this.id, this.text, {this.notes = ''});
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Question> questions = [
    Question('Have Diabetes?', 'Q1: Do you have diabetes?'),
    Question('Have Blood Pressure?', 'Q2: Do you have high blood pressure?'),
    Question('Have Heart?', 'Q3: Do you have any heart conditions?'),
    Question('Have Chronic Diseases?',
        'Q4: Do you suffer from any chronic diseases?'),
    Question('Take Medicines?', 'Q5: Do you take any medicines?'),
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _currentUser;

  Map<String, String> userAnswers = {};
  Map<String, String> userNotes = {};

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  void _getCurrentUser() async {
    final User? user = _auth.currentUser;
    setState(() {
      _currentUser = user;
    });
  }

  void _saveAnswer(String questionId, String answer) {
    setState(() {
      userAnswers[questionId] = answer;
    });
  }

  void _saveNotes(String questionId, String notes) {
    setState(() {
      userNotes[questionId] = notes;
    });
  }

  void _submitAnswers() {
    if (_currentUser == null) {
      return; 
    }

    final String userId = _currentUser!.uid;
    final CollectionReference answersRef = _firestore.collection('answers');

    answersRef.doc(userId).set({
      'userAnswers': userAnswers,
      'userNotes': userNotes,
    }).then((value) {
      print('Answers and notes submitted successfully!');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }).catchError((error) {
      print('Failed to submit answers and notes: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffc08806),
        title: Text(
          'Survey Page',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/back.jpg'), fit: BoxFit.cover)),
        child: ListView(
          children: [
            for (var question in questions)
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    title: Text(
                      question.text,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    subtitle: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 25,
                        ),
                        Radio(
                          value: 'Yes',
                          groupValue: userAnswers[question.id],
                          onChanged: (value) {
                            _saveAnswer(question.id, value.toString());
                          },
                          activeColor:
                              Colors.white, 
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors
                                  .white; 
                            } else {
                              return Colors
                                  .white; 
                            }
                          }),
                        ),
                        Text(
                          'Yes',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        Radio(
                          value: 'No',
                          groupValue: userAnswers[question.id],
                          onChanged: (value) {
                            _saveAnswer(question.id, value.toString());
                          },
                          activeColor:
                              Colors.white, 
                          fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.selected)) {
                              return Colors
                                  .white; 
                            } else {
                              return Colors
                                  .white; 
                            }
                          }),
                        ),
                        Text(
                          'No',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      decoration: InputDecoration(
                          labelText:
                              'If yes, List the medications you are taking.',
                          labelStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      onChanged: (value) {
                        _saveNotes(question.id, value);
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: _submitAnswers,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Submit',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        style: ElevatedButton.styleFrom(primary: Color(0xffc08806)),
      ),
    );
  }
}
