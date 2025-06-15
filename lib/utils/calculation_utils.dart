import 'package:form_app/models/form_data.dart';

/// Calculates the overall rating based on various scores from FormData.
int calculateOverallRating(FormData formData) {
  final int interiorScore = formData.interiorSelectedValue ?? 0;
  final int eksteriorScore = formData.eksteriorSelectedValue ?? 0;
  final int kakiKakiScore = formData.kakiKakiSelectedValue ?? 0;
  final int mesinScore = formData.mesinSelectedValue ?? 0;

  final int sum = interiorScore + eksteriorScore + kakiKakiScore + mesinScore;
  return sum ~/ 4; // Integer division for average
}
