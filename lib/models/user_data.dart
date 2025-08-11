class UserData {
  final String id;
  final String name;
  //final String inspectionBranchCityId;
  //final String inspectionBranchCityName;

  UserData({
    required this.id,
    required this.name,
    //required this.inspectionBranchCityId,
    //required this.inspectionBranchCityName,
  });

  factory UserData.fromAuthResponse(Map<String, dynamic> json) {
    final user = json['user'];
    //final inspectionBranchCity = user['inspectionBranchCity'];
    return UserData(
      id: user['id'],
      name: user['name'],
      //inspectionBranchCityId: inspectionBranchCity['id'],
      //inspectionBranchCityName: inspectionBranchCity['city'],
    );
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      //inspectionBranchCityId: json['inspectionBranchCityId'],
      //inspectionBranchCityName: json['inspectionBranchCityName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      //'inspectionBranchCityId': inspectionBranchCityId,
      //'inspectionBranchCityName': inspectionBranchCityName,
    };
  }
}