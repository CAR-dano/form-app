import 'package:dio/dio.dart' as dio; // Add prefix
import 'package:form_app/models/form_data.dart';

class ApiService {
  final dio.Dio _dio = dio.Dio(); // Use prefix
  final String _baseUrl = 'http://31.220.81.182/api/v1/inspections'; // Your API endpoint

  Future<void> submitFormData(FormData formData) async {
    try {
      final response = await _dio.post(
        _baseUrl,
        data: {
          "id": "YOUR_GENERATED_OR_FETCHED_ID", // TODO: Generate or get ID
          "submittedByUserId": null, // TODO: Get user ID
          "vehiclePlateNumber": formData.platNomor,
          "inspectionDate": formData.tanggalInspeksi?.toIso8601String(),
          "overallRating": null, // TODO: Get overall rating from form data
          "identityDetails": {
              "namaCustomer": formData.namaCustomer,
              "namaInspektor": formData.namaInspektor,
              "cabangInspeksi": formData.cabangInspeksi
          },
          "vehicleData": {
              "tahun": int.tryParse(formData.tahun),
              "odometer": int.tryParse(formData.odometer),
              "platNomor": formData.platNomor,
              "transmisi": formData.transmisi,
              "biayaPajak": int.tryParse(formData.biayaPajak),
              "kepemilikan": formData.kepemilikan,
              "pajak1Tahun": formData.pajak1TahunDate?.toIso8601String().split('T')[0],
              "pajak5Tahun": formData.pajak5TahunDate?.toIso8601String().split('T')[0],
              "tipeKendaraan": formData.tipeKendaraan,
              "merekKendaraan": formData.merekKendaraan,
              "warnaKendaraan": formData.warnaKendaraan
          },
          "equipmentChecklist": {
              "bpkb": formData.bpkp == 'Ada',
              "noMesin": formData.noMesin == 'Ada',
              "toolkit": formData.toolkit == 'Ada',
              "banSerep": formData.banSerep == 'Ada',
              "dongkrak": formData.dongkrak == 'Ada',
              "noRangka": formData.noRangka == 'Ada',
              "bukuManual": formData.bukuManual == 'Ada',
              "kunciSerep": formData.kunciSerep == 'Ada',
              "bukuService": formData.bukuService == 'Ada'
          },
          "inspectionSummary": {
              "mesinNotes": null, // TODO: Get from form data
              "mesinScore": null, // TODO: Get from form data
              "interiorNotes": null, // TODO: Get from form data
              "interiorScore": null, // TODO: Get from form data
              "kakiKakiNotes": null, // TODO: Get from form data
              "kakiKakiScore": null, // TODO: Get from form data
              "eksteriorNotes": null, // TODO: Get from form data
              "eksteriorScore": null, // TODO: Get from form data
              "indikasiBanjir": formData.indikasiBanjir == 'Terindikasi',
              "indikasiTabrakan": formData.indikasiTabrakan == 'Terindikasi',
              "estimasiPerbaikan": [], // TODO: Get from form data if available
              "deskripsiKeseluruhan": [], // TODO: Get from form data if available
              "indikasiOdometerReset": formData.indikasiOdometerReset == 'Terindikasi',
              "penilaianKeseluruhanScore": null // TODO: Get from form data
          },
          "detailedAssessment": {
              // TODO: Map detailed assessment data from form
          },
          "photoPaths": [], // TODO: Get from form data if available
          "nftAssetId": null, // TODO: Get from form data if available
          "transactionHash": null, // TODO: Get from form data if available
          "reportPdfUrl": null, // TODO: Get from form data if available
          "reportHash": null, // TODO: Get from form data if available
          "createdAt": DateTime.now().toIso8601String(),
          "updatedAt": DateTime.now().toIso8601String()
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        //print('Form data submitted successfully!');
        // TODO: Handle success (e.g., show a success message)
      } else {
        //print('Failed to submit form data: ${response.statusCode}');
        // TODO: Handle errors (e.g., show an error message)
      }
    } catch (e) {
      //print('Error submitting form data: $e');
      // TODO: Handle network errors or exceptions (e.g., show an error message)
    }
  }
}
