class ImageData {
  String label; // Add label field
  String imagePath;
  bool needAttention;
  String category;
  bool isMandatory;
  int rotationAngle;
  String originalRawPath; // New field for original raw image path

  ImageData({
    required this.label,
    required this.imagePath,
    required this.needAttention,
    required this.category,
    required this.isMandatory,
    this.rotationAngle = 0,
    String? originalRawPath, // Make it optional in constructor
  }) : originalRawPath = originalRawPath ?? imagePath; // Default to imagePath if not provided

  ImageData copyWith({
    String? label,
    String? imagePath,
    bool? needAttention,
    String? category,
    bool? isMandatory,
    int? rotationAngle,
    String? originalRawPath,
  }) {
    return ImageData(
      label: label ?? this.label,
      imagePath: imagePath ?? this.imagePath,
      needAttention: needAttention ?? this.needAttention,
      category: category ?? this.category,
      isMandatory: isMandatory ?? this.isMandatory,
      rotationAngle: rotationAngle ?? this.rotationAngle,
      originalRawPath: originalRawPath ?? this.originalRawPath,
    );
  }

  Map<String, dynamic> toJson() => {
        'label': label,
        'imagePath': imagePath,
        'needAttention': needAttention,
        'category': category,
        'isMandatory': isMandatory,
        'rotationAngle': rotationAngle,
        'originalRawPath': originalRawPath, // Add to toJson
      };

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        label: json['label'],
        imagePath: json['imagePath'],
        needAttention: json['needAttention'],
        category: json['category'],
        isMandatory: json['isMandatory'],
        rotationAngle: json['rotationAngle'] ?? 0,
        originalRawPath: json['originalRawPath'] ?? json['imagePath'], // Default to imagePath if not found
      );
}
