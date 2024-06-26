class Drink {
  String name;
  int quantity;
  DateTime time;

  Drink({required this.name, required this.quantity, required this.time});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'time': time.toIso8601String(),
    };
  }

  factory Drink.fromMap(Map<String, dynamic> map) {
    return Drink(
      name: map['name'],
      quantity: map['quantity'],
      time: DateTime.parse(map['time']),
    );
  }
}
