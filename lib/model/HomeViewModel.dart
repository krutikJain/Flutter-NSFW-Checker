import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:profanity_filter/profanity_filter.dart';

class HomeViewModel extends ChangeNotifier {
  String _url = '';

  String get url => _url;

  set url(String value) {
    _url = value;
    notifyListeners();
  }

  Future<void> detectNudity() async {
    final apiurl =
        'https://api.apilayer.com/nudity_detection/url?url=$_url';
    final headers = {
      'apikey': 'C6VGAV1wi1pmcXoxyZdjZfDhpzNX0Z9V',
    };
    var res = await http.get(Uri.parse(apiurl), headers: headers);
    print(res.body);
    if (res.statusCode == 200) {
      final description = jsonDecode(res.body)['description'];
      Fluttertoast.showToast(
          msg: description,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  void checkForProfanity(String text) {
    bool hasProfanity = ProfanityFilter().hasProfanity(text);
    if (hasProfanity) {
      Fluttertoast.showToast(
          msg: 'Profanity Detected in Word $text',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }
}
