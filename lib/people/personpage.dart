import 'package:flutter/material.dart';
import '../shared/sharedhelpers.dart';
import '../events/events_ideas_treeview.dart';
import '../shared/floatingAdd.dart';
import '../model/idea.dart';
import '../model/event.dart';

class PersonPage extends StatefulWidget {
  final String personName;
  
  PersonPage({Key key, this.personName}) : super(key: key);

  @override
  _IdeasState createState() => _IdeasState(personName: personName);
}

class _IdeasState extends State<PersonPage> with SingleTickerProviderStateMixin {
  final String personName;
  
  _IdeasState({Key key, this.personName});

  final List<Idea> ideas = Helpers.getTempIdeasList1();
  final List<Event> events = Helpers.getTempEventsList();

  TabController _tabController;
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Events'),
    Tab(text: 'Ideas'),
    Tab(text: 'Archive'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }



  @override
  Widget build(BuildContext context) {
    var header = Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 30.0, left:50.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).unselectedWidgetColor,
              child: Text(Helpers.getInitials(widget.personName)),
              minRadius: 50,
            ),
          ),
          Text
          (
            widget.personName,
            style: Theme.of(context).textTheme.headline.copyWith(color: Colors.white),
          ),
        ],
      );
      
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0), // TODO way to compute height of subwidget?
        child: AppBar(
          flexibleSpace: SafeArea(
            child: header,
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: myTabs,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Flex( direction: Axis.vertical, children: <Widget>[
            EventIdeasTreeWidget(events: events)
          ],),
          Icon(Icons.card_giftcard),
          Icon(Icons.history),
        ],
      ),
      floatingActionButton: FABSpeedDial(),
    );
  }
}