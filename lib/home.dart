import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:profanity_filter/profanity_filter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String url = "";

  void _detectNudity(String url) async {
    final apiurl =
        'https://api.apilayer.com/nudity_detection/url?url=$url';
    final headers = {
      'apikey': "C6VGAV1wi1pmcXoxyZdjZfDhpzNX0Z9V",
    };
    var res = await http.get(Uri.parse(apiurl), headers: headers);
    if (res.statusCode == 200) {
      var snackdemo = SnackBar(
        content: Text(jsonDecode(res.body)["description"]),
        backgroundColor: Colors.blue,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detect NSFW"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (text) {
                bool hasProfanity = ProfanityFilter().hasProfanity(text);
                if (hasProfanity) {
                  var snackdemo = SnackBar(
                    content: Text('Profanity Detected in Word $text'),
                    backgroundColor: Colors.blue,
                    elevation: 10,
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.all(5),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackdemo);
              }
              },
              decoration: const InputDecoration(
                hintText: 'Enter text',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              onChanged: (text) {
                url = text;
              },
              decoration: const InputDecoration(
                hintText: 'Enter Url',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _detectNudity(url);
              },
              child: const Text('Check For Nudity'),
            ),
          ],
        ),
      ),
    );
  }
}
