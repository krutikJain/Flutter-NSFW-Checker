import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../model/HomeViewModel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detect NSFW'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (text) {
                final viewModel = HomeViewModel();
                viewModel.checkForProfanity(text);
              },
              decoration: const InputDecoration(
                hintText: 'Enter text',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              onChanged: (text) {
                final viewModel = HomeViewModel();
                viewModel.url = text;
              },
              decoration: const InputDecoration(
                hintText: 'Enter Url',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final viewModel = HomeViewModel();
                viewModel.detectNudity();
              },
              child: const Text('Check For Nudity'),
            ),
          ],
        ),
      ),
    );
  }
}
