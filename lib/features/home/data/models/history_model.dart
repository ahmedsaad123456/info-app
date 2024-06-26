import 'package:info_app/features/home/domain/entities/history_entity.dart';

class HistoryModel extends HistoryEntity {
  HistoryModel({
    super.id,
    super.name,
    super.preview,
    super.image,
    super.cta,
    super.text,

  });

  HistoryModel.fromJson(Map<String, dynamic> json) {
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

class HistoryResponseModel extends HistoryResponseEntity {
  HistoryResponseModel({
    super.result,
    super.histories,
  });

  HistoryResponseModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['histories'] != null) {
      histories = <HistoryModel>[];
      json['histories'].forEach((v) {
        histories!.add(HistoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    if (histories != null) {
      data['histories'] = histories!.map((v) => (v as HistoryModel).toJson()).toList();
    }
    return data;
  }
}
