class Inspector {
  final String id;
  final String name;

  Inspector({required this.id, required this.name});

  @override
  String toString() => name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Inspector &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  factory Inspector.fromJson(Map<String, dynamic> json) {
    return Inspector(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }
}
