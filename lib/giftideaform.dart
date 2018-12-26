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
          TextFormField(
            decoration: const InputDecoration(
            icon: Icon(Icons.card_giftcard),
            hintText: 'What is your gift idea?',
            labelText: 'Idea *',
          ),
          //TODO  autocorrect: ,
          validator:  (value){
            //TODO add other validation
            if(value.isEmpty){
              return 'Please enter a value';
            }
          },
        ),

        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
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
              child: Text('Cancel'),
            ),
            RaisedButton(
              onPressed: () {
                if(_formKey.currentState.validate()){
                   //TODO persist data
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("VALID"),
                      );});
                }
                //if invalid, form validation will show error messages
              },
              child: Text('Create'),
            ),
          ],
        ),
        ],
      ),
    );
  }
}