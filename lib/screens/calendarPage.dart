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
              title: Text('Type: ${(Provider.of<HomeProvider>(context, listen: false).dictionaryDrinks[date]![index]['type']==1)? 'Beer':(Provider.of<HomeProvider>(context, listen: false).dictionaryDrinks[date]![index]['type']==2)? 'Wine':'Cocktail'}',style: TextStyle(color: Colors.white,fontSize: 20)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start, 
                children: [
                  Text(
                      'Quantity: ${Provider.of<HomeProvider>(context, listen: false).dictionaryDrinks[date]![index]['quantity']}',
                      style: TextStyle(color: Colors.white,fontSize: 20),
                      ),
                  Text(
                      'Hour: ${Provider.of<HomeProvider>(context, listen: false).dictionaryDrinks[date]![index]['hour']}',
                      style: TextStyle(color: Colors.white,fontSize: 20))
                ],
              ),
              trailing:
                  IconButton(onPressed: () {Provider.of<HomeProvider>(context, listen: false).removeDrink(date, index);}, 
                  icon: const Icon(Icons.delete)),
              tileColor: Colors.blue,
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
             backgroundColor: Colors.blue,
              title: const Text('Calendar Page',style: TextStyle(fontSize: 35,color:Colors.white)),
              actions: [IconButton(onPressed: () {
               
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                          content: Container(
                              height:220,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Explanation',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    const SizedBox(height: 10),
                                    const Text(
                                      'In this page you can add, modify or remove drink. The day colored green means you are under the limit. If you overcome the limit, you will see it colored red. If you have not added any drinks, you will see the day colored black',
                                      
                                      textAlign: TextAlign.left,
                                    ),
                                    
                                    const SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Ok'),
                                    )
                                  ]))));
                

              },
               icon: Icon(Icons.info))],
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
            
                      return Center(
                        child: Text(
                          day.day.toString(),
                          style: TextStyle(color: (drinkProvider.calendarColors[formattedDate]!=null)? drinkProvider.calendarColors[formattedDate] : Colors.black),
                        ),
                      );
                    },
                    selectedBuilder: (context,day,focusedDay) {
                      return Container(
                        margin: const EdgeInsets.all(4),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text('${day.day}',style:TextStyle(color:Colors.white))
                      );
                    },
                    todayBuilder: (context,day,focusedDay) {
                      return Opacity(
                        opacity: 0.5,
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text('${day.day}',style:TextStyle(color:Colors.white))
                        ),
                      );
                    }
                    )
                  ),
                  const SizedBox(height: 20,),
              
                  Consumer<HomeProvider>(
                      builder: (context, drinkProvider, child) {
                    if (drinkProvider.dictionaryDrinks[date] == null) {
                      return const Center(
                          child: Text('No drinks added',style:TextStyle(fontSize: 17)));
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

