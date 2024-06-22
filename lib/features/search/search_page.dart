import 'package:flutter/material.dart';
import 'package:info_app/features/search/search_input.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Поиск',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: 32,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SearchInput(),
        ),
        SizedBox(
          height: 32,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          // child: VideoSearch(),
        ),
        SizedBox(
          height: 32,
        ),
        Padding(
          padding: EdgeInsets.only(left: 16),
          // child: CourseSaerch(),
        ),
      ],
    );
  }
}
