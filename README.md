# Gift Assist

Flutter project for tracking gift ideas


## TODOs

(other todos in code as TODOs)

- persistance - 
	- v1: [shared_preferences](https://flutter.io/docs/cookbook/persistence/key-value)
	- v2: [local app file storage](https://flutter.io/docs/cookbook/persistence/reading-writing-files) 
	- v2.5: try rest apis [1](https://medium.com/flutter-community/working-with-apis-in-flutter-8745968103e9), [2](https://stackoverflow.com/questions/51911526/rest-api-in-flutter), [3](https://flutter.io/docs/cookbook/networking/fetch-data)
	- v3: dropbox [1](https://www.dropbox.com/developers/documentation/http/documentation),  [2](https://www.dropbox.com/developers/reference/getting-started#overview)
	- v4: google drive [1](https://pub.dartlang.org/packages/googleapis), [2](https://developers.google.com/drive/api/v3/about-sdk), [3](https://developers.google.com/drive/api/v2/appdata)

- add events page
	- new page
	- tie into quick create speed dial on person page
	- tie into button on global events page

- [tabs](https://flutter.io/docs/cookbook/design/tabs) on personpage (Events, Uncategorized Ideas, Past Events)

- custom [global text styles](https://flutter.io/docs/cookbook/design/themes)
	- font properties (weight, size, etc)
	- font color
	- upcoming unplanned events in red

- rev create gift idea page
	- tie to more than one person

- ideas tying to more than one event
	- object model
	- redo 'mark complete' logic

- long press gift idea on personpage -> menu/dialog - multiselect delete, edit, or move to other event section

- longer term: 
	- bar code scanning
	- auto-pull pricing info for gift ideas
	- gift idea auto suggestions
	- auth
	- animations/effects
	- alerts 
	- export/email
	- wish list & sharing capability
