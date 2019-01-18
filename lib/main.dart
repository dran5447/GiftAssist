import 'package:flutter/material.dart';
import 'mainpages/people.dart';
import 'mainpages/home.dart';
import 'mainpages/notifications.dart';
import 'mainpages/settings.dart';
import 'shared/sharedhelpers.dart';
import 'shared/storage.dart';

import 'dart:io';
import 'shared/objectmodel.dart';
import 'package:flutter/foundation.dart';

void main() {
  //Run app
  runApp(MaterialApp(
    theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Helpers.primary,
        unselectedWidgetColor: Colors.grey.shade200,
        accentColor: Helpers.primary,
        bottomAppBarColor: Color.fromARGB(255, 0, 0, 0)
      ),
      home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  DataStorage storage;

  Future<File> writeData(String item) async{
    await storage.writeCounter(item);
  }
  Future<List<Idea>> readData() async{
    var result = await storage.readCounter();
    debugPrint(result.toString());
  }

  @override
  Widget build(BuildContext context) {
    storage = DataStorage();
    writeData("1").then((File file) {
       writeData("2").then((File file) {
           writeData("3").then((File file) {
            readData();
          });
        });
    });

    return Scaffold(
      body: MainPage(storage: storage),
    );
  }
}

class MainPage extends StatefulWidget {   
  final DataStorage storage;

  MainPage({Key key, @required this.storage}) : super(key: key);

  @override
  _MainState createState() =>_MainState();
}

class _MainState extends State<MainPage>{
  int _selectedIndex = 0;
  final List<Widget> _children = [
    HomeWidget(),
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
            icon: Icon(Icons.home, color: Helpers.primary), 
            title: Text(
              'Home',
              style: new TextStyle(
                color: Helpers.primary,
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Helpers.primary),
            title: Text(
              'People',
              style: new TextStyle(
                color: Helpers.primary,
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Helpers.primary,),
            title: Text(
              'Notifications',
              style: new TextStyle(
                color: Helpers.primary,
              ),
            )
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Helpers.primary,),
            title: Text(
              'Settings',
              style: new TextStyle(
                color: Helpers.primary,
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
