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
    // var x = await DBProvider.db.getAllPeople();
    // return x[0];
  }

  TextEditingController nameFieldController = new TextEditingController();
  TextEditingController websiteFieldController = new TextEditingController();

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
       //   DropdownButtonFormField(items: ,decoration: ,)

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

                    TEMPGetPerson().then((Person value){
                      var p = value;

                      Idea i = new Idea(uuid.v1(), title, desc, site, 0, null, p.id);

                      DBProvider.db.saveIdea(i);

                    });                   

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