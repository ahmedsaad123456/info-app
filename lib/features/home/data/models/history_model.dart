import 'package:info_app/features/home/domain/entities/history_entity.dart';

class HistoryModel extends HistoryEntity {
  HistoryModel({
    super.result,
    List<SettingModel>? super.settings,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      result: json['result'],
      settings: (json['settings'] as List<dynamic>?)
          ?.map((e) => SettingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'settings': settings?.map((e) => (e as SettingModel).toJson()).toList(),
    };
  }
}

class SettingModel extends SettingEntity {
  SettingModel({
    super.id,
    super.accountId,
    super.key,
    super.value,
  });

  factory SettingModel.fromJson(Map<String, dynamic> json) {
    return SettingModel(
      id: json['id'],
      accountId: json['account_id'],
      key: json['key'],
      value: (json['value'] as String)
          .replaceAll('[', '')
          .replaceAll(']', '')
          .split(',')
          .map((e) => int.parse(e.trim()))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_id': accountId,
      'key': key,
      'value': value.toString(),
    };
  }
}
