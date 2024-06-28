class Drink {
  String name;
  int quantity;
  int hour;

  Drink({required this.name, required this.quantity, required this.hour});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'hour': hour,
    };
  }

  factory Drink.fromMap(Map<String, dynamic> map) {
    return Drink(
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      hour: map['hour'] ?? 0,
    );
  }
}

