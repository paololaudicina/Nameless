import 'Questions.dart';
import 'Options.dart';

class Quiz{
  //This class acts as data repository for the questions, their answers and the relative answers' scores.

  final List<Question> quiz = [
    //question number 1
    Question(
      title: 'How often do you drink alcohol?', 
      options: Options(
                answer: [
                  'Never','Less than once per month','2-4 times per month','2-3 times per week','4 or more times per week'
                ]
         ,      score: [0,1,2,3,4]),
         ),
    //question number 2
    Question(
      title: 'How munch alcohol do you drink on average per day?', 
      options: Options(
                answer: [
                  '1 or 2 drinks','3 or 4 drinks','5 or 6 drinks','7 or 8 drinks','10 or more drinks'
                ]
         ,      score: [0,1,2,3,4]),
         ),
    //question number 3
    Question(
      title: 'How often do you drink more than six drinks at once time?', 
      options: Options(
                answer: [
                  'Never','Less than once per month','Once time per month','Once time per week','Every day'
                ]
         ,      score: [0,1,2,3,4]),
         ),
    //question number 4
  ];
}