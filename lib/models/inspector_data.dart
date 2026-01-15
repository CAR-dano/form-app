import 'package:form_app/models/inspection_branch.dart';

class Inspector {
  final String id;
  final String name;
  final InspectionBranch? inspectionBranchCity;

  Inspector({
    required this.id,
    required this.name,
    this.inspectionBranchCity,
  });

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
      inspectionBranchCity: json['inspectionBranchCity'] != null
          ? InspectionBranch.fromJson(json['inspectionBranchCity'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'inspectionBranchCity': inspectionBranchCity?.toJson(),
    };
  }
}
