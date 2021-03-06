import 'package:flutter/material.dart';
import '../model/idea.dart';
import '../model/person.dart';
import '../model/event.dart';
import 'package:uuid/uuid.dart';
import '../shared/datastore.dart';

class GiftIdeaForm extends StatefulWidget {
  final Person person;
  GiftIdeaForm({Key key, this.person}) : super(key: key);

  @override
  GiftIdeaFormState createState(){
    return GiftIdeaFormState(selectedPerson: person);
  }
}

class GiftIdeaFormState extends State<GiftIdeaForm>{
  GiftIdeaFormState({Key key, this.selectedPerson});

  final String emptyPeopleMessage = 'No people created';
  final String emptyEventsMessage = 'No events created';
  final _formKey = GlobalKey<FormState>();
  final uuid = new Uuid();
  bool autovalidate = false;
  TextEditingController nameFieldController = new TextEditingController();
  TextEditingController websiteFieldController = new TextEditingController();
  TextEditingController descFieldController = new TextEditingController();
  Person selectedPerson;
  List<Person> people = new List<Person>();
  Event selectedEvent;
  List<Event> events = new List<Event>();

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

  getEvents() async{
    var events;

    if(selectedPerson != null){
      events = await DBProvider.db.getEventsForPerson(selectedPerson);

      setState(() {
        this.events = events;
        
        selectedEvent = events[0];
      });
    }
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

  Event getSelectedEventByName(String searchName){
    for(Event e in events){
      if(e.title == searchName){
        return e;
      }
    }
    return null;
  }

  @override
  void initState() {
    this.getPeople();
    this.getEvents();
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidate: autovalidate,
      child: Column(
        children: <Widget>[
          //TODO optional picture for idea

          //Name
          TextFormField(
            controller: nameFieldController,
            decoration: const InputDecoration(
              icon: Icon(Icons.card_giftcard),
              hintText: 'What is your gift idea?',
              labelText: 'Idea Name *',
            ),
            validator:  (value){
              if(value.isEmpty){
                return 'Please enter a value';
              }
            },
          ),
          //Optional website
          TextFormField(
            controller: websiteFieldController,
            decoration: const InputDecoration(
              icon: Icon(Icons.public),
              hintText: 'URL for the gift idea',
              labelText: 'Website',
            ),
            validator:  (value){
              if(value.isNotEmpty){
                var httpPrefixRegex = new RegExp('^http(s)?\\:\\/\\/(www\\.)?([^\\ ]*)\$');
                var wwwPrefixRegex = new RegExp('^www\\.([^\\ ]*)\$');
                //Accept formats of type http:// , https:// , and www. 
                if(!value.startsWith(httpPrefixRegex)) {
                  if(!value.startsWith(wwwPrefixRegex)){
                    return 'Invalid format.';
                  }
                }
              }
            },
          ),
          //Person field
          new FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: 'Person *',
                  hintText: 'Who is this idea for?',
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
                        this.getEvents(); //Reload events for that person
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
              if (val == null && selectedPerson == null){
                return 'Please create a Person first';
              }
            },
          ),
          //Event field
          new FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  icon: const Icon(Icons.calendar_today),
                  labelText: 'Event',
                  hintText: 'Optional event to associate with',
                  errorText: state.hasError ? state.errorText : null,
                ),
                isEmpty: selectedEvent == null,
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton<String>(
                    value: selectedEvent!= null ? selectedEvent.title : 
                                (events != null && events.length>0 ? events[0].title : emptyEventsMessage),
                    isDense: true,
                    onChanged: (String newValue) {
                      setState(() {
                        selectedEvent = getSelectedEventByName(newValue);
                        state.didChange(newValue);
                      });
                    },
                    items: events.length>0 ? 
                              events.map((Event e) {
                                return new DropdownMenuItem<String>(
                                  value: e.title,
                                  child: new Text(e.title),
                                );
                              }).toList() : 
                              selectedEvent != null ?
                                [selectedEvent].map((Event e) {
                                  return new DropdownMenuItem<String>(
                                    value: e.title,
                                    child: new Text(e.title),
                                  );
                                }).toList() :
                                [emptyEventsMessage].map((String s) {
                                  return new DropdownMenuItem<String>(
                                    value: s,
                                    child: new Text(s),
                                  );
                                }).toList(),
                  ),
                ),
              );
            },
            validator: (val) {  },
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
                        title: Text('Unsaved Gift Idea'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Your unsaved gift idea will be lost.'),
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
                    var title = nameFieldController.text;
                    var site = websiteFieldController.text;
                    var desc = descFieldController.text; 

                    Idea i;
                    if(selectedEvent != null){
                      i = new Idea(uuid.v1(), title, desc, site, 0, selectedEvent.id, selectedPerson.id);
                    } else{  //save as an uncategorized idea for the selected person
                      i = new Idea(uuid.v1(), title, desc, site, 0, null, selectedPerson.id);
                    }

                    DBProvider.db.saveIdea(i);

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