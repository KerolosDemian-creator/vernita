class PickedCvModel {
  final String name;
  final String path;
  final int sizeInBytes;

  const PickedCvModel({
    required this.name,
    required this.path,
    required this.sizeInBytes,
  });

  String get sizeLabel {
    final mb = sizeInBytes / (1024 * 1024);
    return mb >= 1
        ? '${mb.toStringAsFixed(1)} MB'
        : '${(sizeInBytes / 1024).toStringAsFixed(0)} KB';
  }
}