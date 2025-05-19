class ImageData {
  String label; // Add label field
  String imagePath;
  bool needAttention;

  ImageData({
    required this.label, // Add label to constructor
    required this.imagePath,
    required this.needAttention,
  });

  Map<String, dynamic> toJson() => {
        'label': label,
        'imagePath': imagePath,
        'needAttention': needAttention,
      };

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        label: json['label'],
        imagePath: json['imagePath'],
        needAttention: json['needAttention'],
      );
}
