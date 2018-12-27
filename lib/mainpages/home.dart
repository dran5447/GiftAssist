import 'package:flutter/material.dart';
import '../objectmodel.dart';
import '../sharedhelpers.dart';
import 'dart:math';

class HomeWidget extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeWidget>{
  static Random random = new Random();
  final List<Event> events = List<Event>.generate(
    15,
    (i) => Event(
      new DateTime(2018, 12, random.nextInt(31)),//.now(),
          'title $i',
          'A description for $i',
        ),
  );

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text
            (
              'Upcoming Events',
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          new Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(Helpers.informalDate(events[index].date) + ":" + Helpers.simplifyDate(events[index].date)),
                  title: Text(events[index].title),
                  onTap: () { /* TODO react to the tile being tapped */ },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}