import 'package:Nameless/provider/homeProvider.dart';
import 'package:Nameless/screens/addDrinkPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

 

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
   String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    CalendarFormat _calendarFormat = CalendarFormat.month;
    DateTime _selectedDay = DateTime.now();
    DateTime _focusedDay = DateTime.now();
    bool isFutureSelected = false; // Track if a future day is selected

    bool _isFutureDay(DateTime day) {
      return day.isAfter(DateTime.now());
    }
  Color textcolor = Colors.black;
  Widget _listView(String date) => ListView.builder(
    shrinkWrap :true,
    controller: ScrollController(),
      itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => AddDrink(date: date,index: index)));}, 
                      icon: const Icon(Icons.edit)),
              title: Text('date: $date',style: TextStyle(color: Colors.white,fontSize: 20)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'quantity: ${Provider.of<HomeProvider>(context, listen: false).dictionaryDrinks[date]![index]['quantity']}',
                      style: TextStyle(color: Colors.white,fontSize: 20),
                      ),
                  Text(
                      'hour: ${Provider.of<HomeProvider>(context, listen: false).dictionaryDrinks[date]![index]['hour']}',
                      style: TextStyle(color: Colors.white,fontSize: 20))
                ],
              ),
              trailing:
                  IconButton(onPressed: () {Provider.of<HomeProvider>(context, listen: false).removeDrink(date, index);}, 
                  icon: const Icon(Icons.delete)),
              tileColor: Color.fromARGB(255, 62, 180, 234),
            ),
          ),
      itemCount: Provider.of<HomeProvider>(context, listen: false)
          .dictionaryDrinks[date]==null ? 0 : (Provider.of<HomeProvider>(context, listen: false)
          .dictionaryDrinks[date]!.length));

  @override
  Widget build(BuildContext context) {


    void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
      if (_isFutureDay(selectedDay)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Future dates cannot be selected.')),
        );
      } else {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
          isFutureSelected = false;
          date = DateFormat('yyyy-MM-dd').format(_selectedDay);
        });
      }
    }
      return SafeArea(
        child: Scaffold(
            
            appBar: AppBar(
             backgroundColor: const Color.fromARGB(255, 71, 169, 248),
              title: const Text('Calendar Page'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: _onDaySelected,
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
                    calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      final drinkProvider = Provider.of<HomeProvider>(context, listen: false);
                      String formattedDate = DateFormat('yyyy-MM-dd').format(day);
                       drinkProvider.sumQuantity(formattedDate);
                      return Center(
                        child: Text(
                          day.day.toString(),
                          style: TextStyle(color: (drinkProvider.calendarColors[formattedDate]!=null)? drinkProvider.calendarColors[formattedDate] : Colors.green),
                        ),
                      );
                    },
                    )
                  ),
                  const SizedBox(height: 20,),
              
                  Consumer<HomeProvider>(
                      builder: (context, drinkProvider, child) {
                    if (drinkProvider.dictionaryDrinks[date] == null) {
                      return const Center(
                          child: Text('Nessun drink aggiunto'));
                    } else {
                      return _listView(date);
                    }
                  }),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 71, 169, 248),
              onPressed: () {_addDrink(_selectedDay);}, 
              child: const Icon(Icons.add),
            )),
      );
    }
    void _addDrink(DateTime _selectedDay) {
    Provider.of<HomeProvider>(context,listen:false).initNumber();
    String date = DateFormat('yyyy-MM-dd').format(_selectedDay);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) =>  AddDrink(date: date )));
  }
  }

