import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class EventsCalendarScreen extends StatefulWidget {
  final Map<DateTime, List<String>> savedNotes;

  const EventsCalendarScreen({Key? key, required this.savedNotes}) : super(key: key);

  @override
  _EventsCalendarScreenState createState() => _EventsCalendarScreenState();
}

class _EventsCalendarScreenState extends State<EventsCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _focusedDay = DateTime.now();
                _selectedDay = _focusedDay;
              });
            },
            child: const Text(
              'Сегодня',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TableCalendar(
              locale: 'ru_RU',
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              eventLoader: (day) {
                return widget.savedNotes[day] ?? [];
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarFormat: CalendarFormat.month,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: Icon(Icons.chevron_left, color: Colors.grey),
                rightChevronIcon: Icon(Icons.chevron_right, color: Colors.grey),
                titleTextStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: const TextStyle().copyWith(color: Colors.grey),
                weekdayStyle: const TextStyle().copyWith(color: Colors.grey),
              ),
              calendarStyle: CalendarStyle(
                weekendTextStyle: const TextStyle().copyWith(color: Colors.black),
                outsideDaysVisible: false,
                selectedDecoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                markersMaxCount: 1,
                markerDecoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            // Показать сохраненные заметки при выборе даты
            if (_selectedDay != null && widget.savedNotes.containsKey(_selectedDay))
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.savedNotes[_selectedDay]?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.savedNotes[_selectedDay]![index]),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
