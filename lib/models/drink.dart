class Drink {
  String name;
  int quantity;
  int hour;

  Drink({required this.name, required this.quantity, required this.hour});

  //La classe Drink è stata definita con tre proprietà: name, quantity e hour. 
  //La classe include un metodo toMap per convertire un'istanza di Drink in una mappa, 
  //e un costruttore fromMap per creare un'istanza di Drink da una mappa.

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'hour': hour,
    };
  }

  // In Dart, la keyword factory viene utilizzata per definire un costruttore factory. 
  //Un costruttore factory è un tipo di costruttore che non necessariamente crea una nuova istanza della classe 
  //ogni volta che viene chiamato. Invece, può restituire un'istanza esistente o un'istanza di una sottoclasse

  factory Drink.fromMap(Map<String, dynamic> map) {
    return Drink(
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      hour: map['hour'] ?? 0,
    );
  }
}

