# Gift Assist

Flutter project for tracking gift ideas

## Known bugs

- Events on home page are not sorted by date 
- Events on home page are sum of all events; clip to a defined chunk of time (within 30 days)
- After save idea/event, make sure to close the FAB dial so it reloads properly


## TODOs

(other todos in code as TODOs)

- Event details info page
- Edit and delete for ideas
- Edit and delete for events
- Edit and delete for people
- Ability to move an idea from one event to another
- Ability to add idea to more than one event
- Ability to customize date range for home 'upcoming events'


V2

- persistance - 
	- dropbox [1](https://www.dropbox.com/developers/documentation/http/documentation),  [2](https://www.dropbox.com/developers/reference/getting-started#overview)
	- google drive [1](https://pub.dartlang.org/packages/googleapis), [2](https://developers.google.com/drive/api/v3/about-sdk), [3](https://developers.google.com/drive/api/v2/appdata)
- update idea creation page
- custom [global text styles](https://flutter.io/docs/cookbook/design/themes)
	- font properties (weight, size, etc)
	- font color
	- upcoming unplanned events in red
- redo 'mark complete' logic
- long press gift idea on personpage -> menu/dialog - multiselect delete, edit, or move to other event section
- pic for people
- bar code scanning
- auto-pull pricing info for gift ideas
- gift idea auto suggestions
- auth
- animations/effects
- alerts 
- export/email
- wish list & sharing capability
