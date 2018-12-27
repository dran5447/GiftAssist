
class Idea {
  final String title;
  final String description;
  final String website;

  Idea(this.title, this.description, [this.website = '']);
}

class Event {
  final DateTime date;
  final String title;
  final String description;
  
  final bool recurring;
  final List<Idea> ideas;
  bool isExpanded;

  Event(this.date, this.title, this.description, [this.ideas, this.recurring = false, this.isExpanded = false]);
}

class Person {
  final String name;
  final List<Event> events;
  final List<Idea> unassignedIdeas;

  Person(this.name, this.events, this.unassignedIdeas);
}