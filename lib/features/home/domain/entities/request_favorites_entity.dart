class RequestFavoritesEntity {
  List<int>? materials;
  List<int>? courses;

  RequestFavoritesEntity({
    this.materials,
    this.courses,
  });

  RequestFavoritesEntity.fromJson(Map<String, dynamic> json) {
    materials = json['materials'] != null ? List<int>.from(json['materials']) : null;
    courses = json['courses'] != null ? List<int>.from(json['courses']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['materials'] = materials;
    data['courses'] = courses;
    return data;
  }
}
