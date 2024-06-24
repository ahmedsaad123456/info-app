import 'package:flutter/material.dart';
import 'package:info_app/features/home/presentation/widgets/story_container.dart';

class StoryListView extends StatelessWidget {
  const StoryListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 102,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 15,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(right: 8),
            child: AspectRatio(
                aspectRatio: 1,
                child: StoryContainer(
                  isWatched: true,
                )),
          );
        },
      ),
    );
  }
}
