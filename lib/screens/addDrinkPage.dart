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
  int hour = -1;
  int? selectedDrink;

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
      selectedDrink = drink['type'];
      Provider.of<HomeProvider>(context, listen: false)
          .updateNumber(widget.date, widget.index!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Add Drink Page',style:TextStyle(fontSize: 30,color: Colors.white)),
            backgroundColor: Colors.blue,
            actions: [
              IconButton(
                  onPressed: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AlertDialog(
                            content: Container(
                                height: 300,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text('Explaination',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18)),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'In this page you can add or modify your drinks. In according to the selcted drink, your alchool level is calculated. Keep in mind: ',
                                        style: TextStyle(fontSize: 17),
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Text('Beer : 330 mL and 6 %'),
                                      const Text('Wine : 125 mL and 12 %'),
                                      const Text('Cocktail : 200 mL and 18 %'),
                                      const SizedBox(height: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Ok'),
                                      )
                                    ]))));
                  },
                  icon: const Icon(Icons.info))
            ]),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Radio<int>(
                value: 1,
                groupValue: selectedDrink,
                onChanged: (int? value) {
                  setState(() {
                    selectedDrink = value;
                  });
                },
              ),
              Image.asset('images/beer.png',width: 40,height : 40),
              Radio<int>(
                  value: 2,
                  groupValue: selectedDrink,
                  onChanged: (int? value) {
                    setState(() {
                      selectedDrink = value;
                    });
                  }),
              Image.asset('images/wine-glass.png',width: 40,height : 40 ),
              Radio<int>(
                  value: 3,
                  groupValue: selectedDrink,
                  onChanged: (int? value) {
                    setState(() {
                      selectedDrink = value;
                    });
                  }),
              Image.asset('images/cocktail.png',width: 40,height : 40),
            ]),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'How many?',
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
                const SizedBox(
                  width: 15,
                ),
                Consumer<HomeProvider>(
                  builder: (context, provider, child) {
                    return Text(
                      '${provider.number}',
                      style: const TextStyle(fontSize: 30),
                    );
                  },
                ),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {
                    Provider.of<HomeProvider>(context, listen: false)
                        .addNumber();
                  },
                  icon: const Icon(Icons.add, size: 30),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
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
                const Text(
                  'What time?',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedDrink != null) {
                  if (widget.index != null) {
                    if (widget.date ==
                            DateFormat('yyyy-MM-dd').format(DateTime.now()) &&
                        hour == -1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'you forgot to select the hour or you selcted a future hour')), //scaffoldMessage when the day is today and user selected an future hour
                      );
                    } else {
                      _updateDrink();
                    }
                  } else {
                    if (hour != -1) {
                      _addDrink(hour);
                    } else {
                      if (widget.date ==
                          DateFormat('yyyy-MM-dd').format(DateTime.now())) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'you forgot to select the hour or you selcted a future hour')), //scaffoldMessage when the day is today and user selected a future hour
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'You must choose the hour'))); //scaffoldMessage when the user don't selected an hour
                      }
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('You must choose the type of drink')));
                }
              },
            style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15),
                            
                          ),
              child: (widget.index != null)
                  ? const Text('MODIFY',style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                  : const Text('ADD',style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
            ),
            )
          ],
        
        ),
      ),
    );
  }

  void _addDrink(int hour) {
    quantity = Provider.of<HomeProvider>(context, listen: false).number;
    Provider.of<HomeProvider>(context, listen: false)
        .addDrink(date, quantity, hour, selectedDrink!);
    Provider.of<HomeProvider>(context, listen: false).updateBAL();
    Navigator.pop(context);
  }

  void _updateDrink() {
    quantity = Provider.of<HomeProvider>(context, listen: false).number;
    Provider.of<HomeProvider>(context, listen: false).updateDrink(
        widget.date, widget.index!, quantity, hour, selectedDrink!);
    Provider.of<HomeProvider>(context, listen: false).updateBAL();
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
          hour = -1;
        });
      } else {
        setState(() {
          hour = pickedTime.hour;
        });
      }
    } else {
      setState(() {
        hour = -1;
      });
    }
  }
}
