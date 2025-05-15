import 'package:dio/dio.dart' as dio; // Add prefix
import 'package:form_app/models/form_data.dart';
import 'package:form_app/models/inspector_data.dart'; // Import Inspector model

class ApiService {
  final dio.Dio _dio = dio.Dio(); // Use prefix
  static const String _baseApiUrl = 'http://69.62.80.7/api/v1'; // Base API URL
  final String _inspectionsUrl =
      '$_baseApiUrl/inspections'; // Inspections endpoint
  final String _inspectionBranchesUrl =
      '$_baseApiUrl/inspection-branches'; // Inspection branches endpoint
  final String _inspectorsUrl =
      '$_baseApiUrl/public/users/inspectors'; // Inspectors endpoint

  Future<List<String>> getInspectionBranches() async {
    try {
      final response = await _dio.get(_inspectionBranchesUrl);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((branch) => branch['city'] as String).toList();
      } else {
        // Handle error, perhaps return an empty list or throw an exception
        //print('Failed to load inspection branches: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      //print('Error fetching inspection branches: $e');
      return [];
    }
  }

  Future<List<Inspector>> getInspectors() async {
    // Change return type to List<Inspector>
    try {
      final response = await _dio.get(_inspectorsUrl);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        // Map the JSON data to a list of Inspector objects
        return data.map((json) => Inspector.fromJson(json)).toList();
      } else {
        // Throw an exception for FutureProvider to catch
        throw Exception('Failed to load inspectors: ${response.statusCode}');
      }
    } catch (e) {
      // Re-throw for FutureProvider
      throw Exception('Error fetching inspectors: $e');
    }
  }

  Future<void> submitFormData(FormData formData) async {
    try {
      final response = await _dio.post(
        _inspectionsUrl,
        data: {
          "vehiclePlateNumber": formData.platNomor,
          "inspectionDate": formData.tanggalInspeksi?.toIso8601String(),
          "overallRating": formData.penilaianKeseluruhanSelectedValue, // harus ada isinya, gaboleh null
          "inspectorId": formData.inspectorId,
          "identityDetails": {
            "namaInspektor": formData.namaInspektor,
            "namaCustomer": formData.namaCustomer,
            "cabangInspeksi": formData.cabangInspeksi,
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
            "pajak1Tahun": formData.pajak1TahunDate?.toIso8601String(),
            "pajak5Tahun": formData.pajak5TahunDate?.toIso8601String(),
            "biayaPajak": formData.biayaPajak,
          },
          "equipmentChecklist": {
            "bukuService": formData.bukuService,
            "kunciSerep": formData.kunciSerep,
            "bukuManual": formData.bukuManual,
            "banSerep": formData.banSerep,
            "bpkb": formData.bpkb,
            "dongkrak": formData.dongkrak,
            "toolkit": formData.toolkit,
            "noRangka":  formData.noRangka,
            "noMesin": formData.noMesin,
          },
          "inspectionSummary": {
            "interiorScore": formData.interiorSelectedValue,
            "interiorNotes": formData.keteranganInterior,
            "eksteriorScore": formData.eksteriorSelectedValue,
            "eksteriorNotes": formData.keteranganEksterior,
            "kakiKakiScore": formData.kakiKakiSelectedValue,
            "kakiKakiNotes": formData.keteranganKakiKaki,
            "mesinScore": formData.mesinSelectedValue,
            "mesinNotes": formData.keteranganMesin,
            "penilaianKeseluruhanScore": formData.penilaianKeseluruhanSelectedValue,
            "deskripsiKeseluruhan": formData.deskripsiKeseluruhan,
            "indikasiTabrakan": formData.indikasiTabrakan,
            "indikasiBanjir": formData.indikasiBanjir,
            "indikasiOdometerReset": formData.indikasiOdometerReset,
            "posisiBan": formData.posisiBan,
            "merkban": formData.merk,
            "tipeVelg": formData.tipeVelg,
            "ketebalanBan": formData.ketebalan,
            "estimasiPerbaikan": formData.repairEstimations.map((estimation) {
              return {
                "namaPart": estimation['repair'],
                "harga": estimation['price'],
              };
            }).toList(),
          },
          "detailedAssessment": {
            "testDrive": {
              "bunyiGetaran": formData.bunyiGetaranSelectedValue,
              "performaStir": formData.performaStirSelectedValue,
              "perpindahanTransmisi": formData.perpindahanTransmisiSelectedValue,
              "stirBalance": formData.stirBalanceSelectedValue,
              "performaSuspensi": formData.performaSuspensiSelectedValue,
              "performaKopling": formData.performaKoplingSelectedValue,
              "rpm": formData.rpmSelectedValue,
              "catatan": formData.testDriveCatatanList,
            },
            "banDanKakiKaki": {
              "banDepan": formData.banDepanSelectedValue,
              "velgDepan": formData.velgDepanSelectedValue,
              "discBrake": formData.discBrakeSelectedValue,
              "masterRem": formData.masterRemSelectedValue,
              "tieRod": formData.tieRodSelectedValue,
              "gardan": formData.gardanSelectedValue,
              "banBelakang": formData.banBelakangSelectedValue,
              "velgBelakang": formData.velgBelakangSelectedValue,
              "brakePad": formData.brakePadSelectedValue,
              "crossmember": formData.crossmemberSelectedValue,
              "knalpot": formData.knalpotSelectedValue,
              "balljoint": formData.balljointSelectedValue,
              "rocksteer": formData.rocksteerSelectedValue,
              "karetBoot": formData.karetBootSelectedValue,
              "upperLowerArm": formData.upperLowerArmSelectedValue,
              "shockBreaker": formData.shockBreakerSelectedValue,
              "linkStabilizer": formData.linkStabilizerSelectedValue,
              "catatan": formData.banDanKakiKakiCatatanList,
            },
            "hasilInspeksiEksterior": {
              "bumperDepan": formData.bumperDepanSelectedValue,
              "kapMesin": formData.kapMesinSelectedValue,
              "lampuUtama": formData.lampuUtamaSelectedValue,
              "panelAtap": formData.panelAtapSelectedValue,
              "grill": formData.grillSelectedValue,
              "lampuFoglamp": formData.lampuFoglampSelectedValue,
              "kacaBening": formData.kacaBeningSelectedValue,
              "wiperBelakang": formData.wiperBelakangSelectedValue,
              "bumperBelakang": formData.bumperBelakangSelectedValue,
              "lampuBelakang": formData.lampuBelakangSelectedValue,
              "trunklid": formData.trunklidSelectedValue,
              "kacaDepan": formData.kacaDepanSelectedValue,
              "fenderKanan": formData.fenderKananSelectedValue,
              "quarterPanelKanan": formData.quarterPanelKananSelectedValue,
              "pintuBelakangKanan": formData.pintuBelakangKananSelectedValue,
              "spionKanan": formData.spionKananSelectedValue,
              "lisplangKanan": formData.lisplangKananSelectedValue,
              "sideSkirtKanan": formData.sideSkirtKananSelectedValue,
              "daunWiper": formData.daunWiperSelectedValue,
              "pintuBelakang": formData.pintuBelakangSelectedValue,
              "fenderKiri": formData.fenderKiriSelectedValue,
              "quarterPanelKiri": formData.quarterPanelKiriSelectedValue,
              "pintuDepan": formData.pintuDepanSelectedValue,
              "kacaJendelaKanan": formData.kacaJendelaKananSelectedValue,
              "pintuBelakangKiri": formData.pintuBelakangKiriSelectedValue,
              "spionKiri": formData.spionKiriSelectedValue,
              "pintuDepanKiri": formData.pintuDepanKiriSelectedValue,
              "kacaJendelaKiri": formData.kacaJendelaKiriSelectedValue,
              "lisplangKiri": formData.lisplangKiriSelectedValue,
              "sideSkirtKiri": formData.sideSkirtKiriSelectedValue,
              "catatan": formData.eksteriorCatatanList,
            },
            "toolsTest": {
              "tebalCatBodyDepan": formData.tebalCatBodyDepanSelectedValue,
              "tebalCatBodyKiri": formData.tebalCatBodyKiriSelectedValue,
              "temperatureAC": formData.temperatureAcMobilSelectedValue,
              "tebalCatBodyKanan": formData.tebalCatBodyKananSelectedValue,
              "tebalCatBodyBelakang": formData.tebalCatBodyBelakangSelectedValue,
              "obdScanner": formData.obdScannerSelectedValue,
              "tebalCatBodyAtap": formData.tebalCatBodyAtapSelectedValue,
              "testAccu": formData.testAccuSelectedValue,
              "catatan": formData.toolsTestCatatanList,
            },
            "fitur": {
              "airbag": formData.airbagSelectedValue,
              "sistemAudio": formData.sistemAudioSelectedValue,
              "powerWindow": formData.powerWindowSelectedValue,
              "sistemAC": formData.sistemAcSelectedValue,
              "interior1": formData.trimInteriorSelectedValue,
              "interior2": formData.aromaInteriorSelectedValue,
              "interior3": 10,
              "catatan": formData.fiturCatatanList,
            },
            "hasilInspeksiMesin": {
              "getaranMesin": formData.getaranMesinSelectedValue,
              "suaraMesin": formData.suaraMesinSelectedValue,
              "transmisi": formData.transmisiSelectedValue,
              "pompaPowerSteering": formData.pompaPowerSteeringSelectedValue,
              "coverTimingChain": formData.coverTimingChainSelectedValue,
              "oliPowerSteering": formData.oliPowerSteeringSelectedValue,
              "accu": formData.accuSelectedValue,
              "kompressorAC": formData.kompressorAcSelectedValue,
              "fan": formData.fanSelectedValue,
              "selang": formData.selangSelectedValue,
              "karterOli": formData.karterOliSelectedValue,
              "oliRem": formData.oilRemSelectedValue,
              "kabel": formData.kabelSelectedValue,
              "kondensor": formData.kondensorSelectedValue,
              "radiator": formData.radiatorSelectedValue,
              "cylinderHead": formData.cylinderHeadSelectedValue,
              "oliMesin": formData.oliMesinSelectedValue,
              "airRadiator": formData.airRadiatorSelectedValue,
              "coverKlep": formData.coverKlepSelectedValue,
              "alternator": formData.alternatorSelectedValue,
              "waterPump": formData.waterPumpSelectedValue,
              "belt": formData.beltSelectedValue,
              "oliTransmisi": formData.oliTransmisiSelectedValue,
              "cylinderBlock": formData.cylinderBlockSelectedValue,
              "bushingBesar": formData.bushingBesarSelectedValue,
              "bushingKecil": formData.bushingKecilSelectedValue,
              "tutupRadiator": formData.tutupRadiatorSelectedValue,
              "catatan": formData.mesinCatatanList,
            },
            "hasilInspeksiInterior": {
              "stir": formData.stirSelectedValue,
              "remTangan": formData.remTanganSelectedValue,
              "pedal": formData.pedalSelectedValue,
              "switchWiper": formData.switchWiperSelectedValue,
              "lampuHazard": formData.lampuHazardSelectedValue,
              "switchLampu": formData.switchLampuSelectedValue,
              "panelDashboard": formData.panelDashboardSelectedValue,
              "pembukaKapMesin": formData.pembukaKapMesinSelectedValue,
              "pembukaBagasi": formData.pembukaBagasiSelectedValue,
              "jokDepan": formData.jokDepanSelectedValue,
              "aromaInterior": formData.aromaInteriorSelectedValue,
              "handlePintu": formData.handlePintuSelectedValue,
              "consoleBox": formData.consoleBoxSelectedValue,
              "spionTengah": formData.spionTengahSelectedValue,
              "tuasPersneling": formData.tuasPersnelingSelectedValue,
              "jokBelakang": formData.jokBelakangSelectedValue,
              "panelIndikator": formData.panelIndikatorSelectedValue,
              "switchLampuInterior": formData.switchLampuSelectedValue,
              "karpetDasar": formData.karpetDasarSelectedValue,
              "klakson": formData.klaksonSelectedValue,
              "sunVisor": formData.sunVisorSelectedValue,
              "tuasTangkiBensin": formData.tuasTangkiBensinSelectedValue,
              "sabukPengaman": formData.sabukPengamanSelectedValue,
              "trimInterior": formData.trimInteriorSelectedValue,
              "plafon": formData.plafonSelectedValue,
              "catatan": formData.interiorCatatanList,
            },
          },
          "bodyPaintThickness": {
            "front": formData.tebalCatBodyDepanSelectedValue?.toString() ?? '',
            "rear": {
              "trunk": "10", // Keep hardcoded for now
              "bumper": formData.tebalCatBodyBelakangSelectedValue?.toString() ?? ''
            },
            "right": {
              "frontFender": formData.tebalCatBodyKananSelectedValue?.toString() ?? '',
              "frontDoor": 10, // Keep hardcoded
              "rearDoor": 10, // Keep hardcoded
              "rearFender": 10, // Keep hardcoded
            },
            "left": {
              "frontFender": formData.tebalCatBodyKiriSelectedValue?.toString() ?? '',
              "frontDoor": 10, // Keep hardcoded
              "rearDoor": 10, // Keep hardcoded
              "rearFender": 10, // Keep hardcoded
            },
          },
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
