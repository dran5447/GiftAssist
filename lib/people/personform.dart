import 'dart:io';
import 'package:flutter/material.dart';
import '../shared/datastore.dart';
import '../model/person.dart';
import 'package:uuid/uuid.dart';

class PersonForm extends StatefulWidget {
  @override
  PersonFormState createState(){
    return PersonFormState();
  }
}

class PersonFormState extends State<PersonForm>{
  final uuid = new Uuid();
  final _formKey = GlobalKey<FormState>();

   void testData() async{
    var x = await DBProvider.db.getAllPeople();
    print(x);

    DBProvider.db.listTables();
   }

  TextEditingController nameFieldController = new TextEditingController();

  Future<int> savePerson(Person person) async{
    return await DBProvider.db.savePerson(person);
  }

  @override 
  Widget build(BuildContext context) {

 //   testData();




    return Form(
      autovalidate: true,
      key: _formKey,
      child: Column(
        children: <Widget>[
          //Name
          TextFormField(
            controller: nameFieldController,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Name',
              labelText: 'Name *',
            ),
            validator:  (value){
              if(value.isEmpty){
                return 'Please enter a value';
              }
            },
          ),
          //TODO dropdown stuff for adding events and ideas
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
                        title: Text('Unsaved Person Changes'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Your unsaved person details will be lost.'),
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
                    //Send to DataStore for encoding
                    var newPerson = new Person(uuid.v1(), nameFieldController.text); //TODO add other stuff later

                    savePerson(newPerson).then((int status){
                        //Navigate back with message to display status
                        Navigator.pop(context, 'Saved.');
                    });                    
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