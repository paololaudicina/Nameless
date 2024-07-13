import 'package:flutter/material.dart';
import 'package:Nameless/provider/homeProvider.dart';
import 'package:Nameless/screens/homeHardPage.dart';
import 'package:Nameless/screens/homeSoftPage.dart';
import 'package:Nameless/screens/personalData.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashQuiz extends StatefulWidget {
  final int score;
  const SplashQuiz({required this.score});

  @override
  State<SplashQuiz> createState() => _SplashQuizState();
}

class _SplashQuizState extends State<SplashQuiz> {
  late int score;
  @override
  void initState() {
    super.initState();
    score = widget.score;
  }
  
  Future<void> _softChoice(bool personalData) async {
    final sp = await SharedPreferences.getInstance();
        await sp.setInt('levelChoice',1);
        Provider.of<HomeProvider>(context,listen:false).getPreferences();
    
         if(!personalData){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PersonalData()));
        } else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeSoftPage()));
          }

    
  }

  Future<void> _hardChoice(bool personalData) async {
    final sp = await SharedPreferences.getInstance();
        await sp.setInt('levelChoice',2);
        Provider.of<HomeProvider>(context,listen:false).getPreferences();
        
    if(!personalData){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PersonalData()));
        } else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeHardPage()));
          }

  }


  
  @override
  Widget build(BuildContext context) {
    bool personalData = Provider.of<HomeProvider>(context,listen: false).personalData;
    
    return Scaffold(
      body: Center(
          child: Consumer<HomeProvider>(builder: (context, provider, child) {
        if (score < 4) {
          return Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:70),
                  height: 150,
                  width: 150,
                  child: Image.asset('images/soft_piuma.png'),
                ),
                Container(
                  child: Text('Your recommended level is Soft',
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                ),
                Container(
                  margin: EdgeInsets.only(top:70, left:40, right:40, bottom:40),
                  child: Text('Your responses have indicated that you are not a habitual alcohol consumer. This level is suitable for you if you want to reduce or completely eliminate alcohol from your life.')),
                
                SizedBox(
                  height: 30,
                  child: Text('Choise your level'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      child: InkWell(
                        onTap: () => _softChoice(personalData),
                        child: Card(
                          
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Soft', style: TextStyle(fontSize: 28)),
                              Image.asset('images/soft_piuma.png',height: 40,width: 40,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      child: InkWell(
                        onTap: () => _hardChoice(personalData),
                        child: Card(
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Hard', style: TextStyle(fontSize: 28)),
                              Image.asset('images/fire.png',height: 40,width: 40,),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
    
    
              ]
              );
        } else {
          return Column(
              children: [
                Container(
                   margin: EdgeInsets.only(top:70),
                  height: 150,
                  width: 150,
                  child: Image.asset('images/fire.png'),
                ),
                Container(
                  child: Text('Your recommended level is Hard',style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                ),
                Container(
                  margin: EdgeInsets.only(top:70, left:40, right:40, bottom:40),
                  child: Text('Your responses have indicated that you are a habitual alcohol consumer. This level is suitable for you to manage and gradually reduce your alcohol habits.')
                ),
                
                SizedBox(
                  height: 30,
                  child: Text('Choise your level'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      child: InkWell(
                        onTap: () => _softChoice(personalData),
                        child: Card(
                          
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Soft', style: TextStyle(fontSize: 28)),
                              Image.asset('images/soft_piuma.png',height: 40,width: 40,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      child: InkWell(
                        onTap: () => _hardChoice(personalData),
                        child: Card(
                          child:Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Hard', style: TextStyle(fontSize: 28)),
                              Image.asset('images/fire.png',height: 40,width: 40,),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ]
              );
        }}),
      ),
    );
  }
}