import 'package:uuid/uuid.dart'; // Import uuid

var uuid = const Uuid(); 

class TambahanImageData {
  final String imagePath;
  final String label;
  final bool needAttention;
  final String id;

  TambahanImageData({
    required this.imagePath,
    required this.label,
    required this.needAttention,
    String? id,
  }) : id = id ?? uuid.v4();

  TambahanImageData copyWith({
    String? imagePath,
    String? label,
    bool? needAttention,
    String? id,
  }) {
    return TambahanImageData(
      imagePath: imagePath ?? this.imagePath,
      label: label ?? this.label,
      needAttention: needAttention ?? this.needAttention,
      id: id ?? this.id, 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'label': label,
      'needAttention': needAttention,
      'id': id,
    };
  }

  factory TambahanImageData.fromJson(Map<String, dynamic> json) {
    return TambahanImageData(
      imagePath: json['imagePath'] as String,
      label: json['label'] as String,
      needAttention: json['needAttention'] as bool,
      id: json['id'] as String? ?? uuid.v4(),
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
