class InspectionBranch {
  final String id;
  final String city;

  InspectionBranch({required this.id, required this.city});

  factory InspectionBranch.fromJson(Map<String, dynamic> json) {
    return InspectionBranch(
      id: json['id'] as String,
      city: json['city'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'city': city,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InspectionBranch &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
