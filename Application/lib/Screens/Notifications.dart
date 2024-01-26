import 'package:flutter/material.dart';
import 'package:syaahhospitalsystem/Screens/home_screen.dart';

class NotificationItem {
  String title;
  String subtitle;

  NotificationItem({required this.title, required this.subtitle});
}

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Appointment Confirmation',
      subtitle:
          'Your appointment on [24-01-2024] at [9:00 AM] is confirmed. See you there!',
    ),
    NotificationItem(
      title: 'Reminder',
      subtitle: 'Your appointment is tomorrow at [12:00 AM]. See you then!',
    ),
    NotificationItem(
      title: 'Canceled',
      subtitle:
          'Your appointment at [10:00 AM] on [01-01-2024] has been canceled.',
    ),
    NotificationItem(
      title: 'Appointment Confirmation',
      subtitle:
          'Your appointment on [01-01-2024] at [10:00 AM] is confirmed. See you there!',
    ),
        NotificationItem(
      title: 'Results',
      subtitle:
          'Results available! Check the Results page in the application.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffc08806),
        title: Text(
          'Notifications',
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
          child: ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      notifications[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        notifications[index].subtitle,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Color(0xffc08806),
                    ),
                    onTap: () {
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
