# Gift Assist

Flutter project for tracking gift ideas

![Android-Emulator-Pixel-4-API-30.gif](Android-Emulator-Pixel-4-API-30.gif)

## Running

Clone and follow instructions for getting a Flutter project working here - https://flutter.dev/docs/get-started/install

## TODOs

- [ ] Enum for idea status (created, purchased, arrived, archived)
- [ ] Optional cost field for ideas, so we can get an estimated total spent per event -> possible budgeting
- [ ] Edit and delete for ideas
- [ ] Edit and delete for events -> option to keep ideas around or delete
- [ ] Edit and delete for people
- [ ] 'Uncategorized' default idea option (otherwise now when you create an event you cant have unassoc ideas)
- [ ] Ability to map one idea to many events
- [ ] Generic event names on home page are unclear who they belong to -add the Person name
- [ ] Ideas bulk delete / archive options
- [x] Ideas arent getting tied to events / person correctly now?
- [ ] Person creation should have option to add events, picture
- [ ] Initial launch should have better intro popup (but once this is done, dont show in debug mode to save sanity)
- [x] Fix event complete/incomplete toggle on home
- [x] Event creation should have event type at TOP, and then some events (like vday) shouldnt require a name
- [ ] Certain events should auto-fill date (e.g. xmas, vday)
- [ ] Should be able to add more than one website for an idea
- [ ] Does yearly recurr actually work yet?
- [ ] Events page on a profile needs work - list of events -> click one -> details page, and summary of ideas
- [ ] Ability to move an idea from one event to another
- [ ] Ability to customize date range for home 'upcoming events' (drop down and cache the setting)

Lower pri

- [ ] After save idea/event, make sure to close the FAB dial so it reloads properly
- [ ] Event page should have option to set alerts during creation as 1-offs (should alerts be global managed or indiv)
- [ ] Ability to add ideas during event creation?'
- [ ] Option for data persistance -
	- dropbox [1](https://www.dropbox.com/developers/documentation/http/documentation),  [2](https://www.dropbox.com/developers/reference/getting-started#overview)
	- google drive [1](https://pub.dartlang.org/packages/googleapis), [2](https://developers.google.com/drive/api/v3/about-sdk), [3](https://developers.google.com/drive/api/v2/appdata)
- [ ] Option to export via email, and possible other sharing options?
- [ ] Design updates
    - Custom [global text styles](https://flutter.io/docs/cookbook/design/themes)
        - font properties (weight, size, etc)
        - font color
        - upcoming unplanned events in red
    - Animations/effects
    - Nice themed pictures / UI spiff
- [ ] Redo 'mark complete' logic
- [ ] Long press gift idea on personpage -> menu/dialog - multiselect delete, edit, or move to other event section
- [ ] Pic for people
- [ ] Bar code scanning?
- [ ] Auto-pull pricing info for gift ideas?
- [ ] Gift idea auto suggestions?
- [ ] Option to auth/pw protect
- [ ] Alerts!
