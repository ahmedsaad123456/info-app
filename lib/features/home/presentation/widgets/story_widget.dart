import 'package:flutter/material.dart';
import 'package:info_app/core/constants.dart';
import 'package:info_app/features/home/domain/entities/story_entity.dart';
import 'package:info_app/widget/custom_button.dart';
import 'package:story/story_page_view.dart';

class StoryWidget extends StatefulWidget {
  const StoryWidget(
      {super.key, required this.histories, required this.initialIndex});

  final List<StoryEntity>? histories;
  final int initialIndex;

  @override
  _StoryWidgetState createState() => _StoryWidgetState();
}

class _StoryWidgetState extends State<StoryWidget> {
  late ValueNotifier<IndicatorAnimationCommand> indicatorAnimationController;

  @override
  void initState() {
    super.initState();
    indicatorAnimationController = ValueNotifier<IndicatorAnimationCommand>(
        IndicatorAnimationCommand.resume);
  }

  @override
  void dispose() {
    indicatorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryPageView(
        itemBuilder: (context, pageIndex, storyIndex) {
          return DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      '$BASE_URL_PREVIEW${widget.histories?[storyIndex].preview}',
                    )),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 48, left: 48, right: 48),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.histories?[storyIndex].name ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 48,
                          color: Colors.white),
                    ),
                    Text(
                      widget.histories?[storyIndex].text ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.white.withOpacity(0.94)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                        text: 'Узнать подрбнее',
                        height: 52,
                        color: Colors.white,
                        textColor: Colors.black)
                  ],
                ),
              ));
        },
        indicatorAnimationController: indicatorAnimationController,
        initialStoryIndex: (pageIndex) {
          return widget.initialIndex;
        },
        pageLength: 1,
        storyLength: (int pageIndex) {
          return widget.histories?.length ?? 0;
        },
        onPageLimitReached: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
