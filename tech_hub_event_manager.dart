import 'dart:io';
import 'dart:convert';

class TechHubEventManager {
  List<Event> events = [];

  void addEvent(String title, String date, String time, String location, String description) {
    events.add(Event(title, date, time, location, description));
    print('Event "$title" added successfully.');
  }

  void editEvent(int index, String title, String date, String time, String location, String description) {
    if (index >= 0 && index < events.length) {
      events[index]
        ..title = title
        ..date = date
        ..time = time
        ..location = location
        ..description = description;
      print('Event "$title" updated successfully.');
    } else {
      print('Invalid event index.');
    }
  }

  void deleteEvent(int index) {
    if (index >= 0 && index < events.length) {
      String title = events[index].title;
      events.removeAt(index);
      print('Event "$title" deleted successfully.');
    } else {
      print('Invalid event index.');
    }
  }

  void listEvents() {
    if (events.isEmpty) {
      print('No events found.');
    } else {
      print('List of all events:');
      for (var i = 0; i < events.length; i++) {
        print('${i + 1}. ${events[i]}');
      }
    }
  }

  void listEventsChronologically() {
    events.sort((a, b) => a.date.compareTo(b.date));
    listEvents();
  }

  bool checkScheduleConflict(String date, String time) {
    for (var event in events) {
      if (event.date == date && event.time == time) {
        print('Schedule conflict detected with event: ${event.title}');
        return true;
      }
    }
    return false;
  }

  void registerAttendee(int eventIndex, String attendeeName) {
    if (eventIndex >= 0 && eventIndex < events.length) {
      events[eventIndex].attendees.add(Attendee(attendeeName));
      print('Attendee "$attendeeName" registered successfully for event "${events[eventIndex].title}".');
    } else {
      print('Invalid event index.');
    }
  }

  void viewAttendees(int eventIndex) {
    if (eventIndex >= 0 && eventIndex < events.length) {
      print('Attendees for event "${events[eventIndex].title}":');
      for (var i = 0; i < events[eventIndex].attendees.length; i++) {
        print('${i + 1}. ${events[eventIndex].attendees[i].name} - ${events[eventIndex].attendees[i].isPresent ? "Present" : "Absent"}');
      }
    } else {
      print('Invalid event index.');
    }
  }

  void markAttendance(int eventIndex, int attendeeIndex, bool isPresent) {
    if (eventIndex >= 0 && eventIndex < events.length) {
      if (attendeeIndex >= 0 && attendeeIndex < events[eventIndex].attendees.length) {
        events[eventIndex].attendees[attendeeIndex].isPresent = isPresent;
        print('Attendance updated for attendee "${events[eventIndex].attendees[attendeeIndex].name}".');
      } else {
        print('Invalid attendee index.');
      }
    } else {
      print('Invalid event index.');
    }
  }

  void saveToFile(String filename) {
    try {
      File file = File(filename);
      List<Map<String, dynamic>> jsonEvents = events.map((event) => event.toJson()).toList();
      file.writeAsStringSync(jsonEncode(jsonEvents));
      print('Events saved to "$filename".');
    } catch (e) {
      print('Error saving to file: $e');
    }
  }

  void loadFromFile(String filename) {
    try {
      File file = File(filename);
      if (file.existsSync()) {
        List<dynamic> jsonEvents = jsonDecode(file.readAsStringSync());
        events = jsonEvents.map((jsonEvent) => Event.fromJson(jsonEvent)).toList();
        print('Events loaded from "$filename".');
      } else {
        print('File "$filename" not found.');
      }
    } catch (e) {
      print('Error loading from file: $e');
    }
  }
}

class Event {
  String title;
  String date;
  String time;
  String location;
  String description;
  List<Attendee> attendees = [];

  Event(this.title, this.date, this.time, this.location, this.description);

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'time': time,
      'location': location,
      'description': description,
      'attendees': attendees.map((attendee) => attendee.toJson()).toList(),
    };
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    Event event = Event(
      json['title'],
      json['date'],
      json['time'],
      json['location'],
      json['description'],
    );
    event.attendees = (json['attendees'] as List<dynamic>)
        .map((attendeeJson) => Attendee.fromJson(attendeeJson))
        .toList();
    return event;
  }

  @override
  String toString() {
    return '$title on $date at $time, $location\n$description';
  }
}

class Attendee {
  String name;
  bool isPresent = false;

  Attendee(this.name);

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isPresent': isPresent,
    };
  }

  factory Attendee.fromJson(Map<String, dynamic> json) {
    return Attendee(json['name'])..isPresent = json['isPresent'];
  }
}

void main() {
  TechHubEventManager manager = TechHubEventManager();

  while (true) {
    print('\nTech Hub Event Management System');
    print('1. Add Event');
    print('2. Edit Event');
    print('3. Delete Event');
    print('4. List Events');
    print('5. List Events Chronologically');
    print('6. Check Schedule Conflict');
    print('7. Register Attendee');
    print('8. View Attendees');
    print('9. Mark Attendance');
    print('10. Save Events to File');
    print('11. Load Events from File');
    print('12. Exit');
    print('Enter your choice:');

    String? choice = stdin.readLineSync();
    if (choice == null || choice.isEmpty) {
      print('Invalid choice. Please try again.');
      continue;
    }

    switch (choice) {
      case '1':
        print('Enter event title:');
        String? title = stdin.readLineSync();
        print('Enter event date (YYYY-MM-DD):');
        String? date = stdin.readLineSync();
        print('Enter event time (HH:MM):');
        String? time = stdin.readLineSync();
        print('Enter event location:');
        String? location = stdin.readLineSync();
        print('Enter event description:');
        String? description = stdin.readLineSync();
        if (title != null && date != null && time != null && location != null && description != null) {
          manager.addEvent(title, date, time, location, description);
        } else {
          print('Invalid input. Event not added.');
        }
        break;

      case '2':
        print('Enter event index to edit:');
        int? index = int.tryParse(stdin.readLineSync() ?? '');
        if (index != null && index > 0) {
          print('Enter new event title:');
          String? newTitle = stdin.readLineSync();
          print('Enter new event date (YYYY-MM-DD):');
          String? newDate = stdin.readLineSync();
          print('Enter new event time (HH:MM):');
          String? newTime = stdin.readLineSync();
          print('Enter new event location:');
          String? newLocation = stdin.readLineSync();
          print('Enter new event description:');
          String? newDescription = stdin.readLineSync();
          if (newTitle != null && newDate != null && newTime != null && newLocation != null && newDescription != null) {
            manager.editEvent(index - 1, newTitle, newDate, newTime, newLocation, newDescription);
          } else {
            print('Invalid input. Event not updated.');
          }
        } else {
          print('Invalid event index.');
        }
        break;

      case '3':
        print('Enter event index to delete:');
        int? delIndex = int.tryParse(stdin.readLineSync() ?? '');
        if (delIndex != null && delIndex > 0) {
          manager.deleteEvent(delIndex - 1);
        } else {
          print('Invalid event index.');
        }
        break;

      case '4':
        manager.listEvents();
        break;

      case '5':
        manager.listEventsChronologically();
        break;

      case '6':
        print('Enter date (YYYY-MM-DD) to check for conflicts:');
        String? checkDate = stdin.readLineSync();
        print('Enter time (HH:MM) to check for conflicts:');
        String? checkTime = stdin.readLineSync();
        if (checkDate != null && checkTime != null) {
          manager.checkScheduleConflict(checkDate, checkTime);
        } else {
          print('Invalid date or time.');
        }
        break;

      case '7':
        print('Enter event index to register attendee:');
        int? regIndex = int.tryParse(stdin.readLineSync() ?? '');
        if (regIndex != null && regIndex > 0) {
          print('Enter attendee name:');
          String? attendeeName = stdin.readLineSync();
          if (attendeeName != null) {
            manager.registerAttendee(regIndex - 1, attendeeName);
          } else {
            print('Invalid attendee name.');
          }
        } else {
          print('Invalid event index.');
        }
        break;

      case '8':
        print('Enter event index to view attendees:');
        int? viewIndex = int.tryParse(stdin.readLineSync() ?? '');
        if (viewIndex != null && viewIndex > 0) {
          manager.viewAttendees(viewIndex - 1);
        } else {
          print('Invalid event index.');
        }
        break;

      case '9':
        print('Enter event index to mark attendance:');
        int? attIndex = int.tryParse(stdin.readLineSync() ?? '');
        if (attIndex != null && attIndex > 0) {
          print('Enter attendee index:');
          int? attendeeIndex = int.tryParse(stdin.readLineSync() ?? '');
          if (attendeeIndex != null && attendeeIndex > 0) {
            print('Is the attendee present? (yes/no):');
            bool isPresent = (stdin.readLineSync() ?? '').toLowerCase() == 'yes';
            manager.markAttendance(attIndex - 1, attendeeIndex - 1, isPresent);
          } else {
            print('Invalid attendee index.');
          }
        } else {
          print('Invalid event index.');
        }
        break;

      case '10':
        print('Enter filename to save events (e.g., events.json):');
        String? saveFilename = stdin.readLineSync();
        if (saveFilename != null && saveFilename.isNotEmpty) {
          manager.saveToFile(saveFilename);
        } else {
          print('Invalid filename.');
        }
        break;

      case '11':
        print('Enter filename to load events (e.g., events.json):');
        String? loadFilename = stdin.readLineSync();
        if (loadFilename != null && loadFilename.isNotEmpty) {
          manager.loadFromFile(loadFilename);
        } else {
          print('Invalid filename.');
        }
        break;

      case '12':
        print('Exiting...');
        return;

      default:
        print('Invalid choice. Please try again.');
    }
  }
}
