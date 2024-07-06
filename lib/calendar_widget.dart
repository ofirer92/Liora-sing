import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarWidget extends StatefulWidget {
  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<Event>> _events = {};

  @override
  void initState() {
    super.initState();
    _events = {
      DateTime(2024, 7, 10): [Event('טיול', 'טיול יפה בהרים. הביאו נעליים נוחות ומים!')],
      DateTime(2024, 7, 15): [Event('פגישה', 'פגישת צוות לדיון בהתקדמות הפרויקט.')],
      DateTime(2024, 7, 20): [Event('טיול', 'חקירת חורבות העיר העתיקה. אל תשכחו להביא מצלמה!')],
      DateTime(2024, 7, 25): [Event('כנס', 'כנס שנתי של התעשייה במרכז הכנסים.')],
    };
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'הזמן טיול',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            eventLoader: (day) {
              return _getEventsForDay(day).where((event) => event.title == 'טיול').toList();
            },
            calendarStyle: CalendarStyle(
              markerDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(height: 20),
          if (_selectedDay != null)
            _buildEventInfo(_getEventsForDay(_selectedDay!)),
        ],
      ),
    );
  }

  Widget _buildEventInfo(List<Event> events) {
    Event? tripEvent = events.firstWhere(
      (event) => event.title == 'טיול',
      orElse: () => Event('', ''),
    );

    if (tripEvent.title.isNotEmpty) {
      return Column(
        children: [
          Text(
            tripEvent.description,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _launchWhatsApp(_selectedDay!),
            child: Text('הזמן טיול זה בוואטסאפ'),
          ),
        ],
      );
    } else {
      return Text('אין טיול מתוכנן ביום זה');
    }
  }

  void _launchWhatsApp(DateTime date) async {
    final url = 'https://wa.me/0524508654?text=היי, אני מעוניין בטיול בתאריך ${date.toString().split(' ')[0]}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}

class Event {
  final String title;
  final String description;

  Event(this.title, this.description);
}