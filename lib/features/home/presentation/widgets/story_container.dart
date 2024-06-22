import 'package:flutter/material.dart';
import 'package:info_app/features/home/presentation/widgets/story_widget.dart';

class StoryContainer extends StatelessWidget {
  const StoryContainer({super.key, required this.isWatched});

  final bool isWatched;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute<void>(
        //     builder: (BuildContext context) => StoryWidget(),
        //   ),
        // );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: isWatched
                  ? Border.all(width: 1.5, color: const Color(0xFFF8206E))
                  : null,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset('assets/icons/home.png'),
            ),
          ),
          const Positioned(
            bottom: 10,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Обновление \n2.0',
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
