import 'dart:async';
import 'dart:convert';


import 'package:Nameless/models/drink.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Nameless/models/heartratedata.dart';
import 'package:Nameless/services/Impact.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {

  int scoreQuiz = -1;
  int numDrinks = 0;
  int levelChoice=0;
  int weight=0;
  int newHour=DateTime.now().hour;
  int prova=0;
  double C= 13*200*0.008;
  double K=0.66;
  double istantBAL=0;
  List<int> listNumDrinks=[2,4,6,8,10];
  String Sex='';
  bool personalData= false;
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  final Map<DateTime, List<Drink>> _drinks = {};
  Map<DateTime, List<Drink>> get drinks => _drinks;

  Future<void> _initPreferences() async {
    await getPreferences();
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> getPreferences() async{

    final sp= await SharedPreferences.getInstance();

     scoreQuiz = sp.getInt('scoreQuiz') ?? -1;
     numDrinks= listNumDrinks[sp.getInt('answer2')?? 0] ;
     Sex = sp.getString('sex')?? '';
     levelChoice=sp.getInt('levelChoice')?? 0;
     personalData = sp.getBool('personalData') ?? false;
     weight=sp.getInt('weight') ?? 0;
     if(Sex=='Male') K=0.73;
    


    // Load drinks
    final String? drinksString = sp.getString('drinks');
    if (drinksString != null) {
      final List<dynamic> decodedDrinks = jsonDecode(drinksString);
      _drinks.clear();
      for (var drinkData in decodedDrinks) {
        final Map<String, dynamic> drinkMap = drinkData.cast<String, dynamic>();
        final List<Drink> drinksList = (drinkMap['drinks'] as List<dynamic>).map<Drink>((item) {
          return Drink.fromMap(item);
        }).toList();
        _drinks[DateTime.parse(drinkMap['date'])] = drinksList;
      }
    }
  }

  Future<void> _saveDrinks() async {
    final sp = await SharedPreferences.getInstance();
    final List<dynamic> encodedDrinks = _drinks.entries.map((entry) {
      final List<Map<String, dynamic>> drinksList = entry.value.map((drink) {
        return drink.toMap();
      }).toList();
      return {
        'date': entry.key.toIso8601String(),
        'drinks': drinksList,
      };
    }).toList();
    sp.setString('drinks', jsonEncode(encodedDrinks));
  }

  void addDrink(DateTime date, String name, int quantity, int hour) {
    final drink = Drink(name: name, quantity: quantity, hour: hour);
    if (_drinks[date] != null) {
      _drinks[date]!.add(drink);
    } else {
      _drinks[date] = [drink];
    }
    prova=quantity;
    alcholLevel(hour, quantity);
    _saveDrinks();
    notifyListeners();
  }

  void updateDrink(DateTime date, int index, String name, int quantity, int hour) {
    final drink = Drink(name: name, quantity: quantity, hour: hour);
    _drinks[date]?[index] = drink;
    alcholLevel(hour, quantity);
    _saveDrinks();
    notifyListeners();
  }
  
  void removeDrink(DateTime date, int index) {
    _drinks[date]?.removeAt(index);
    if (_drinks[date]?.isEmpty ?? true) {
      _drinks.remove(date);
    }
    _saveDrinks();
    notifyListeners();
  }
  
  double newBAL =0;
  double oldBAL=0;
  bool drive=true;
  int deltaT=0;

  void alcholLevel(int hour, int quantity){
    newHour=hour;
    istantBAL=(quantity*C*1.055)/(weight*K);
    int deltaT=DateTime.now().hour-newHour;
    newBAL=istantBAL+(oldBAL-(0.15*deltaT));
    if (newBAL<0) newBAL=0;
    if(newBAL>=0.5) drive=false;
    oldBAL=newBAL;
    istantBAL=0;
  }

  // this function update newball when it is called because we want a function of time, without it newBAL is updated only when alcholLevel is used
  // in particular when add drink
  void updateNewBAL() {
    if (newHour != 0) {
      int deltaT = DateTime.now().hour - newHour;
      newBAL = oldBAL - (0.15 * deltaT);
      if (newBAL < 0) newBAL = 0;
      if (newBAL >= 0.5) drive = false;
      notifyListeners(); // Notifica i listener per aggiornare l'interfaccia utente
    }
  }
 Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      // update newBAL every 5 minutes
      updateNewBAL();
    });
  }

  void removeAll(){
      scoreQuiz = -1;
      levelChoice= 0;
      personalData= false;
      _drinks.clear();
      notifyListeners();
  }
  

  void setPersonaData(bool value){
    personalData = value;
    notifyListeners();
  }
  
  void setLevelChoice(int value){
    levelChoice = value;
    notifyListeners();
  }

// questo chiama la funzione quando il provider nasce con il changeNotifyProvider. Nel caso specifico il provider nasce nella home.
  HomeProvider()  {
    _initPreferences();
    _startTimer();
    notifyListeners();
  }

  

  List<HeartRateData> heartrateData = [];
  
  
  void fetchHRData(DateTime giorno) async {
    giorno = giorno.subtract(const Duration(days: 10));
    String day = DateFormat('y-M-d').format(giorno);
    //Get the response
    final data = await Impact().fetchHeartRateData(day);
    //if OK parse the response adding all the elements to the list, otherwise do nothing
    if (data != null) {
      
      for (var i = 0; i < data['data']['data'].length; i++) {
        heartrateData.add(
            HeartRateData.fromJson(data['data']['date'], data['data']['data'][i]));
      } //for
      //remember to notify the listeners
      notifyListeners();
    }//if 

  }//fetchStepData

  



  //Method to clear the "memory"
  void clearData() {
    heartrateData.clear();
    notifyListeners();
  }//clearData



}
