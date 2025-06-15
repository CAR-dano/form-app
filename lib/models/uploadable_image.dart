class UploadableImage {
  final String imagePath;
  final String label;
  final bool needAttention;
  final String category;
  final bool isMandatory;

  UploadableImage({
    required this.imagePath,
    required this.label,
    required this.needAttention,
    required this.category,
    required this.isMandatory,
  });

  Map<String, dynamic> toJson() => {
        'label': label,
        'needAttention': needAttention,
        'category': category,
        'isMandatory': isMandatory,
      };
}
