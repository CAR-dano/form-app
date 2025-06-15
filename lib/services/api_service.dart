import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio show Dio, FormData, MultipartFile, LogInterceptor, DioException; // Consolidated dio imports
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:form_app/models/form_data.dart';
import 'package:form_app/models/inspection_branch.dart';
import 'package:form_app/models/inspector_data.dart';
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:mime/mime.dart';
import 'package:form_app/utils/calculation_utils.dart'; // Import the new utility
import 'package:form_app/models/uploadable_image.dart'; // Import the UploadableImage model

// Typedef for the progress callback
typedef ImageUploadProgressCallback = void Function(int currentBatch, int totalBatches);

class ApiService {
  final dio.Dio _dioInst;

  String get _baseApiUrl {
    if (kDebugMode) {
      return dotenv.env['API_BASE_URL_DEBUG']!;
    }
    return dotenv.env['API_BASE_URL']!;
  }

  String get _inspectionsUrl => '$_baseApiUrl/inspections';
  String get _inspectionBranchesUrl => '$_baseApiUrl/inspection-branches';
  String get _inspectorsUrl => '$_baseApiUrl/public/users/inspectors';

  ApiService() : _dioInst = dio.Dio() {
    _dioInst.interceptors.add(
      dio.LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (object) {
          if (kDebugMode) {
            print("DIO_LOG: ${object.toString()}");
          }
        },
      ),
    );
  }

  Future<List<InspectionBranch>> getInspectionBranches() async {
    // ... (your existing implementation)
    try {
      final response = await _dioInst.get(_inspectionBranchesUrl);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => InspectionBranch.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load inspection branches: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching inspection branches: $e');
    }
  }

  Future<List<Inspector>> getInspectors() async {
    // ... (your existing implementation)
    try {
      final response = await _dioInst.get(_inspectorsUrl);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Inspector.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load inspectors: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching inspectors: $e');
    }
  }

  Future<Map<String, dynamic>> submitFormData(FormData formData) async {
    // ... (your existing implementation, ensure it returns Map<String, dynamic>)
    try {
      final response = await _dioInst.post(
        _inspectionsUrl,
        data: { 
          "vehiclePlateNumber": formData.platNomor,
          "inspectionDate": formData.tanggalInspeksi?.toIso8601String() ?? '-',
          "overallRating": calculateOverallRating(formData),
          "identityDetails": {
            "namaInspektor": formData.inspectorId ?? '-', 
            "namaCustomer": formData.namaCustomer,
            "cabangInspeksi": formData.cabangInspeksi?.id ?? '-', 
          },
          "vehicleData": {
            "merekKendaraan": formData.merekKendaraan,
            "tipeKendaraan": formData.tipeKendaraan,
            "tahun": formData.tahun,
            "transmisi": formData.transmisi,
            "warnaKendaraan": formData.warnaKendaraan,
            "odometer": formData.odometer,
            "kepemilikan": formData.kepemilikan,
            "platNomor": formData.platNomor, 
            "pajak1Tahun": formData.pajak1TahunDate?.toIso8601String() ?? '-',
            "pajak5Tahun": formData.pajak5TahunDate?.toIso8601String() ?? '-',
            "biayaPajak": formData.biayaPajak.replaceAll('.', ''), 
          },
          "equipmentChecklist": {
            "bukuService": formData.bukuService == "Lengkap",
            "kunciSerep": formData.kunciSerep == "Lengkap",
            "bukuManual": formData.bukuManual == "Lengkap",
            "banSerep": formData.banSerep == "Lengkap",
            "bpkb": formData.bpkb == "Lengkap",
            "dongkrak": formData.dongkrak == "Lengkap",
            "toolkit": formData.toolkit == "Lengkap",
            "noRangka":  formData.noRangka == "Lengkap",
            "noMesin": formData.noMesin == "Lengkap",
          },
          "inspectionSummary": {
            "interiorScore": formData.interiorSelectedValue ?? 0,
            "interiorNotes": formData.keteranganInterior ?? [],
            "eksteriorScore": formData.eksteriorSelectedValue ?? 0,
            "eksteriorNotes": formData.keteranganEksterior ?? [],
            "kakiKakiScore": formData.kakiKakiSelectedValue ?? 0,
            "kakiKakiNotes": formData.keteranganKakiKaki ?? [],
            "mesinScore": formData.mesinSelectedValue ?? 0,
            "mesinNotes": formData.keteranganMesin ?? [],
            "penilaianKeseluruhanScore": calculateOverallRating(formData),
            "deskripsiKeseluruhan": formData.deskripsiKeseluruhan ?? [],
            "indikasiTabrakan": formData.indikasiTabrakan == "Terindikasi",
            "indikasiBanjir": formData.indikasiBanjir == "Terindikasi",
            "indikasiOdometerReset": formData.indikasiOdometerReset == "Terindikasi",
            "posisiBan": formData.posisiBan ?? '-',
            "merkban": formData.merk ?? '-',
            "tipeVelg": formData.tipeVelg ?? '-',
            "ketebalanBan": formData.ketebalan ?? '-',
            "estimasiPerbaikan": formData.repairEstimations.map((estimation) {
              return {
                "namaPart": estimation['repair'] ?? '-',
                "harga": estimation['price']?.replaceAll('.', '') ?? "0",
              };
            }).toList(),
          },
          "detailedAssessment": {
            "testDrive": {
              "bunyiGetaran": formData.bunyiGetaranSelectedValue ?? 0,
              "performaStir": formData.performaStirSelectedValue ?? 0,
              "perpindahanTransmisi": formData.perpindahanTransmisiSelectedValue ?? 0,
              "stirBalance": formData.stirBalanceSelectedValue ?? 0,
              "performaSuspensi": formData.performaSuspensiSelectedValue ?? 0,
              "performaKopling": formData.performaKoplingSelectedValue ?? 0,
              "rpm": formData.rpmSelectedValue ?? 0,
              "catatan": formData.testDriveCatatanList ?? [],
            },
            "banDanKakiKaki": {
              "banDepan": formData.banDepanSelectedValue ?? 0,
              "velgDepan": formData.velgDepanSelectedValue ?? 0,
              "discBrake": formData.discBrakeSelectedValue ?? 0,
              "masterRem": formData.masterRemSelectedValue ?? 0,
              "tieRod": formData.tieRodSelectedValue ?? 0,
              "gardan": formData.gardanSelectedValue ?? 0,
              "banBelakang": formData.banBelakangSelectedValue ?? 0,
              "velgBelakang": formData.velgBelakangSelectedValue ?? 0,
              "brakePad": formData.brakePadSelectedValue ?? 0,
              "crossmember": formData.crossmemberSelectedValue ?? 0,
              "knalpot": formData.knalpotSelectedValue ?? 0,
              "balljoint": formData.balljointSelectedValue ?? 0,
              "rocksteer": formData.rocksteerSelectedValue ?? 0,
              "karetBoot": formData.karetBootSelectedValue ?? 0,
              "upperLowerArm": formData.upperLowerArmSelectedValue ?? 0,
              "shockBreaker": formData.shockBreakerSelectedValue ?? 0,
              "linkStabilizer": formData.linkStabilizerSelectedValue ?? 0,
              "catatan": formData.banDanKakiKakiCatatanList ?? [],
            },
            "hasilInspeksiEksterior": {
              "bumperDepan": formData.bumperDepanSelectedValue ?? 0,
              "kapMesin": formData.kapMesinSelectedValue ?? 0,
              "lampuUtama": formData.lampuUtamaSelectedValue ?? 0,
              "panelAtap": formData.panelAtapSelectedValue ?? 0,
              "grill": formData.grillSelectedValue ?? 0,
              "lampuFoglamp": formData.lampuFoglampSelectedValue ?? 0,
              "kacaBening": formData.kacaBeningSelectedValue ?? 0,
              "wiperBelakang": formData.wiperBelakangSelectedValue ?? 0,
              "bumperBelakang": formData.bumperBelakangSelectedValue ?? 0,
              "lampuBelakang": formData.lampuBelakangSelectedValue ?? 0,
              "trunklid": formData.trunklidSelectedValue ?? 0,
              "kacaDepan": formData.kacaDepanSelectedValue ?? 0,
              "fenderKanan": formData.fenderKananSelectedValue ?? 0,
              "quarterPanelKanan": formData.quarterPanelKananSelectedValue ?? 0,
              "pintuBelakangKanan": formData.pintuBelakangKananSelectedValue ?? 0,
              "spionKanan": formData.spionKananSelectedValue ?? 0,
              "lisplangKanan": formData.lisplangKananSelectedValue ?? 0,
              "sideSkirtKanan": formData.sideSkirtKananSelectedValue ?? 0,
              "daunWiper": formData.daunWiperSelectedValue ?? 0,
              "pintuBelakang": formData.pintuBelakangSelectedValue ?? 0,
              "fenderKiri": formData.fenderKiriSelectedValue ?? 0,
              "quarterPanelKiri": formData.quarterPanelKiriSelectedValue ?? 0,
              "pintuDepan": formData.pintuDepanSelectedValue ?? 0,
              "kacaJendelaKanan": formData.kacaJendelaKananSelectedValue ?? 0,
              "pintuBelakangKiri": formData.pintuBelakangKiriSelectedValue ?? 0,
              "spionKiri": formData.spionKiriSelectedValue ?? 0,
              "pintuDepanKiri": formData.pintuDepanKiriSelectedValue ?? 0,
              "kacaJendelaKiri": formData.kacaJendelaKiriSelectedValue ?? 0,
              "lisplangKiri": formData.lisplangKiriSelectedValue ?? 0,
              "sideSkirtKiri": formData.sideSkirtKiriSelectedValue ?? 0,
              "catatan": formData.eksteriorCatatanList ?? [],
            },
            "toolsTest": {
              "tebalCatBodyDepan": formData.tebalCatBodyDepanSelectedValue ?? 0,
              "tebalCatBodyKiri": formData.tebalCatBodyKiriSelectedValue ?? 0,
              "temperatureAC": formData.temperatureAcMobilSelectedValue ?? 0,
              "tebalCatBodyKanan": formData.tebalCatBodyKananSelectedValue ?? 0,
              "tebalCatBodyBelakang": formData.tebalCatBodyBelakangSelectedValue ?? 0,
              "obdScanner": formData.obdScannerSelectedValue ?? 0,
              "tebalCatBodyAtap": formData.tebalCatBodyAtapSelectedValue ?? 0,
              "testAccu": formData.testAccuSelectedValue ?? 0,
              "catatan": formData.toolsTestCatatanList ?? [],
            },
            "fitur": {
              "airbag": formData.airbagSelectedValue ?? 0,
              "sistemAudio": formData.sistemAudioSelectedValue ?? 0,
              "powerWindow": formData.powerWindowSelectedValue ?? 0,
              "sistemAC": formData.sistemAcSelectedValue ?? 0,
              "centralLock": formData.centralLockSelectedValue ?? 0, 
              "electricMirror": formData.electricMirrorSelectedValue ?? 0, 
              "remAbs": formData.remAbsSelectedValue ?? 0,
              "catatan": formData.fiturCatatanList ?? [],
            },
            "hasilInspeksiMesin": {
              "getaranMesin": formData.getaranMesinSelectedValue ?? 0,
              "suaraMesin": formData.suaraMesinSelectedValue ?? 0,
              "transmisi": formData.transmisiSelectedValue ?? 0,
              "pompaPowerSteering": formData.pompaPowerSteeringSelectedValue ?? 0,
              "coverTimingChain": formData.coverTimingChainSelectedValue ?? 0,
              "oliPowerSteering": formData.oliPowerSteeringSelectedValue ?? 0,
              "accu": formData.accuSelectedValue ?? 0,
              "kompressorAC": formData.kompressorAcSelectedValue ?? 0,
              "fan": formData.fanSelectedValue ?? 0,
              "selang": formData.selangSelectedValue ?? 0,
              "karterOli": formData.karterOliSelectedValue ?? 0,
              "oliRem": formData.oilRemSelectedValue ?? 0,
              "kabel": formData.kabelSelectedValue ?? 0,
              "kondensor": formData.kondensorSelectedValue ?? 0,
              "radiator": formData.radiatorSelectedValue ?? 0,
              "cylinderHead": formData.cylinderHeadSelectedValue ?? 0,
              "oliMesin": formData.oliMesinSelectedValue ?? 0,
              "airRadiator": formData.airRadiatorSelectedValue ?? 0,
              "coverKlep": formData.coverKlepSelectedValue ?? 0,
              "alternator": formData.alternatorSelectedValue ?? 0,
              "waterPump": formData.waterPumpSelectedValue ?? 0,
              "belt": formData.beltSelectedValue ?? 0,
              "oliTransmisi": formData.oliTransmisiSelectedValue ?? 0,
              "cylinderBlock": formData.cylinderBlockSelectedValue ?? 0,
              "bushingBesar": formData.bushingBesarSelectedValue ?? 0,
              "bushingKecil": formData.bushingKecilSelectedValue ?? 0,
              "tutupRadiator": formData.tutupRadiatorSelectedValue ?? 0,
              "catatan": formData.mesinCatatanList ?? [],
            },
            "hasilInspeksiInterior": {
              "stir": formData.stirSelectedValue ?? 0,
              "remTangan": formData.remTanganSelectedValue ?? 0,
              "pedal": formData.pedalSelectedValue ?? 0,
              "switchWiper": formData.switchWiperSelectedValue ?? 0,
              "lampuHazard": formData.lampuHazardSelectedValue ?? 0,
              "switchLampu": formData.switchLampuSelectedValue ?? 0, 
              "panelDashboard": formData.panelDashboardSelectedValue ?? 0,
              "pembukaKapMesin": formData.pembukaKapMesinSelectedValue ?? 0,
              "pembukaBagasi": formData.pembukaBagasiSelectedValue ?? 0,
              "jokDepan": formData.jokDepanSelectedValue ?? 0,
              "aromaInterior": formData.aromaInteriorSelectedValue ?? 0,
              "handlePintu": formData.handlePintuSelectedValue ?? 0,
              "consoleBox": formData.consoleBoxSelectedValue ?? 0,
              "spionTengah": formData.spionTengahSelectedValue ?? 0,
              "tuasPersneling": formData.tuasPersnelingSelectedValue ?? 0,
              "jokBelakang": formData.jokBelakangSelectedValue ?? 0,
              "panelIndikator": formData.panelIndikatorSelectedValue ?? 0,
              "switchLampuInterior": formData.switchLampuSelectedValue ?? 0, 
              "karpetDasar": formData.karpetDasarSelectedValue ?? 0,
              "klakson": formData.klaksonSelectedValue ?? 0,
              "sunVisor": formData.sunVisorSelectedValue ?? 0,
              "tuasTangkiBensin": formData.tuasTangkiBensinSelectedValue ?? 0,
              "sabukPengaman": formData.sabukPengamanSelectedValue ?? 0,
              "trimInterior": formData.trimInteriorSelectedValue ?? 0,
              "plafon": formData.plafonSelectedValue ?? 0,
              "catatan": formData.interiorCatatanList ?? [],
            },
          },
          "bodyPaintThickness": {
            "front": formData.catDepanKap ?? '-',
            "rear": {
              "trunk": formData.catBelakangTrunk ?? '-',
              "bumper": formData.catBelakangBumper ?? '-'
            },
            "right": {
              "frontFender": formData.catKananFenderDepan ?? '-',
              "frontDoor": formData.catKananPintuDepan ?? '-',
              "rearDoor": formData.catKananPintuBelakang ?? '-',
              "rearFender": formData.catKananFenderBelakang ?? '-',
              "sideSkirt": formData.catKananSideSkirt ?? '-',
            },
            "left" : {
              "frontFender": formData.catKiriFenderDepan ?? '-',
              "frontDoor": formData.catKiriPintuDepan ?? '-',
              "rearDoor": formData.catKiriPintuBelakang ?? '-',
              "rearFender": formData.catKiriFenderBelakang ?? '-',
              "sideSkirt": formData.catKiriSideSkirt ?? '-',
            },
          },
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print('Form data submitted successfully! Response: ${response.data}');
        }
        return response.data as Map<String, dynamic>;
      } else {
        if (kDebugMode) {
          print('Failed to submit form data: ${response.statusCode} - ${response.data}');
        }
        throw Exception('Failed to submit form data: ${response.statusCode} - ${response.data}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error submitting form data: $e');
      }
      throw Exception('Error submitting form data: $e');
    }
  }


  Future<void> uploadImagesInBatches(
    String inspectionId, 
    List<UploadableImage> allImages,
    ImageUploadProgressCallback onProgress, // Add this
  ) async {
    const int batchSize = 10;
    // Calculate total batches, ensure it's at least 1 if there are images, or 0 if not
    int totalBatchesCalc = allImages.isEmpty ? 0 : (allImages.length / batchSize).ceil();

    if (allImages.isEmpty) {
      onProgress(0, 0); // Signal completion or no work if no images
      return;
    }

    for (int i = 0, currentBatchNum = 1; i < allImages.length; i += batchSize, currentBatchNum++) {
      onProgress(currentBatchNum, totalBatchesCalc); // Report progress for the current batch about to be processed

      final batch = allImages.sublist(i, i + batchSize > allImages.length ? allImages.length : i + batchSize);
      
      List<dio.MultipartFile> photoFiles = [];
      List<Map<String, dynamic>> metadataList = [];

      for (var image in batch) {
        if (image.imagePath.isEmpty) {
          if (kDebugMode) print('Skipping image with empty path: ${image.label}');
          continue;
        }
        File file = File(image.imagePath);
        if (!await file.exists()) {
          if (kDebugMode) print('Image file not found: ${image.imagePath}');
          continue;
        }
        String fileName = file.path.split('/').last;
        
        String? mimeType = lookupMimeType(file.path);
        if (kDebugMode) {
          print('File: ${file.path}, Determined MIME type: $mimeType');
        }

        photoFiles.add(await dio.MultipartFile.fromFile(
          file.path,
          filename: fileName,
          contentType: mimeType != null ? MediaType.parse(mimeType) : null,
        ));
        metadataList.add(image.toJson());
      }

      if (photoFiles.isEmpty) {
        if (kDebugMode) print('Skipping empty batch for inspection $inspectionId from index $i');
        // If this was the last potential batch and it's empty, it means all prior batches (if any) completed.
        // The final onProgress call after the loop will handle true completion.
        continue;
      }

      String metadataJsonString = json.encode(metadataList);
      dio.FormData formData = dio.FormData.fromMap({
        'photos': photoFiles,
        'metadata': metadataJsonString,
      });
      final photosUploadUrl = '$_inspectionsUrl/$inspectionId/photos/multiple';
      
      if (kDebugMode) {
        print('Attempting to upload batch $currentBatchNum/$totalBatchesCalc of ${photoFiles.length} photos to $photosUploadUrl');
        print('Metadata for this batch: $metadataJsonString');
      }

      try {
        final response = await _dioInst.post(photosUploadUrl, data: formData);
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (kDebugMode) print('Batch $currentBatchNum/$totalBatchesCalc uploaded successfully.');
        } else {
          throw Exception('Failed to upload photo batch $currentBatchNum/$totalBatchesCalc: ${response.statusCode} - ${response.data}');
        }
      } on dio.DioException catch (e) {
        throw Exception('Error uploading photo batch $currentBatchNum/$totalBatchesCalc (DioException): ${e.message}');
      } catch (e) {
        throw Exception('Error uploading photo batch $currentBatchNum/$totalBatchesCalc: $e');
      }
    }
    // After the loop, signal completion by calling onProgress with currentBatch = totalBatches
    // (or totalBatchesCalc, totalBatchesCalc)
    onProgress(totalBatchesCalc, totalBatchesCalc);
  }
}
