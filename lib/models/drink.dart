class Drink {
    final int quantity;  
    final int hour;
    final int type;
    
    Drink({required this.quantity,required this.hour,required this.type});

    // method that convert the object Drink in a map  

    Map<String, int> toMap() {
    return {
      'quantity': quantity,
      'hour': hour,
      'type': type 
    };
  }

}

