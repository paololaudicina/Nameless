import 'package:flutter/material.dart';
import 'package:Nameless/provider/homeProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddDrink extends StatefulWidget {
  final String date;
  final int? index;

  const AddDrink({super.key, required this.date, this.index});

  @override
  State<AddDrink> createState() => _AddDrinkState();
}

class _AddDrinkState extends State<AddDrink> {
  int quantity = 0;
  int hour = 0;

  late String date;

  @override
  void initState() {
    super.initState();
    date = widget.date;
    if (widget.index != null) {
      Map<String, int> drink = Provider.of<HomeProvider>(context, listen: false)
          .dictionaryDrinks[date]![widget.index!];
      quantity = drink['quantity']!;
      hour = drink['hour']!;
      Provider.of<HomeProvider>(context, listen: false)
          .updateNumber(widget.date, widget.index!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Drink Page')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'How many drinks?',
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Provider.of<HomeProvider>(context, listen: false)
                      .removeNumber();
                },
                icon: const Icon(Icons.remove, size: 30),
              ),
              const SizedBox(width: 15,),
              Consumer<HomeProvider>(
                builder: (context, provider, child) {
                  return Text(
                    '${provider.number}',
                    style: const TextStyle(fontSize: 30),
                  );
                },
              ),
              const SizedBox(width: 15,),
              IconButton(
                onPressed: () {
                  Provider.of<HomeProvider>(context, listen: false).addNumber();
                },
                icon: const Icon(Icons.add, size: 30),
              ),
              
            ],
          ),
          const SizedBox(height: 30,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              IconButton(
                    onPressed: () {
                      _selectedHour();
                    },
                    icon: const Icon(Icons.access_time_outlined, size: 40),
                  ),
                  const Text('What time?',style: TextStyle(fontSize: 20),),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              if (widget.index != null) {
                _updateDrink();
              } else {
                if (hour != 0) {
                  _addDrink();
                } else {
                  if (widget.date == DateFormat('yyyy-MM-dd').format(DateTime.now()) ){
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('you forgot to select the hour or you selcted a future hour')), //scaffoldMessage when the day is today and user selected an future hour  
                  );

                  }else {
                    ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('You must choose the hour')));//scaffoldMessage when the user don't selected an hour
                  }
                  
                }
              }
            },
            child: (widget.index != null)
                ? const Text('Modify')
                : const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _addDrink() {
    quantity = Provider.of<HomeProvider>(context, listen: false).number;
    Provider.of<HomeProvider>(context, listen: false)
        .addDrink(date, quantity, hour);
    Navigator.pop(context);
  }

  void _updateDrink() {
    quantity = Provider.of<HomeProvider>(context, listen: false).number;
    Provider.of<HomeProvider>(context, listen: false)
        .updateDrink(widget.date, widget.index!, quantity, hour);
    Navigator.pop(context);
  }

  Future<void> _selectedHour() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute),
    );

    if (pickedTime != null) {
      // if the day is today you can't add drink after the now's hour
      if (date == DateFormat('yyyy-MM-dd').format(DateTime.now()) &&
          pickedTime.hour > DateTime.now().hour) {
        setState(() {
          hour = 0;
        });
      } else {
        setState(() {
          hour = pickedTime.hour;
        });
      }
    } else {
      setState(() {
        hour = 0;
      });
    }
  }
}
