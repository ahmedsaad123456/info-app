class HistoryEntity {
  final bool? result;
  final List<SettingEntity>? settings;

  HistoryEntity({
    this.result,
    this.settings,
  });
}

class SettingEntity {
  final int? id;
  final int? accountId;
  final String? key;
  final List<int>? value;

  SettingEntity({
    this.id,
    this.accountId,
    this.key,
    this.value,
  });
}
