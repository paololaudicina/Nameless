import 'package:flutter/material.dart';
import 'package:Nameless/models/Quiz.dart';
import 'package:Nameless/provider/homeProvider.dart';
import 'package:Nameless/screens/advice.dart';
import 'package:Nameless/screens/homeHardPage.dart';
import 'package:Nameless/screens/homeSoftPgae.dart';
import 'package:Nameless/screens/personalData.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Questionnaire extends StatefulWidget {
  const Questionnaire({super.key});

  @override
  State<Questionnaire> createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  final _quiz = Quiz();
  Map<int, int?> _selectedIndexMap = {};
  List<bool> answer = [false, false, false];
  int score = 0;

  Future<void> _changeColor(int quizIndex, int optionIndex) async {
    setState(() {
      // Check if there was a previous selection
      if (_selectedIndexMap.containsKey(quizIndex)) {
        // If yes, subtract the score of the previous selection
        int previousOptionIndex = _selectedIndexMap[quizIndex]!;
        score -= _quiz.quiz[quizIndex].options.score[previousOptionIndex];
      }

      // Update the selection
      _selectedIndexMap[quizIndex] = optionIndex;

      // Add the score of the new selection
      score += _quiz.quiz[quizIndex].options.score[optionIndex];
      print(score);
      answer[quizIndex] = true;
    });

    if (quizIndex == 1) {
      final sp = await SharedPreferences.getInstance();
      await sp.setInt('answer2', optionIndex);
    }
  }

  Widget _listView(int quizIndex) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        bool isSelected = _selectedIndexMap[quizIndex] == index;
        return Container(
          decoration: BoxDecoration(
            color: isSelected
                ? Color.fromARGB(255, 167, 226, 240)
                : Color.fromARGB(255, 55, 115, 245),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          margin: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(
              _quiz.quiz[quizIndex].options.answer[index],
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => _changeColor(quizIndex, index),
          ),
        );
      },
      itemCount: _quiz.quiz[quizIndex].options.answer.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    int levelChoice =
        Provider.of<HomeProvider>(context, listen: false).levelChoice;
    bool personalData =
        Provider.of<HomeProvider>(context, listen: false).personalData;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 167, 226, 240),
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('AUDIT TEST',
                  style: TextStyle(fontSize: 40, color: Colors.white)),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 167, 226, 240),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  color: Color.fromARGB(255, 89, 139, 247),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _quiz.quiz[0].title,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: SizedBox(
                            height: 450,
                            child: _listView(0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  color: Color.fromARGB(255, 41, 107, 249),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 50, left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_quiz.quiz[1].title,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white)),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: SizedBox(
                            height: 450,
                            child: _listView(1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Card(
                  color: Color.fromARGB(255, 41, 107, 249),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_quiz.quiz[2].title,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white)),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: SizedBox(
                            height: 450,
                            child: _listView(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (answer.contains(false)) {
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(const SnackBar(
                        content: Text('Missing answers'),
                      ));
                  } else {
                    final sp = await SharedPreferences.getInstance();
                    Provider.of<HomeProvider>(context, listen: false).setScore(score);  
                    if (levelChoice != 0) {
                      if (personalData) {
                        if (levelChoice == 1) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeSoftPage()));
                        } else {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeHardPage()));
                        }
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PersonalData()));
                      }
                    } else {
                      await sp.setInt('scoreQuiz', score);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SplashQuiz(
                                    score: score,
                                  )));
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 41, 107, 249),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      side: BorderSide(color: Colors.black)),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
