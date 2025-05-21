import 'package:dio/dio.dart' as dio; // Add prefix
import 'package:form_app/models/form_data.dart';
import 'package:form_app/models/inspector_data.dart'; // Import Inspector model
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import flutter_dotenv
import 'package:form_app/models/inspection_branch.dart'; // Import InspectionBranch model

class ApiService {
  final dio.Dio _dio = dio.Dio(); // Use prefix
  String get _baseApiUrl => dotenv.env['API_BASE_URL']!; // Base API URL from .env
  String get _inspectionsUrl =>
      '$_baseApiUrl/inspections'; // Inspections endpoint
  String get _inspectionBranchesUrl =>
      '$_baseApiUrl/inspection-branches'; // Inspection branches endpoint
  String get _inspectorsUrl =>
      '$_baseApiUrl/public/users/inspectors'; // Inspectors endpoint

  Future<List<InspectionBranch>> getInspectionBranches() async {
    try {
      final response = await _dio.get(_inspectionBranchesUrl);
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        // Map the JSON data to a list of InspectionBranch objects
        return data.map((json) => InspectionBranch.fromJson(json)).toList();
      } else {
        // Throw an exception for FutureProvider to catch
        throw Exception('Failed to load inspection branches: ${response.statusCode}');
      }
    } catch (e) {
      // Re-throw for FutureProvider
      throw Exception('Error fetching inspection branches: $e');
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
          "inspectionDate": formData.tanggalInspeksi?.toIso8601String() ?? '-',
          "overallRating": formData.penilaianKeseluruhanSelectedValue ?? 0,
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
            "biayaPajak": formData.biayaPajak,
          },
          "equipmentChecklist": {
            "bukuService": formData.bukuService ?? false,
            "kunciSerep": formData.kunciSerep ?? false,
            "bukuManual": formData.bukuManual ?? false,
            "banSerep": formData.banSerep ?? false,
            "bpkb": formData.bpkb ?? false,
            "dongkrak": formData.dongkrak ?? false,
            "toolkit": formData.toolkit ?? false,
            "noRangka":  formData.noRangka ?? false,
            "noMesin": formData.noMesin ?? false,
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
            "penilaianKeseluruhanScore": formData.penilaianKeseluruhanSelectedValue ?? 0,
            "deskripsiKeseluruhan": formData.deskripsiKeseluruhan ?? [],
            "indikasiTabrakan": formData.indikasiTabrakan ?? false,
            "indikasiBanjir": formData.indikasiBanjir ?? false,
            "indikasiOdometerReset": formData.indikasiOdometerReset ?? false,
            "posisiBan": formData.posisiBan ?? '-',
            "merkban": formData.merk ?? '-',
            "tipeVelg": formData.tipeVelg ?? '-',
            "ketebalanBan": formData.ketebalan ?? '-',
            "estimasiPerbaikan": formData.repairEstimations.map((estimation) {
              return {
                "namaPart": estimation['repair'] ?? '-',
                "harga": estimation['price'] ?? 0,
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
              "interior1": formData.trimInteriorSelectedValue ?? 0,
              "interior2": formData.aromaInteriorSelectedValue ?? 0,
              "interior3": 10, // Keep hardcoded
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
              "trunk": formData.catBelakangTrunk,
              "bumper": formData.catBelakangBumper ?? '-'
            },
            "right": {
              "frontFender": formData.catKananFenderDepan ?? '-',
              "frontDoor": formData.catKananPintuDepan ?? '-',
              "rearDoor": formData.catKananPintuBelakang ?? '-',
              "rearFender": formData.catKananFenderBelakang ?? '-',
            },
            "left" : {
              "frontFender": formData.catKiriFenderDepan ?? '-',
              "frontDoor": formData.catKiriPintuDepan ?? '-',
              "rearDoor": formData.catKiriPintuBelakang ?? '-',
              "rearFender": formData.catKiriFenderBelakang ?? '-',
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
