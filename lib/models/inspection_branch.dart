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
}
