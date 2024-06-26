import 'package:flutter/material.dart';
import 'package:progetto_prova/models/drink.dart';
import 'package:progetto_prova/provider/homeProvider.dart';
import 'package:progetto_prova/screens/editDrink.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';


class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DRINK CALENDAR'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
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
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: (day) {
              return homeProvider.drinks[day]?.map((drink) => "${drink.name} (${drink.quantity}) at ${drink.time.toLocal().toString().substring(11, 16)}").toList() ?? [];
            },
          ),
          ...((homeProvider.drinks[_selectedDay] ?? []).asMap().entries.map((entry) {
            int index = entry.key;
            Drink drink = entry.value;
            return ListTile(
              title: Text("${drink.name} (${drink.quantity}) at ${drink.time.toLocal().toString().substring(11, 16)}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditDrinkPage(
                            selectedDay: _selectedDay,
                            drink: drink,
                            index: index,
                          ),
                        ),
                      );
                      if (result != null) {
                        homeProvider.updateDrink(_selectedDay, index, result['name'], result['quantity'], result['time']);
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      homeProvider.removeDrink(_selectedDay, index);
                    },
                  ),
                ],
              ),
            );
          }).toList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditDrinkPage(selectedDay: _selectedDay),
            ),
          );
          if (result != null) {
            homeProvider.addDrink(_selectedDay, result['name'], result['quantity'], result['time']);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
