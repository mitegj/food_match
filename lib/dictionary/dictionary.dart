import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'HELLO': 'Hi',
          'DAILY_RECEPY': 'Recepies of the day',
          'SCROLLFORMORE': 'Scroll for view other recepies',
          'RES': 'AAaaaa'
        },
        'it_IT': {
          'HELLO': 'Ciao',
          'DAILY_RECEPY': 'Ricette del giorno',
          'SCROLLFORMORE': 'Scorri per visualizzare altre ricette'
        },
      };
}
