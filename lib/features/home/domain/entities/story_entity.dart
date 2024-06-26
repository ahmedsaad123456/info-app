class StoryEntity {
  int? id;
  String? name;
  String? preview;
  String? image;
  String? cta;
  String? text;

  StoryEntity({
    this.id,
    this.name,
    this.preview,
    this.image,
    this.cta,
    this.text,
  });
}

class StoryResponseEntity {
  bool? result;
  List<StoryEntity>? histories;

  StoryResponseEntity({
    this.result,
    this.histories,
  });
}
