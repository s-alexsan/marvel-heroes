import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

Future<Map<String, dynamic>> getJson() async {
  String json = await rootBundle.loadString('assets/application.json');
  return jsonDecode(json);
}

String translate(String category) {
  String result;
  switch (category) {
    case 'heroes':
      result = 'Heróis';
      break;
    case 'villains':
      result = 'Vilões';
      break;
    case 'antiHeroes':
      result = 'Anti-heróis';
      break;
    case 'aliens':
      result = 'Alienígenas';
      break;
    case 'humans':
      result = 'Humanos';
      break;
    case 'force':
      result = 'Força';
      break;
    case 'intelligence':
      result = 'Inteligênica';
      break;
    case 'agility':
      result = 'Agilidade';
      break;
    case 'endurance':
      result = 'Resistência';
      break;
    case 'velocity':
      result = 'Velocidade';
      break;
    default:
      result = '';
      break;
  }
  return result;
}

String convertYear2Age(String year) {
  String result = "";
  DateTime now = DateTime.now();
  result = (now.year - int.parse(year)).toString();
  return result;
}
