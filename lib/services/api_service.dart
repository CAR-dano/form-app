import 'package:dio/dio.dart' as dio; // Add prefix
import 'package:form_app/models/form_data.dart';

class ApiService {
  final dio.Dio _dio = dio.Dio(); // Use prefix
  final String _baseUrl =
      'http://31.220.81.182/api/v1/inspections'; // Your API endpoint

  Future<void> submitFormData(FormData formData) async {
    try {
      final response = await _dio.post(
        _baseUrl,
        data: {
          "vehiclePlateNumber": formData.platNomor,
          "inspectionDate": formData.tanggalInspeksi?.toIso8601String(),
          "overallRating": formData.penilaianKeseluruhanSelectedValue,
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
            "bukuService": formData.bukuService != null ? (formData.bukuService == 'Ada') : null,
            "kunciSerep": formData.kunciSerep != null ? (formData.kunciSerep == 'Ada') : null,
            "bukuManual": formData.bukuManual != null ? (formData.bukuManual == 'Ada') : null,
            "banSerep": formData.banSerep != null ? (formData.banSerep == 'Ada') : null,
            "bpkb": formData.bpkp != null ? (formData.bpkp == 'Ada') : null,
            "dongkrak": formData.dongkrak != null ? (formData.dongkrak == 'Ada') : null,
            "toolkit": formData.toolkit != null ? (formData.toolkit == 'Ada') : null,
            "noRangka": formData.noRangka != null ? (formData.noRangka == 'Ada') : null,
            "noMesin": formData.noMesin != null ? (formData.noMesin == 'Ada') : null,
          },
          "inspectionSummary": {
            "interiorScore": formData.interiorSelectedValue,
            "interiorNotes": formData.keteranganInterior.isNotEmpty ? formData.keteranganInterior.join(', ') : null,
            "eksteriorScore": formData.eksteriorSelectedValue,
            "eksteriorNotes": formData.keteranganEksterior.isNotEmpty ? formData.keteranganEksterior.join(', ') : null,
            "kakiKakiScore": formData.kakiKakiSelectedValue,
            "kakiKakiNotes": formData.keteranganKakiKaki.isNotEmpty ? formData.keteranganKakiKaki.join(', ') : null,
            "mesinScore": formData.mesinSelectedValue,
            "mesinNotes": formData.keteranganMesin.isNotEmpty ? formData.keteranganMesin.join(', ') : null,
            "penilaianKeseluruhanScore": formData.penilaianKeseluruhanSelectedValue,
            "deskripsiKeseluruhan": formData.deskripsiKeseluruhan.isNotEmpty ? formData.deskripsiKeseluruhan : null,
            "indikasiTabrakan": formData.indikasiTabrakan != null ? (formData.indikasiTabrakan == 'Ya') : null,
            "indikasiBanjir": formData.indikasiBanjir != null ? (formData.indikasiBanjir == 'Ya') : null,
            "indikasiOdometerReset": formData.indikasiOdometerReset != null ? (formData.indikasiOdometerReset == 'Ya') : null,
            "posisiBan": formData.posisiBan,
            "merkban": formData.merk,
            "tipeVelg": formData.tipeVelg,
            "ketebalanBan": formData.ketebalan,
            "estimasiPerbaikan": formData.repairEstimations.isNotEmpty ? formData.repairEstimations : null,
          },
          "detailedAssessment": {
            "testDrive": {
              "bunyiGetaran": null, // TODO: Map to FormData field if available
              "performaStir": null, // TODO: Map to FormData field if available
              "perpindahanTransmisi": null, // TODO: Map to FormData field if available
              "stirBalance": null, // TODO: Map to FormData field if available
              "performaSuspensi": null, // TODO: Map to FormData field if available
              "performaKopling": null, // TODO: Map to FormData field if available
              "rpm": null, // TODO: Map to FormData field if available
              "catatan": formData.fiturCatatanList.isNotEmpty ? formData.fiturCatatanList.join(', ') : null,
            },
            "banDanKakiKaki": {
              "banDepan": null, // TODO: Map to FormData field if available
              "velgDepan": null, // TODO: Map to FormData field if available
              "discBrake": null, // TODO: Map to FormData field if available
              "masterRem": null, // TODO: Map to FormData field if available
              "tieRod": null, // TODO: Map to FormData field if available
              "gardan": null, // TODO: Map to FormData field if available
              "banBelakang": null, // TODO: Map to FormData field if available
              "velgBelakang": null, // TODO: Map to FormData field if available
              "brakePad": null, // TODO: Map to FormData field if available
              "crossmember": null, // TODO: Map to FormData field if available
              "knalpot": null, // TODO: Map to FormData field if available
              "balljoint": null, // TODO: Map to FormData field if available
              "rocksteer": null, // TODO: Map to FormData field if available
              "karetBoot": null, // TODO: Map to FormData field if available
              "upperLowerArm": null, // TODO: Map to FormData field if available
              "shockBreaker": null, // TODO: Map to FormData field if available
              "linkStabilizer": null, // TODO: Map to FormData field if available
              "catatan": formData.mesinCatatanList.isNotEmpty ? formData.mesinCatatanList.join(', ') : null,
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
              "catatan": formData.eksteriorCatatanList.isNotEmpty ? formData.eksteriorCatatanList.join(', ') : null,
            },
            "toolsTest": {
              "tebalCatBodyDepan": null, // TODO: Map to FormData field if available
              "tebalCatBodyKiri": null, // TODO: Map to FormData field if available
              "temperatureAC": null, // TODO: Map to FormData field if available
              "tebalCatBodyKanan": null, // TODO: Map to FormData field if available
              "tebalCatBodyBelakang": null, // TODO: Map to FormData field if available
              "obdScanner": null, // TODO: Map to FormData field if available
              "tebalCatBodyAtap": null, // TODO: Map to FormData field if available
              "testAccu": null, // TODO: Map to FormData field if available
              "catatan": null, // TODO: Map to FormData field if available
            },
            "fitur": {
              "airbag": formData.airbagSelectedValue,
              "sistemAudio": formData.sistemAudioSelectedValue,
              "powerWindow": formData.powerWindowSelectedValue,
              "sistemAC": formData.sistemAcSelectedValue,
              "interior1": null, // TODO: Map to FormData field if available
              "interior2": null, // TODO: Map to FormData field if available
              "interior3": null, // TODO: Map to FormData field if available
              "catatan": formData.fiturCatatanList.isNotEmpty ? formData.fiturCatatanList.join(', ') : null,
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
              "catatan": formData.mesinCatatanList.isNotEmpty ? formData.mesinCatatanList.join(', ') : null,
            },
            "hasilInspeksiInterior": {
              "stir": formData.stirSelectedValue,
              "remTangan": formData.remTonganSelectedValue,
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
              "catatan": formData.interiorCatatanList.isNotEmpty ? formData.interiorCatatanList.join(', ') : null,
            },
          },
          "bodyPaintThickness": {
            "front": null, // TODO: Map to FormData field if available
            "rear": {"trunk": null, "bumper": null}, // TODO: Map to FormData field if available
            "right": {
              "frontFender": null, // TODO: Map to FormData field if available
              "frontDoor": null, // TODO: Map to FormData field if available
              "rearDoor": null, // TODO: Map to FormData field if available
              "rearFender": null, // TODO: Map to FormData field if available
            },
            "left": {
              "frontFender": null, // TODO: Map to FormData field if available
              "frontDoor": null, // TODO: Map to FormData field if available
              "rearDoor": null, // TODO: Map to FormData field if available
              "rearFender": null, // TODO: Map to FormData field if available
            },
          },
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Form data submitted successfully!');
        // TODO: Handle success (e.g., show a success message)
      } else {
        print('Failed to submit form data: ${response.statusCode}');
        // TODO: Handle errors (e.g., show an error message)
      }
    } catch (e) {
      print('Error submitting form data: $e');
      // TODO: Handle network errors or exceptions (e.g., show an error message)
    }
  }
}
