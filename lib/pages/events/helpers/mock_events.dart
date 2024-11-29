import 'dart:math';

class Event {
  final String id;
  final String title;

  final String description;
  final DateTime date;
  final String time;

  Event(
      {required this.id,
      required this.title,
      required this.date,
      required this.time,
      required this.description});

  // Factory method to generate a Feed from an index
  factory Event.fromIndex(int index) {
    return Event(
      id: generateString(),
      title: generateString(),
      description: 'This is the description for event #$index.',
      date: DateTime.parse("2024-12-25"),
      time: "5:00 PM",
    );
  }
}

class DummyEventDatabase {
  final List<Event> _events;
  static const int _numberOfEvents = 17;

  DummyEventDatabase()
      : _events = List.generate(
            _numberOfEvents, (index) => Event.fromIndex(index),
            growable: true);

  Future<List<Event>> getFeeds(int startIndex, int count) async {
    // This will handle things to not exceed existing "rows" of data.
    int endIndex = (startIndex + count) > _events.length
        ? _events.length
        : startIndex + count;

    // Simlute request delay
    await Future.delayed(Duration(seconds: 2));

    // Return "rows" starting from the new startIndex on each request and the new endIndex
    return _events.sublist(startIndex, endIndex);
  }
}

String generateString() {
  String aplphabet = "abcdefghijklmnopqrstuvwxyz";
  Random random = Random();
  int stringLength = random.nextInt(10);
  String string = "";

  for (var i = 0; i < stringLength; i++) {
    int randomNum = random.nextInt(25) + 1;
    string += aplphabet[randomNum];
  }

  return string;
}

// FOR TESTING PURPOSES
void main() async {
  DummyEventDatabase feedDatabase = DummyEventDatabase();

  final int initialNumberOfFeeds = 5;
  final int nextNumberOfFeeds = 5;

  List<Event> initialFeeds =
      await feedDatabase.getFeeds(0, initialNumberOfFeeds);
  print('Initial feeds: ${initialFeeds.length}');

  List<Event> moreFeeds =
      await feedDatabase.getFeeds(initialNumberOfFeeds, nextNumberOfFeeds);
  print('More feeds: ${moreFeeds.length}');
}
