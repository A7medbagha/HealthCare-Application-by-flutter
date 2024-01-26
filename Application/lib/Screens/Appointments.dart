import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:syaahhospitalsystem/Screens/home_screen.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

class Appointments extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appointment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (context) => AppointmentProvider(),
        child: AppointmentPage(),
      ),
    );
  }
}

class AppointmentProvider extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';
}

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      context.read<AppointmentProvider>().selectedTime = picked.format(context);
    }
  }

  Future<void> _confirmAppointment() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final String userId = user.uid;

      final CollectionReference<Map<String, dynamic>> userAppointments =
          FirebaseFirestore.instance.collection('user_appointments');

      await userAppointments.add({
        'userId': userId,
        'selectedDate': context.read<AppointmentProvider>().selectedDate,
        'selectedTime': context.read<AppointmentProvider>().selectedTime,
      });

      print(
          'Appointment confirmed for ${DateFormat('yyyy-MM-dd').format(context.read<AppointmentProvider>().selectedDate)} '
          'at ${context.read<AppointmentProvider>().selectedTime}');
    } else {
      print('User not authenticated');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffc08806),
        title: Text(
          'Appointment',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: TableCalendar(
                  firstDay: DateTime.now(),
                  lastDay: DateTime.now().add(Duration(days: 365)),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  selectedDayPredicate: (day) {
                    return isSameDay(
                        context.read<AppointmentProvider>().selectedDate, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(
                      () {
                        context.read<AppointmentProvider>().selectedDate =
                            selectedDay;
                        _focusedDay =
                            focusedDay; 
                      },
                    );
                  },
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    outsideDaysVisible: false, 
                    weekendTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    outsideTextStyle: TextStyle(
                      color: Colors.black
                          .withOpacity(1), 
                    ),
                   
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffc08806),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () => _selectTime(context),
                child: Text(
                  'Select Time',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffc08806),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () async {
                  await _confirmAppointment();
                 
                  setState(() {});
                },
                child: Text(
                  'Confirm Appointment',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              _buildAppointmentsList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentsList() {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final String userId = user.uid;

      return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('user_appointments')
            .where('userId', isEqualTo: userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          final appointments = snapshot.data!.docs;

          return Expanded(
            child: ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment =
                    appointments[index].data() as Map<String, dynamic>;

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    title: Text(
                      'Appointment: ${DateFormat('yyyy-MM-dd').format(appointment['selectedDate'].toDate())} '
                      'at ${appointment['selectedTime']}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                   
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                          onPressed: () =>
                              _editAppointment(appointments[index].id),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                          onPressed: () =>
                              _deleteAppointment(appointments[index].id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    } else {
      return Text('User not authenticated');
    }
  }

  Future<void> _deleteAppointment(String documentId) async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      
      final CollectionReference<Map<String, dynamic>> userAppointments =
          FirebaseFirestore.instance.collection('user_appointments');

 
      await userAppointments.doc(documentId).delete();

      print('Appointment deleted');
    } else {
      print('User not authenticated');
    }
  }

  void _editAppointment(String documentId) {

    print('Edit appointment with document ID: $documentId');
  }
}
