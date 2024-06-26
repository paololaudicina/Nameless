import 'package:flutter/material.dart';
import 'package:progetto_prova/models/drink.dart';


class EditDrinkPage extends StatefulWidget {
  final DateTime selectedDay;
  final Drink? drink;
  final int? index;

  EditDrinkPage({required this.selectedDay, this.drink, this.index});

  @override
  _EditDrinkPageState createState() => _EditDrinkPageState();
}

class _EditDrinkPageState extends State<EditDrinkPage> {
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _timeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.drink?.name ?? '');
    _quantityController = TextEditingController(text: widget.drink?.quantity.toString() ?? '');
    _timeController = TextEditingController(
      text: widget.drink != null ? widget.drink!.time.toLocal().toString().substring(11, 16) : '',
    );
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final TimeOfDay picked = (await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(widget.drink?.time ?? DateTime.now()),
    ))!;
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
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time (HH:mm)'),
              readOnly: true,
              onTap: () async {
                final TimeOfDay? picked = await _selectTime(context);
                if (picked != null) {
                  final now = DateTime.now();
                  final selectedTime = DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
                  _timeController.text = selectedTime.toLocal().toString().substring(11, 16);
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String name = _nameController.text;
                final int quantity = int.parse(_quantityController.text);
                final DateTime time = DateTime.parse('${widget.selectedDay.toLocal().toIso8601String().split('T').first}T${_timeController.text}:00');

                Navigator.of(context).pop({
                  'name': name,
                  'quantity': quantity,
                  'time': time,
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
