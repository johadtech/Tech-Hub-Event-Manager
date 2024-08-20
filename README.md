
# Tech Hub Event Management System

## Overview

The **Tech Hub Event Management System** is a command-line application built using Dart. It enables tech hub teams to efficiently manage events, track attendance, and manage schedules. This tool is particularly useful for organizing and tracking multiple events, registering attendees, checking for schedule conflicts, and storing event data in a persistent format.

## Features

### Event Management
- **Add Events**: Create new events with details such as title, date, time, location, and description.
- **Edit Events**: Modify the details of existing events.
- **Delete Events**: Remove events that are no longer needed.
- **List Events**: Display all upcoming and past events.

### Attendance Tracking
- **Register Attendees**: Add attendees to specific events.
- **View Attendees**: List all attendees for a particular event, including their attendance status.
- **Mark Attendance**: Mark attendees as present or absent.

### Scheduling
- **List Chronological Events**: Display events in chronological order.
- **Check Schedule Conflicts**: Identify and report conflicts in scheduling.

### Data Persistence
- **Save Events**: Save the events and attendance data to a file (JSON format).
- **Load Events**: Load events and attendance data from a file (JSON format).

### User Interface
- **Command-Line Interface**: The application interacts with users entirely through the command line, utilizing Dart's `dart:io` package for input and output.

## Prerequisites

- **Dart SDK**: Ensure you have Dart installed on your machine. You can download it from [Dart's official site](https://dart.dev/get-dart).

## How to Run the Application

1. **Clone or Download the Repository**: 
   ```bash
   git clone https://github.com/yourusername/tech-hub-event-manager.git
   cd tech-hub-event-manager
   ```

2. **Navigate to the Project Directory**:
   If you haven’t already navigated to the directory where the project resides, do so now:
   ```bash
   cd tech-hub-event-manager
   ```

3. **Run the Dart Program**:
   To start the application, run the following command:
   ```bash
   dart tech_hub_event_manager.dart
   ```

4. **Interact with the Application**:
   - Upon running the program, you’ll be presented with a menu of options.
   - Enter the corresponding number to perform actions like adding an event, editing an event, registering an attendee, etc.
   - Follow the prompts to provide the necessary details.

## Example Usage

```bash
Tech Hub Event Management System
1. Add Event
2. Edit Event
3. Delete Event
4. List Events
5. List Events Chronologically
6. Check Schedule Conflict
7. Register Attendee
8. View Attendees
9. Mark Attendance
10. Save Events to File
11. Load Events from File
12. Exit
Enter your choice:
```

- **Add an Event**: Select option `1`, then provide details like event title, date, time, location, and description.
- **Register an Attendee**: Select option `7`, then provide the event index and attendee name.

## Saving and Loading Data

- **Saving Data**: Choose option `10` and enter a filename to save your current event data to a JSON file.
- **Loading Data**: Choose option `11` and enter a filename to load event data from a previously saved JSON file.

## Contributing

Contributions to the project are welcome. Please fork the repository and submit a pull request with your improvements.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For any issues or suggestions, please open an issue on the GitHub repository or contact me directly at johadtech@gmail.com .
