class Drink {
    final int quantity;  
    final int hour;
    
    Drink({required this.quantity,required this.hour});

    // method that convert the object Drink in a map  

    Map<String, int> toMap() {
    return {
      'quantity': quantity,
      'hour': hour, 
    };
  }
}

