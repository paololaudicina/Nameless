import 'package:Nameless/models/drink.dart';
import 'package:flutter/material.dart';


class EditDrinkPage extends StatefulWidget {
  final DateTime selectedDay;
  final Drink? drink;
  final int? index;

  EditDrinkPage({required this.selectedDay, this.drink, this.index});

  @override
  _EditDrinkPageState createState() => _EditDrinkPageState();
}

class _EditDrinkPageState extends State<EditDrinkPage> {
  TextEditingController _nameController = TextEditingController();
  int _quantity = 1;
  int _hour = DateTime.now().hour;

  @override
  void initState() {
    super.initState();
    if (widget.drink != null) {
      _nameController.text = widget.drink!.name;
      _quantity = widget.drink!.quantity;
      _hour = widget.drink!.hour;
    }
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _hour, minute: 0),
    );
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drink == null ? 'Add Drink' : 'Edit Drink'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Drink Name'),
            ),
            Row(
              children: [
                Text('Quantity: $_quantity'),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_quantity > 1) _quantity--;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text('Time: $_hour:00'),
                IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: () async {
                    final picked = await _selectTime(context);
                    if (picked != null) {
                      setState(() {
                        _hour = picked.hour;
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String name = _nameController.text;
                Navigator.of(context).pop({
                  'name': name,
                  'quantity': _quantity,
                  'hour': _hour,
                });
              },
              child: Text(widget.drink == null ? 'Add' : 'Save'),
            ),
          ],
        ),
      ),
    );
  }
}
