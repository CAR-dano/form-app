import 'package:uuid/uuid.dart'; // Import uuid

var uuid = const Uuid(); 

class TambahanImageData {
  final String imagePath;
  final String label;
  final bool needAttention;
  final String id;
  final String category; // New field
  final bool isMandatory; // New field

  TambahanImageData({
    required this.imagePath,
    required this.label,
    required this.needAttention,
    String? id,
    required this.category, // Add to constructor
    required this.isMandatory, // Add to constructor
  }) : id = id ?? uuid.v4();

  TambahanImageData copyWith({
    String? imagePath,
    String? label,
    bool? needAttention,
    String? id,
    String? category, // Add to copyWith
    bool? isMandatory, // Add to copyWith
  }) {
    return TambahanImageData(
      imagePath: imagePath ?? this.imagePath,
      label: label ?? this.label,
      needAttention: needAttention ?? this.needAttention,
      id: id ?? this.id, 
      category: category ?? this.category, // Add to copyWith
      isMandatory: isMandatory ?? this.isMandatory, // Add to copyWith
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'label': label,
      'needAttention': needAttention,
      'id': id,
      'category': category, // Add to toJson
      'isMandatory': isMandatory, // Add to toJson
    };
  }

  factory TambahanImageData.fromJson(Map<String, dynamic> json) {
    return TambahanImageData(
      imagePath: json['imagePath'] as String,
      label: json['label'] as String,
      needAttention: json['needAttention'] as bool,
      id: json['id'] as String? ?? uuid.v4(),
      category: json['category'] as String, // Add to fromJson
      isMandatory: json['isMandatory'] as bool, // Add to fromJson
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
