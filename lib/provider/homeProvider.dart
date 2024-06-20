import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  }

  void removeAll(){
      scoreQuiz = -1;
      levelChoice= 0;
      personalData= false;
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