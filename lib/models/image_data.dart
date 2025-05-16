class ImageData {
  String label; // Add label field
  String imagePath;
  String? formId; // To store the ID received after submitting form data

  ImageData({
    required this.label, // Add label to constructor
    required this.imagePath,
    this.formId,
  });

  Map<String, dynamic> toJson() => {
        'label': label,
        'imagePath': imagePath,
        'formId': formId,
      };

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
        label: json['label'],
        imagePath: json['imagePath'],
        formId: json['formId'],
      );
}
