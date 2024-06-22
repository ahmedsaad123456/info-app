import 'package:flutter/material.dart';
import "package:story_view/story_view.dart";

class StoryWidget extends StatelessWidget {
  StoryWidget({super.key});
  final controller = StoryController();

  @override
  Widget build(context) {
    List<StoryItem> storyItems = [
      StoryItem.inlineImage(
        
          url: 'assets/icons/home.png', controller: controller , caption: Text('home')),
      StoryItem.inlineImage(
          url: 'assets/icons/home.png', controller: controller,caption: Text('home')),
      StoryItem.inlineImage(
          url: 'assets/icons/home.png', controller: controller,caption: Text('home')),
      StoryItem.inlineImage(
          url: 'assets/icons/home.png', controller: controller,caption: Text('home')),
    ]; // your list of stories

    return StoryView(
        storyItems: storyItems,
        controller: controller, // pass controller here too
        repeat: true, // should the stories be slid forever
        onStoryShow: (storyItem, index) {},
        onComplete: () {},
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Navigator.pop(context);
          }
        } // To disable vertical swipe gestures, ignore this parameter.
        // Preferrably for inline story view.
        );
  }
}
