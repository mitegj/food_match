import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'HELLO': 'Hi',
          'DAILY_RECEPY': 'Recepies of the day',
          'SCROLLFORMORE': 'Scroll for view other recepies',
          'EASY': 'Easy',
          'INTERMEDIATE': 'Intermediate',
          'HARD': 'Hard',
          'BREAKFAST': 'Breakfast',
          'STARTER': 'Starter',
          'FIRSTCOURSE': 'First course',
          'SECONDCOURSE': 'Second course',
          'SIDECOURSE': 'Side course',
          'SWEETCOURSE': 'Sweet course',
        },
        'it_IT': {
          'HELLO': 'Ciao',
          'DAILY_RECEPY': 'Ricette del giorno',
          'SCROLLFORMORE': 'Scorri per visualizzare altre ricette',
          'EASY': 'Facile',
          'INTERMEDIATE': 'Intermedio',
          'HARD': 'Difficile',
          'BREAKFAST': 'Colazione',
          'STARTER': 'Antipasto',
          'FIRSTCOURSE': 'Primo',
          'SECONDCOURSE': 'Secondo',
          'SIDECOURSE': 'Contorno',
          'SWEETCOURSE': 'Dolce',
        },
      };
}
