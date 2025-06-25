import 'package:uuid/uuid.dart'; // Import uuid

var uuid = const Uuid(); 

class TambahanImageData {
  final String imagePath;
  final String label;
  final bool needAttention;
  final String id;
  final String category;
  final bool isMandatory;
  final int rotationAngle;
  final String originalRawPath; // Renamed from originalImagePath

  TambahanImageData({
    required this.imagePath,
    required this.label,
    required this.needAttention,
    String? id,
    required this.category,
    required this.isMandatory,
    this.rotationAngle = 0,
    required this.originalRawPath, // Renamed in constructor
  }) : id = id ?? uuid.v4();

  TambahanImageData copyWith({
    String? imagePath,
    String? label,
    bool? needAttention,
    String? id,
    String? category,
    bool? isMandatory,
    int? rotationAngle,
    String? originalRawPath, // Renamed in copyWith
  }) {
    return TambahanImageData(
      imagePath: imagePath ?? this.imagePath,
      label: label ?? this.label,
      needAttention: needAttention ?? this.needAttention,
      id: id ?? this.id, 
      category: category ?? this.category,
      isMandatory: isMandatory ?? this.isMandatory,
      rotationAngle: rotationAngle ?? this.rotationAngle,
      originalRawPath: originalRawPath ?? this.originalRawPath, // Renamed in copyWith
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'label': label,
      'needAttention': needAttention,
      'id': id,
      'category': category,
      'isMandatory': isMandatory,
      'rotationAngle': rotationAngle,
      'originalRawPath': originalRawPath, // Renamed in toJson
    };
  }

  factory TambahanImageData.fromJson(Map<String, dynamic> json) {
    return TambahanImageData(
      imagePath: json['imagePath'] as String,
      label: json['label'] as String,
      needAttention: json['needAttention'] as bool,
      id: json['id'] as String? ?? uuid.v4(),
      category: json['category'] as String,
      isMandatory: json['isMandatory'] as bool,
      rotationAngle: json['rotationAngle'] as int? ?? 0,
      originalRawPath: json['originalRawPath'] as String, // Renamed in fromJson
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TambahanImageData &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
