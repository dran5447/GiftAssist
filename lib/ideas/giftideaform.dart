import 'package:flutter/material.dart';
import '../model/idea.dart';
import '../model/person.dart';
import 'package:uuid/uuid.dart';
import '../shared/datastore.dart';

class GiftIdeaForm extends StatefulWidget {
  @override
  GiftIdeaFormState createState(){
    return GiftIdeaFormState();
  }
}

class GiftIdeaFormState extends State<GiftIdeaForm>{
  final _formKey = GlobalKey<FormState>();
  final uuid = new Uuid();

  Future<Person> TEMPGetPerson() async{
    Person p  = await DBProvider.db.getFirstPerson(); 
    return p;
  }

  getPeople() async{
    var peeps = await DBProvider.db.getAllPeople();
    
    setState(() {
      people = peeps;
      selectedPerson = peeps[0];
    });
  }

  TextEditingController nameFieldController = new TextEditingController();
  TextEditingController websiteFieldController = new TextEditingController();
  Person selectedPerson = null;
  List<Person> people = new List<Person>();
  
  Person getSelectedPersonByName(String searchName){
      for(Person p in people){
        if(p.name == searchName){
          return p;
        }
      }
      return null;
    }

  @override
  void initState() {
    super.initState();
    this.getPeople();
  }

  @override 
  Widget build(BuildContext context) {

    return Form(
      autovalidate: true,
      key: _formKey,
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
                //TODO consider appending http:// for data persistance
                if(!value.startsWith(httpPrefixRegex)) {
                  if(!value.startsWith(wwwPrefixRegex)){
                    return 'Invalid format.';
                  }
                }
              }
            },
          ),
          new FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  icon: const Icon(Icons.color_lens),
                  labelText: 'Person',
                  errorText: state.hasError ? state.errorText : null,
                ),
                isEmpty: selectedPerson == null,
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton<String>(
                    value: selectedPerson!= null ? selectedPerson.name : 
                                (people != null && people.length>0 ? people[0].name : "Pick a Person"),
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
                              ['No people created'].map((String s) {
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
              return val != '' ? null : 'Please select a Person';
            },
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
                  if(_formKey.currentState.validate()){
                    var title = nameFieldController.text;
                    var site = websiteFieldController.text;
                     
                    //TODO temporarily assign to certain properties for now
                    var desc = "some description"; 

                    Idea i = new Idea(uuid.v1(), title, desc, site, 0, null, selectedPerson.id);

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