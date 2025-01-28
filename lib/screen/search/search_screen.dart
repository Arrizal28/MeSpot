import 'package:flutter/material.dart';
import 'package:mespot/widgets/mespot_header.dart';
import 'package:mespot/widgets/mespot_search_text_field.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            const MespotHeader(
              titleOne: 'What',
              titleTwo: "Are You",
              titleThree: "Looking For?",
            ),
            const SizedBox(height: 20),
            MespotSearchTextField(onSearch: (query) {
              print('User is searching for: $query');
            }),
          ],
        ),
      ),
    );
  }
}
