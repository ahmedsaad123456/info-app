import 'package:flutter/material.dart';
import 'package:info_app/core/constants.dart';
import 'package:info_app/features/home/domain/entities/history_entity.dart';
import 'package:info_app/features/home/presentation/widgets/story_widget.dart';

class StoryContainer extends StatelessWidget {
  const StoryContainer(
      {super.key, required this.isWatched, required this.historyModel, required this.histories});

  final bool isWatched;
  final HistoryEntity? historyModel;
  final List<HistoryEntity>? histories;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => StoryWidget(
              histories: histories,
              initialIndex: histories?.indexOf(historyModel!) ?? 0,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: isWatched
              ? Border.all(width: 1.5, color: const Color(0xFFF8206E))
              : null,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                height: 102,
                child: historyModel?.preview == null
                    ? Image.asset('assets/icons/home.png')
                    : Image.network(
                        '$BASE_URL_PREVIEW${historyModel?.preview}',
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    historyModel?.name ?? '',
                    style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
