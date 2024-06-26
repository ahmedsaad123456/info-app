class HistoryEntity {
  int? id;
  String? name;
  String? preview;
  String? image;
  String? cta;
  String? text;


  HistoryEntity({
    this.id,
    this.name,
    this.preview,
    this.image,
    this.cta,
    this.text,

  });
}

class HistoryResponseEntity {
  bool? result;
  List<HistoryEntity>? histories;

  HistoryResponseEntity({
    this.result,
    this.histories,
  });
}
