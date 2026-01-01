import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio show Dio, FormData, MultipartFile, LogInterceptor, DioException, CancelToken, InterceptorsWrapper, Options; // Consolidated dio imports
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:form_app/models/api_exception.dart';
import 'package:form_app/models/form_data.dart';
import 'package:form_app/models/inspection_branch.dart';
import 'package:form_app/models/inspector_data.dart';
import 'package:form_app/utils/crashlytics_util.dart';
import 'package:http_parser/http_parser.dart' show MediaType;
import 'package:mime/mime.dart';
import 'package:form_app/utils/calculation_utils.dart';
import 'package:form_app/models/uploadable_image.dart';
import 'package:form_app/services/auth_service.dart'; // Import AuthService

// Typedef for the progress callback
typedef ImageUploadProgressCallback = void Function(int currentBatch, int totalBatches);
typedef ImageBatchUploadedCallback = void Function(List<String> uploadedPaths); // New callback

class InspectionService {
  final dio.Dio _dioInst;
  final AuthService _authService;
  final CrashlyticsUtil _crashlytics;

  String get _baseApiUrl {
    if (kDebugMode) {
      return dotenv.env['API_BASE_URL_DEBUG']!;
    }
    return dotenv.env['API_BASE_URL']!;
  }

  String get _inspectionsUrl => '$_baseApiUrl/inspections';
  String get _inspectionBranchesUrl => '$_baseApiUrl/inspection-branches';
  String get _inspectorsUrl => '$_baseApiUrl/public/users/inspectors';

  InspectionService(this._authService, this._crashlytics)
      : _dioInst = dio.Dio() {

    _dioInst.interceptors.add(
      dio.LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (object) {
          if (kDebugMode) {
            print("DIO_LOG (InspectionService): ${object.toString()}");
          }
        },
      ),
    );

    _dioInst.interceptors.add(
      dio.InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = await _authService.getAccessToken();
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onError: (dio.DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            // If a 401 response is received, try to refresh the token
            final isRefreshed = await _authService.checkTokenValidity();
            if (isRefreshed) {
              // If token is refreshed, retry the original request
              final newAccessToken = await _authService.getAccessToken();
              if (newAccessToken != null) {
                error.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
                // Retry the request with the new token
                return handler.resolve(await _dioInst.fetch(error.requestOptions));
              }
            }
            // If token refresh fails or no new token, logout the user
            await _authService.logout();
            // Optionally, navigate to login page or show error
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<List<InspectionBranch>> getInspectionBranches() async {
    try {
      final response = await _dioInst.get(_inspectionBranchesUrl);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => InspectionBranch.fromJson(json)).toList();
      } else {
        throw ApiException(
          message: 'Failed to load inspection branches: ${response.statusCode}',
          statusCode: response.statusCode,
          responseData: response.data,
        );
      }
    } on ApiException catch (e, stackTrace) {
      _crashlytics.recordError(e, stackTrace, reason: 'Failed to load inspection branches');
      rethrow;
    } catch (e, stackTrace) {
      _crashlytics.recordError(e, stackTrace, reason: 'Error fetching inspection branches');
      throw ApiException(message: 'Error fetching inspection branches: $e');
    }
  }

  Future<List<Inspector>> getInspectors() async {
    try {
      final response = await _dioInst.get(_inspectorsUrl);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Inspector.fromJson(json)).toList();
      } else {
        throw ApiException(
          message: 'Failed to load inspectors: ${response.statusCode}',
          statusCode: response.statusCode,
          responseData: response.data,
        );
      }
    } on ApiException catch (e, stackTrace) {
      _crashlytics.recordError(e, stackTrace, reason: 'Failed to load inspectors');
      rethrow;
    } catch (e, stackTrace) {
      _crashlytics.recordError(e, stackTrace, reason: 'Error fetching inspectors');
      throw ApiException(message: 'Error fetching inspectors: $e');
    }
  }

  Future<Map<String, dynamic>> submitFormData(FormData formData, {dio.CancelToken? cancelToken}) async {
    // ... (your existing implementation, ensure it returns Map<String, dynamic>)
    try {
      final response = await _dioInst.post(
        _inspectionsUrl,
        data: {
          "vehiclePlateNumber": formData.platNomor.toUpperCase(),
          "inspectionDate": DateTime.now().toIso8601String(),
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
              "racksteer": formData.racksteerSelectedValue ?? 0,
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
            "front": formData.catDepanKap ?? '0',
            "rear": {
              "trunk": formData.catBelakangTrunk ?? '0',
              "bumper": formData.catBelakangBumper ?? '0'
            },
            "right": {
              "frontFender": formData.catKananFenderDepan ?? '0',
              "frontDoor": formData.catKananPintuDepan ?? '0',
              "rearDoor": formData.catKananPintuBelakang ?? '0',
              "rearFender": formData.catKananFenderBelakang ?? '0',
              "sideSkirt": formData.catKananSideSkirt ?? '0',
            },
            "left" : {
              "frontFender": formData.catKiriFenderDepan ?? '0',
              "frontDoor": formData.catKiriPintuDepan ?? '0',
              "rearDoor": formData.catKiriPintuBelakang ?? '0',
              "rearFender": formData.catKiriFenderBelakang ?? '0',
              "sideSkirt": formData.catKiriSideSkirt ?? '0',
            },
          },
        },
        cancelToken: cancelToken,
        options: _defaultPostOptions,
      );

      if (_isSuccessStatus(response.statusCode)) {
        if (kDebugMode) {
          print('Form data submitted successfully! Response: ${response.data}');
        }
        return response.data as Map<String, dynamic>;
      } else {
        final errorMessage = _deriveErrorMessage(response.data, response.statusCode) ?? 'Terjadi kesalahan pada server.';
        if (kDebugMode) {
          print('Failed to submit form data: ${response.statusCode} - $errorMessage');
        }
        throw ApiException(
          message: errorMessage,
          statusCode: response.statusCode,
          responseData: response.data,
        );
      }
    } on ApiException catch (e, stackTrace) {
      // Don't log if it's a cancellation
      final lowerMessage = e.message.toLowerCase();
      final isCancelled = lowerMessage.contains('batal') || lowerMessage.contains('cancel');
      if (!isCancelled) {
        _crashlytics.recordError(e, stackTrace, reason: 'Failed to submit form data');
      }
      rethrow;
    } catch (e, stackTrace) {
      // Generic catch for all errors including DioException
      final errorMessage = e.toString().toLowerCase();
      final isCancelled = errorMessage.contains('cancel');
      if (kDebugMode) {
        print('Error submitting form data: $e');
      }
      if (!isCancelled) {
        _crashlytics.recordError(e, stackTrace, reason: 'Unexpected error submitting form data');
      }
      throw ApiException(
        message: isCancelled ? 'Pengiriman data dibatalkan.' : e.toString()
      );
    }
  }


  dio.Options get _defaultPostOptions => dio.Options(
        validateStatus: (_) => true,
      );

  bool _isSuccessStatus(int? statusCode) => statusCode != null && statusCode >= 200 && statusCode < 300;

  String? _deriveErrorMessage(dynamic data, int? statusCode) {
    if (data == null) {
      return null;
    }

    if (data is Map<String, dynamic>) {
      final message = data['message'];
      if (message is List) {
        return message.map((e) => e.toString()).join('\n');
      }
      if (message is String) {
        return message;
      }
      if (data['error'] is String) {
        return data['error'] as String;
      }
    } else if (data is List) {
      return data.map((e) => e.toString()).join('\n');
    } else if (data is String) {
      return data;
    }

    if (statusCode != null) {
      return 'Permintaan gagal dengan status $statusCode.';
    }
    return 'Permintaan gagal.';
  }


  Future<void> uploadImagesInBatches(
    String inspectionId, 
    List<UploadableImage> allImages,
    ImageUploadProgressCallback onProgress,
    {dio.CancelToken? cancelToken, ImageBatchUploadedCallback? onBatchUploaded} // Add new callback
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
        final response = await _dioInst.post(
          photosUploadUrl, 
          data: formData,
          cancelToken: cancelToken,
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          if (kDebugMode) print('Batch $currentBatchNum/$totalBatchesCalc uploaded successfully.');
          if (onBatchUploaded != null) {
            final List<String> uploadedPathsInBatch = batch.map((img) => img.imagePath).toList();
            onBatchUploaded(uploadedPathsInBatch);
          }
        } else {
          final errorMessage = _deriveErrorMessage(response.data, response.statusCode) ?? 
              'Failed to upload photo batch $currentBatchNum/$totalBatchesCalc';
          throw ApiException(
            message: errorMessage,
            statusCode: response.statusCode,
            responseData: response.data,
          );
        }
      } on ApiException catch (e, stackTrace) {
        // Don't log if it's a cancellation
        final lowerMessage = e.message.toLowerCase();
        final isCancelled = lowerMessage.contains('batal') || lowerMessage.contains('cancel');
        if (!isCancelled) {
          _crashlytics.recordError(e, stackTrace, reason: 'Failed to upload photo batch');
        }
        rethrow;
      } catch (e, stackTrace) {
        // Generic catch for all errors including DioException
        final errorMessage = e.toString().toLowerCase();
        final isCancelled = errorMessage.contains('cancel');
        if (!isCancelled) {
          _crashlytics.recordError(e, stackTrace, reason: 'Unexpected error uploading photo batch');
        }
        throw ApiException(
          message: isCancelled 
            ? 'Pengiriman data dibatalkan.' 
            : 'Error uploading photo batch $currentBatchNum/$totalBatchesCalc: $e'
        );
      }
    }
    // After the loop, signal completion by calling onProgress with currentBatch = totalBatches
    onProgress(totalBatchesCalc, totalBatchesCalc);
  }
}
