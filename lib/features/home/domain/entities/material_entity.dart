class MaterialEntity {
  int? id;
  int? courseId;
  String? name;
  String? description;
  String? preview;
  String? filename;

  MaterialEntity({
    this.id,
    this.courseId,
    this.name,
    this.description,
    this.preview,
    this.filename,
  });
}

class MaterialResponseEntity {
  bool? result;
  List<MaterialEntity>? materials;

  MaterialResponseEntity({
    this.result,
    this.materials,
  });
}
