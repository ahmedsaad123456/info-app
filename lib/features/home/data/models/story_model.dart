import 'package:info_app/features/home/domain/entities/story_entity.dart';

class StoryModel extends StoryEntity {
  StoryModel({
    super.id,
    super.name,
    super.preview,
    super.image,
    super.cta,
    super.text,
  });

  StoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    preview = json['preview'];
    image = json['image'];
    cta = json['cta'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['preview'] = preview;
    data['image'] = image;
    data['cta'] = cta;
    data['text'] = text;
    return data;
  }
}

class StoryResponseModel extends StoryResponseEntity {
  StoryResponseModel({
    super.result,
    super.histories,
  });

  StoryResponseModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['histories'] != null) {
      histories = <StoryModel>[];
      json['histories'].forEach((v) {
        histories!.add(StoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    if (histories != null) {
      data['histories'] =
          histories!.map((v) => (v as StoryModel).toJson()).toList();
    }
    return data;
  }
}
