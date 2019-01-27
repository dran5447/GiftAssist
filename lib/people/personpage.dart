import 'package:flutter/material.dart';
import '../shared/sharedhelpers.dart';
import '../events/events_ideas_treeview.dart';
import '../shared/floatingAdd.dart';
import '../model/idea.dart';
import '../model/person.dart';
import '../model/event.dart';
import '../ideas/ideaslistbuilder.dart';

class PersonPage extends StatefulWidget {
  final Person person;
  
  PersonPage({Key key, this.person}) : super(key: key);

  @override
  _IdeasState createState() => _IdeasState(person: person);
}

class _IdeasState extends State<PersonPage> with SingleTickerProviderStateMixin {
  final Person person;
  
  _IdeasState({Key key, this.person});

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
              child: Text(Helpers.getInitials(widget.person.name)),
              minRadius: 50,
            ),
          ),
          Text
          (
            widget.person.name,
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
          Flex(direction: Axis.vertical, children: <Widget>[
            IdeasListBuilder(person: person)
          ],),
          Icon(Icons.history),
        ],
      ),
      floatingActionButton: FABSpeedDial(),
    );
  }
}