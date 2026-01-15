import 'package:form_app/models/inspection_branch.dart';

class UserData {
  final String id;
  final String name;
  final InspectionBranch? inspectionBranchCity;

  UserData({
    required this.id,
    required this.name,
    this.inspectionBranchCity,
  });

  factory UserData.fromAuthResponse(Map<String, dynamic> json) {
    final user = json['user'];
    final inspectionBranchCityData = user['inspectionBranchCity'];
    return UserData(
      id: user['id'],
      name: user['name'],
      inspectionBranchCity: inspectionBranchCityData != null
          ? InspectionBranch.fromJson(inspectionBranchCityData as Map<String, dynamic>)
          : null,
    );
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
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