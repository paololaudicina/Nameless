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

  int levelChoice = 0;
  int weight = 0;
  int newHour = DateTime.now().hour;
  double C = 13 * 200 * 0.008;
  double K = 0.66;
  double istantBAL = 0;
  List<int> listNumDrinks = [2, 4, 6, 8, 10];
  String Sex = '';
  bool personalData = false;

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  Map<String, List<Map<String, int>>> dictionaryDrinks = {};
  int number = 1;

  Map<String, int> mapQuantity = {};
  Map<String, Color> calendarColors = {};
  int totalQuantity = 0;

  String soberDateTime = '';
  DateTime? soberTime;
  Timer? _timerSober;
  String _counterText = '0 days, 0 hours, 0 minutes, 0 seconds';
  String get counterText => _counterText;

  String nameUser='';
  String surnameUser='';
  int age=0;



  Timer? _timer;
  DateTime showDate=DateTime.now().subtract(const Duration(days: 1));



  Future<void> initPreferences() async {
    await getPreferences();
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> getPreferences() async {
    final sp = await SharedPreferences.getInstance();

    scoreQuiz = sp.getInt('scoreQuiz') ?? -1;
    numDrinks = listNumDrinks[sp.getInt('answer2') ?? 0];
    Sex = sp.getString('sex') ?? 'sexUser';
    levelChoice = sp.getInt('levelChoice') ?? 0;
    personalData = sp.getBool('personalData') ?? false;
    weight = sp.getInt('weight') ?? 0;
    nameUser = sp.getString('Name')?? 'nameUser';
    surnameUser = sp.getString('Surname') ?? 'surnameUser';
    age = sp.getInt('age') ?? 0;
    if (Sex == 'Male') K = 0.73;
    soberDateTime = sp.getString('soberDateTime') ?? '';

    String? soberTimeString = sp.getString('soberTime');
    if (soberTimeString != null) {
      soberTime = DateTime.parse(soberTimeString);
      _startTimerSober();
    }
  }


  void _startTimerSober() {
    _timerSober
        ?.cancel(); //si cancella il timeSober solo se questo è diverso da null.
    _timerSober = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _updateCounter();
    });
  }


  void _updateCounter() {
    if (soberTime != null) {
      Duration difference = DateTime.now().difference(soberTime!);
      int days = difference.inDays;
      int hours = difference.inHours % 24;
      int minutes = difference.inMinutes % 60;
      int seconds = difference.inSeconds % 60;

      _counterText =
          '$days days, $hours hours, $minutes minutes, $seconds seconds';
      notifyListeners();
    }

   
  }

  Future<void> startCounter() async {
    final sp = await SharedPreferences.getInstance();
    soberTime = DateTime.now();
    String formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(soberTime!);
    sp.setString('soberTime', formattedTime);
    _startTimerSober();
    notifyListeners();
  }

  Future<void> stopCounter() async {
    final sp = await SharedPreferences.getInstance();

    sp.remove('soberTime');
    soberTime = null;
    _counterText = "0 days, 0 hours, 0 minutes, 0 seconds";
    _timer?.cancel();
    notifyListeners();
  }

  void addDrink(String date, int quantity, int hour) {
    Drink drink = Drink(quantity: quantity, hour: hour);
    Map<String, int> mapDrink = drink.toMap();
    if (dictionaryDrinks.containsKey(date)) {
      dictionaryDrinks[date]?.add(mapDrink);

    } else {
      dictionaryDrinks[date] = [mapDrink];
    }

    _saveDrinks();
    sumQuantity(date);
    _updateCalendarColors();
    notifyListeners();
  }

  void removeDrink(String date, int index) {
    dictionaryDrinks[date]?.removeAt(index);
    if (dictionaryDrinks[date]?.isEmpty ?? true) {
      dictionaryDrinks.remove(date);
    }
    _saveDrinks();
    sumQuantity(date);
    _updateCalendarColors();
    notifyListeners();
  }

  void updateDrink(String date, int index, int quantity, int hour) {
    dictionaryDrinks[date]![index]['quantity'] = quantity;
    dictionaryDrinks[date]![index]['hour'] = hour;
    _saveDrinks();
    sumQuantity(date);
    _updateCalendarColors();
    notifyListeners();
  }

  Future<void> _saveDrinks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = jsonEncode(dictionaryDrinks);
    await prefs.setString('drinks', encodedData);
  }

  Future<void> _loadDrinks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? encodedData = prefs.getString('drinks');
    if (encodedData != null) {
      Map<String, dynamic> decodedData = jsonDecode(encodedData);
      dictionaryDrinks = decodedData.map((key, value) => MapEntry(
          key,
          List<Map<String, int>>.from(
            value.map((item) => Map<String, int>.from(item)),
          )));
      _loadTotalQuantity();
      _updateCalendarColors();
      notifyListeners();
    }
  }

  void addNumber() {
    number += 1;
    notifyListeners();
  }

  void removeNumber() {
    if (number > 1) {
      number -= 1;
    }
    notifyListeners();
  }

  void updateNumber(String date, int index) {
    number = dictionaryDrinks[date]![index]['quantity']!;
  }

  void initNumber() {
    number = 1;
  }

  void sumQuantity(String date) {
    totalQuantity = 0;
    if (dictionaryDrinks[date] != null) {
      for (var i = 0; i < dictionaryDrinks[date]!.length; i++) {
        totalQuantity += dictionaryDrinks[date]![i]['quantity']!;
        mapQuantity[date] = totalQuantity;
      }
    } else {
      mapQuantity[date] = 0;
    }
    _updateCalendarColors();
  }

  void _loadTotalQuantity() {
    List<String> keys = dictionaryDrinks.keys.toList();
    for (var element in keys) {
      sumQuantity(element);
    }
  }

  void _updateCalendarColors() {
    calendarColors.clear();
    mapQuantity.forEach((date, quantity) {
      if (quantity > (numDrinks - 1)) {
        calendarColors[date] = Colors.red;
      } else {
        calendarColors[date] = Colors.green; // o un altro colore di default
      }
    });
  }

  double newBAL = 0;
  double oldBAL = 0;
  bool drive = true;
  int deltaT = 0;
  int newDeltaT = 0;

  void alcholLevel(int hour, int quantity) {
    newHour = hour;
    istantBAL = (quantity * C * 1.055) / (weight * K);
    deltaT = DateTime.now().hour - newHour;
    newBAL = istantBAL + (oldBAL - (0.15 * deltaT));
    if (newBAL < 0) newBAL = 0;
    if (newBAL >= 0.5) drive = false;
    oldBAL = newBAL;
    istantBAL = 0;
    newDeltaT = deltaT; // new variable for checking
  }

  // this function update newball when it is called because we want a function of time, without it newBAL is updated only when alcholLevel is used
  // in particular when add drink
  void updateNewBAL() {
    if (newHour != 0) {
      deltaT = DateTime.now().hour - newHour;
      if (deltaT != newDeltaT) {
        int relDeltaT = deltaT - newDeltaT;
        newBAL = oldBAL - (0.15 * relDeltaT);
        if (newBAL < 0) newBAL = 0;
        if (newBAL >= 0.5) drive = false;
        oldBAL = newBAL;
        newDeltaT = deltaT;
      }

      notifyListeners();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 5), (timer) {
      // update newBAL every 5 minutes
      updateNewBAL();
    });
  }

  void removeAll() async {
    final sp = await SharedPreferences.getInstance();
    await sp.remove('refreshToken');
    await sp.remove('accessToken');
    notifyListeners();
  }


// this call the functions when the provider borns, in particular in splash page
  HomeProvider() {
    initPreferences();
    _startTimer();
    _loadDrinks();
    _startTimerSober();
    notifyListeners();
  }

  List<HeartRateData> heartrateData = [];
  bool checkHRData = false;

  void fetchHRData(DateTime giorno) async {
    checkHRData = false;
    heartrateData.clear();
    String day = DateFormat('y-M-d').format(giorno);
    //Get the response
    final data = await Impact().fetchHeartRateData(day);
    if (data != null) {
      for (var i = 0; i < data['data']['data'].length; i++) {
        heartrateData.add(HeartRateData.fromJson(
            data['data']['date'], data['data']['data'][i]));
      } //for

    } //if
    showDate=giorno;
    checkHRData = true;
    notifyListeners();
    
  } //fetchStepData

  void subtractDate(){
    checkHRData = false;
    showDate = showDate.subtract(const Duration(days:1));
    heartrateData.clear();
    fetchHRData(showDate);
    notifyListeners();

  }

  void addDate(){
    checkHRData = false;
    showDate = showDate.add(const Duration(days:1));
    heartrateData.clear();
    fetchHRData(showDate);
    notifyListeners();

  }


  //Method to clear the "memory"
  void clearData() {
    heartrateData.clear();
    notifyListeners();
  } //clearData
}



