
class Idea {
  final String title;
  final String description;

  Idea(this.title, this.description);
}

class Event {
  final DateTime date;
  final String title;
  final String description;

  Event(this.date, this.title, this.description);
}

class Person {
  final String name;
  final List<Event> events;
  final List<Idea> ideas;

  Person(this.name, this.events, this.ideas);
}