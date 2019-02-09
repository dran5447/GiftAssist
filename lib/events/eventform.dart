import 'package:flutter/material.dart';
import '../model/event.dart';
import '../model/person.dart';
import 'package:uuid/uuid.dart';
import '../shared/datastore.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import '../shared/sharedhelpers.dart';

class EventForm extends StatefulWidget {
  final Person person;
  EventForm({Key key, this.person}) : super(key: key);

  @override
  EventFormState createState(){
    return EventFormState(selectedPerson: person);
  }
}

class EventFormState extends State<EventForm>{
  EventFormState({Key key, this.selectedPerson});

  final String emptyPeopleMessage = 'No people created';
  final _formKey = GlobalKey<FormState>();
  final uuid = new Uuid();
  bool autovalidate = false;
  TextEditingController titleFieldController = new TextEditingController();
  TextEditingController dateFieldController = new TextEditingController();
  TextEditingController descFieldController = new TextEditingController();
  Person selectedPerson;
  DateTime selectedDateTime;
  String selectedEventType;
  bool recurringBool = false;
  List<Person> people = new List<Person>();
  List<String> eventTypeOptions = new List<String>();

  getPeople() async{
    var peeps = await DBProvider.db.getAllPeople();

    // If passed a selectedPerson from previous screen, add to the people list
    // in order to pass first render without error
    if(selectedPerson!=null){
      people.add(selectedPerson);
    }
    
    setState(() {
      people = peeps;

      // If there are no initial selected people passed to the screen 
      // use first person from database of People if it contains data
      if(this.selectedPerson == null && peeps.length > 0){
        selectedPerson = peeps[0];
      }
    });
  }

  getEventTypes() {
    var eventTypes = Helpers.IconStringMap.keys.toList();

    selectedEventType = eventTypes.first;
    
    setState(() {
      eventTypeOptions = eventTypes;
    });
  }
  
  // Translate selected name from dropdown to Person from db
  // TODO this will fail if duplicate names exist (would need a
  // workaround like adding birthday to the end)
  Person getSelectedPersonByName(String searchName){
    for(Person p in people){
      if(p.name == searchName){
        return p;
      }
    }
    return null;
  }

  DateTime convertToDate(String input) {
    try 
    {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }    
  }

  @override
  void initState() {
    this.getPeople();
    this.getEventTypes();
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    Future _chooseDate(BuildContext context, String initialDateString) async {
      var now = new DateTime.now();
      var initialDate = convertToDate(initialDateString) ?? now;
      initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now) ? initialDate : now);

      var result = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: new DateTime(1900),
          lastDate: new DateTime(now.year+5));

      if (result == null) return;

      setState(() {
        dateFieldController.text = new DateFormat.yMd().format(result);
        selectedDateTime = result;
      });
    }
    
    return Form(
      key: _formKey,
      autovalidate: autovalidate,
      child: Column(
        children: <Widget>[
          //TODO optional picture for idea

          //Name field
          TextFormField(
            controller: titleFieldController,
            decoration: const InputDecoration(
              icon: Icon(Icons.card_giftcard),
              hintText: 'Event name',
              labelText: 'Title *',
            ),
            validator:  (value){
              if(value.isEmpty){
                return 'Please enter a value';
              }
            },
          ),
          //Date field
          new Row(children: <Widget>[
            new Expanded(
              child: new TextFormField(
              decoration: new InputDecoration(
                icon: const Icon(Icons.calendar_today),
                hintText: 'Enter event date or open picker',
                labelText: 'Date *',
              ),
              controller: dateFieldController,
              keyboardType: TextInputType.datetime,
            )),
            new IconButton(
                icon: Padding(
                  child: new Icon(Icons.event, size: 30),
                  padding: EdgeInsets.only(top: 10, left: 0),
                ),
                tooltip: 'Choose date',
                onPressed: (() {
                  _chooseDate(context, dateFieldController.text);
                }),
              ), 
          ]),
          //Person field
          new FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: 'Person *',
                  errorText: state.hasError ? state.errorText : null,
                ),
                isEmpty: selectedPerson == null,
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton<String>(
                    value: selectedPerson!= null ? selectedPerson.name : 
                                (people != null && people.length>0 ? people[0].name : emptyPeopleMessage),
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        selectedPerson = getSelectedPersonByName(newValue);
                        state.didChange(newValue);
                      });
                    },
                    items: people.length>0 ? 
                              people.map((Person p) {
                                return new DropdownMenuItem<String>(
                                  value: p.name,
                                  child: new Text(p.name),
                                );
                              }).toList() : 
                              selectedPerson != null ?
                                [selectedPerson].map((Person p) {
                                  return new DropdownMenuItem<String>(
                                    value: p.name,
                                    child: new Text(p.name),
                                  );
                                }).toList() :
                                [emptyPeopleMessage].map((String s) {
                                  return new DropdownMenuItem<String>(
                                    value: s,
                                    child: new Text(s),
                                  );
                                }).toList(),
                  ),
                ),
              );
            },
            validator: (val) {
              if(val == ''){
                return 'Please select a Person';
              }
              if (val == emptyPeopleMessage){
                return 'Please create a Person first';
              }
            },
          ),
          //EventType field
          new FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  icon: const Icon(Icons.party_mode),
                  labelText: 'Event Type *',
                  errorText: state.hasError ? state.errorText : null,
                ),
                isEmpty: selectedEventType == null,
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton<String>(
                    value: selectedEventType!= null ? selectedEventType : "No EventTypes Available",
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        selectedEventType = newValue;
                        state.didChange(newValue);
                      });
                    },
                    items: eventTypeOptions.length>0 ? 
                              eventTypeOptions.map((String e) {
                                return new DropdownMenuItem<String>(
                                  value: e,
                                  child: new Row(
                                    children: <Widget>[
                                      new Icon(Helpers.IconStringMap[e]),
                                      new Padding(padding: EdgeInsets.only(left: 15), child: new Text(e))
                                    ],
                                  )
                                );
                              }).toList() : 
                              ["No EventTypes Available"].map((String s) {
                                return new DropdownMenuItem<String>(
                                  value: s,
                                  child: new Text(s),
                                );
                              }).toList(),
                  ),
                ),
              );
            },
            validator: (val) { },
          ),
          //Description
          TextFormField(
            controller: descFieldController,
            maxLines: 3,
            decoration: const InputDecoration(
              icon: Icon(Icons.chat_bubble_outline),
              hintText: 'Any additional details...',
              labelText: 'Description',
            ),
            validator:  (value){ },
          ),
          //Recurring field
          new Row(
            children: <Widget>[
              Icon(Icons.history),
              Padding(
                padding: EdgeInsets.only(right: 60, left: 15),
                child: Text('Yearly Recurrence'),
              ),
              Switch.adaptive(
                value: recurringBool,
                activeColor: Colors.green, 
                onChanged: (bool val){
                  setState(() {
                    recurringBool = val;
                  });
                },
              ),
            ]
          ),

          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Cancel'),
                onPressed: () {
                  //Confirm changes lost
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Unsaved Event'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Your unsaved event will be lost.'),
                              Text('Continue?'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('Confirm'),
                            onPressed: () {
                              //Dismiss dialog
                              Navigator.of(context).pop();
                              //Navigate away from page without saving changes
                              Navigator.of(context).pop();
                            },
                          ),
                          FlatButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              //Dismiss dialog
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    }
                  );
                },
              ),
              RaisedButton(
                child: Text('Create'),
                onPressed: () {
                  //Cue validation
                  setState(() {
                    autovalidate = true;
                  });

                  if(_formKey.currentState.validate()){
                    var date = selectedDateTime.millisecondsSinceEpoch;
                    var title = titleFieldController.text;
                    var desc = descFieldController.text; 
                    var recurring = recurringBool ? 1 : 0; //true = 1, false = 0

                    Event e = new Event(date, title, desc, selectedEventType, recurring, 0, selectedPerson.id);

                    //Save event
                    DBProvider.db.saveEvent(e);

                    //Navigate back with message to display status
                    Navigator.pop(context, 'Saved.');
                  }
                  //if invalid, form validation will show error messages
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}