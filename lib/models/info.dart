import 'package:Nameless/provider/homeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


Future<void> levelExplanation(BuildContext context){
  return   showGeneralDialog(

    
              context: context,
              barrierDismissible: false,
              barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
              barrierColor: Colors.black54,
              transitionDuration: Duration(milliseconds: 300),
              pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
                return Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: 50,bottom: 50, left: 20, right: 20),
                    height: MediaQuery.of(context).size.height * 0.55,
                    decoration:BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)
                    ),
                    
                    child:  Material(
                      color: Colors.transparent,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child:  Consumer<HomeProvider>(builder: (context, data, child) {
                            if(data.levelChoice==1){
                            return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              
                              const Text(
                                'Soft Level Explanation',
                                style: TextStyle(fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20,),
                              Image.asset('images/soft_piuma.png',height: 60,width: 60,),
                              const SizedBox(height: 20,),
                               Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'The goal of the soft level is to reduce daily alcohol consumption. To do that, this level use your answer to question number 2. In particular, the app memorizes your answer and calculate your daily drink limit as your answer minus one. For example, if your answer is 3/4 drinks at day with this level you can drink a maximum of 3 drinks ( 4 - 1 ).Your current limit is : ${(data.limit==null)? (data.numDrinks-1):data.limit}. If you want to change the limit, go to profile ',  
                                  
                                ),
                              ),
                              const SizedBox(height: 10,),
                              ElevatedButton(onPressed: () {
                               Navigator.pop(context);
                              }, 
                              child: 
                              const Text('I Got it')
                              )
                            ],
                          );}
                          else if(data.levelChoice==2){
                            return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Hard Level Explanation',
                                style: TextStyle(fontSize: 24.0, color: Colors.black,fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 20,),
                              Image.asset('images/fire.png',height: 60,width: 60,),
                              const SizedBox(height: 20,),
                              const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'The goal of the hard level is to delete daily alcohol consumption. At this level you need determination, perseverance and sincerity. In fact, in this level you cannot drink. You will have a counter that will tell you how long it has been since you drank. If you drink, you must restart the counter',  
                                  
                                ),
                              ),
                              const SizedBox(height: 10,),
                              ElevatedButton(onPressed: () {
                               Navigator.pop(context);
                              }, 
                              child: 
                              const Text('I Got it')
                              )
                            ],
                          );
                          }
                          
                          else{
                          return CircularProgressIndicator();
                          }}),

                          
                        ),
                      ),
                    ),
                  ),
                );

              }, 
              );
}
