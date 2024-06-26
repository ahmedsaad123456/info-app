import 'package:flutter/material.dart';
import 'package:info_app/features/home/domain/entities/history_entity.dart';
import 'package:info_app/features/home/presentation/widgets/story_container.dart';

class StoryListView extends StatelessWidget {
  const StoryListView({
    super.key, required this.histories,
  });

  final List<HistoryEntity>? histories;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 102,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: histories?.length ?? 0,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 8),
            child: AspectRatio(
                aspectRatio: 1,
                child: StoryContainer(
                  historyModel: histories?[index],
                  isWatched: true,
                  histories: histories, // Pass the entire list here
                )),
          );
        },
      ),
    );
  }
}
