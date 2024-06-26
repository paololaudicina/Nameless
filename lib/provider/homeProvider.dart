import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progetto_prova/models/drink.dart';
import 'package:progetto_prova/models/heartratedata.dart';
import 'package:progetto_prova/services/Impact.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {

  int scoreQuiz = -1;
  int numDrinks = 0;
  int levelChoice=0;
  List<int> listNumDrinks=[2,4,6,8,10];
  String Sex='';
  bool personalData= false;
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  DateTime giorno = DateTime.now();

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
    // notifyListeners();


    // Load drinks
    final String? drinksString = sp.getString('drinks');
    if (drinksString != null) {
      final List<dynamic> decodedDrinks = jsonDecode(drinksString);
      _drinks.clear();
      decodedDrinks.forEach((drinkData) {
        final Map<String, dynamic> drinkMap = drinkData.cast<String, dynamic>();
        final List<Drink> drinksList = drinkMap['drinks'].map<Drink>((item) {
          return Drink.fromMap(item);
        }).toList();
        _drinks[DateTime.parse(drinkMap['date'])] = drinksList;
      });
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

  void addDrink(DateTime date, String name, int quantity, DateTime time) {
    final drink = Drink(name: name, quantity: quantity, time: time);
    if (_drinks[date] != null) {
      _drinks[date]!.add(drink);
    } else {
      _drinks[date] = [drink];
    }
    _saveDrinks();
    notifyListeners();
  }

  void updateDrink(DateTime date, int index, String name, int quantity, DateTime time) {
    final drink = Drink(name: name, quantity: quantity, time: time);
    _drinks[date]?[index] = drink;
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

  void removeAll(){
      scoreQuiz = -1;
      levelChoice= 0;
      personalData= false;
      _drinks.clear();
      notifyListeners();

      /* Future<void> removeAll() async {  suggerito da chat gpt
    final sp = await SharedPreferences.getInstance();
    await sp.remove('punteggio');
    await sp.remove('answer2');
    await sp.remove('sex');
    await sp.remove('level_choice');
    await sp.remove('datiPersonali');
    flag_punteggio = -1;
    level_choice_flag = 0;
    datiPersonali_flag = false;
    notifyListeners();*/
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