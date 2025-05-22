class ImageData {
  String label; // Add label field
  String imagePath;
  bool needAttention;
  String category; // New field
  bool isMandatory; // New field

  ImageData({
    required this.label, // Add label to constructor
    required this.imagePath,
    required this.needAttention,
    required this.category, // Add to constructor
    required this.isMandatory, // Add to constructor
  });

  Map<String, dynamic> toJson() => {
        'label': label,
        'imagePath': imagePath,
        'needAttention': needAttention,
        'category': category, // Add to toJson
        'isMandatory': isMandatory, // Add to toJson
      };

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        label: json['label'],
        imagePath: json['imagePath'],
        needAttention: json['needAttention'],
        category: json['category'], // Add to fromJson
        isMandatory: json['isMandatory'], // Add to fromJson
      );
}
