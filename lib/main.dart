import 'package:flutter/material.dart';
import 'mainpages/people.dart';
import 'mainpages/home.dart';
import 'mainpages/events.dart';
import 'mainpages/notifications.dart';
import 'mainpages/settings.dart';
import 'sharedhelpers.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Color.fromARGB(255, 126, 71, 98),
        unselectedWidgetColor: Colors.grey.shade200,
        accentColor: Color.fromARGB(255, 126, 71, 98),
        bottomAppBarColor: Color.fromARGB(255, 0, 0, 0)
      ),
      home: MyApp(),
  ));
}
//color scheme:
  //burgundy - Color.fromARGB(255, 126, 71, 98),
  //grey - Color.fromARGB(255, 76, 66, 74),
  //dark teal - Color.fromARGB(255, 83, 116, 127), 
  //light teal - Color.fromARGB(255, 177, 197, 188),
  //old paper - Color.fromARGB(255, 249, 246, 228)

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {   
  MainPage({Key key}) : super(key: key);

  @override
  _MainState createState() =>_MainState();
}

class _MainState extends State<MainPage>{
  int _selectedIndex = 0;
  final List<Widget> _children = [
    HomeWidget(),
    EventWidget(),
    PeopleWidget(),
    NotificationWidget(),
    SettingsWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex], 
      bottomNavigationBar: BottomNavigationBar(
       items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color.fromARGB(255, 126, 71, 98),), 
            title: Text(
              'Home',
              style: new TextStyle(
                color: Color.fromARGB(255, 126, 71, 98),
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: Color.fromARGB(255, 126, 71, 98),),
            title: Text(
              'Events',
              style: new TextStyle(
                color: Color.fromARGB(255, 126, 71, 98),
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color.fromARGB(255, 126, 71, 98),),
            title: Text(
              'People',
              style: new TextStyle(
                color: Color.fromARGB(255, 126, 71, 98),
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Color.fromARGB(255, 126, 71, 98),),
            title: Text(
              'Notifications',
              style: new TextStyle(
                color: Color.fromARGB(255, 126, 71, 98),
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Color.fromARGB(255, 126, 71, 98),),
            title: Text(
              'Settings',
              style: new TextStyle(
                color: Color.fromARGB(255, 126, 71, 98),
              ),
            )
          ),
       ],
       currentIndex: _selectedIndex,
       onTap: _onItemTapped,
     ),
    );
  }

  void _onItemTapped(int index) {
   setState(() {
     _selectedIndex = index;
   });
 }
}
