import 'package:flutter/material.dart';

class GiftIdeaForm extends StatefulWidget {
  @override
  GiftIdeaFormState createState(){
    return GiftIdeaFormState();
  }
}

class GiftIdeaFormState extends State<GiftIdeaForm>{
  final _formKey = GlobalKey<FormState>();

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
                    //TODO persist data

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