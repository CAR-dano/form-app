class ImageData {
  String label; // Add label field
  String imagePath;
  String? formId; // To store the ID received after submitting form data

  ImageData({
    required this.label, // Add label to constructor
    required this.imagePath,
    this.formId,
  });
}
