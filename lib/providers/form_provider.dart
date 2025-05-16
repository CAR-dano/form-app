import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart';
import 'package:form_app/models/inspector_data.dart';
import 'package:form_app/providers/inspection_branches_provider.dart';
import 'package:form_app/providers/inspector_provider.dart'; // Import inspection branches provider
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FormNotifier extends StateNotifier<FormData> {
  final Ref _ref;
  static const _storageKey = 'form_data';

  FormNotifier(this._ref) : super(FormData()) {
    // Listen to the inspectionBranchesProvider and validate/update cabangInspeksi
    _ref.listen<AsyncValue<List<String>>>(inspectionBranchesProvider, (previous, next) {
      next.whenData((availableBranches) {
        _validateAndUpdateCabangInspeksi(state.cabangInspeksi, availableBranches);
      });
    });

    // Initial validation in case branches are already loaded when FormNotifier is created
    final initialBranchesAsync = _ref.read(inspectionBranchesProvider);
    initialBranchesAsync.whenData((availableBranches) {
      _validateAndUpdateCabangInspeksi(state.cabangInspeksi, availableBranches);
    });

    _ref.listen<AsyncValue<List<Inspector>>>(inspectorProvider, (previous, next) {
      next.whenData((availableInspectors) {
        _validateAndUpdateSelectedInspector(state.inspectorId, availableInspectors);
      });
    });
    final initialInspectorsAsync = _ref.read(inspectorProvider);
    initialInspectorsAsync.whenData((availableInspectors) {
      _validateAndUpdateSelectedInspector(state.inspectorId, availableInspectors);
    });

    _loadFormData();
  }

  void _validateAndUpdateCabangInspeksi(String? currentCabang, List<String> availableBranches) {
    if (currentCabang != null) {
      if (availableBranches.isEmpty || !availableBranches.contains(currentCabang)) {
        state = state.copyWith(cabangInspeksi: null);
      }
      // If currentCabang is valid and in availableBranches, no change needed.
    }
    // If currentCabang is null, no change needed.
  }

  void _validateAndUpdateSelectedInspector(String? currentInspectorId, List<Inspector> availableInspectors) {
    if (currentInspectorId != null) {
      final isValid = availableInspectors.any((inspector) => inspector.id == currentInspectorId);
      if (availableInspectors.isEmpty || !isValid) {
        state = state.copyWith(
          inspectorId: null, // Directly set to null
          namaInspektor: null, // Directly set to null
        );
      } else if (isValid) {
        final selectedInspector = availableInspectors.firstWhere((inspector) => inspector.id == currentInspectorId);
        if (state.namaInspektor != selectedInspector.name) {
          state = state.copyWith(namaInspektor: selectedInspector.name);
        }
      }
    } else {
      if (state.namaInspektor != null) {
        state = state.copyWith(namaInspektor: null); // Directly set to null
      }
    }
  }

  void updateSelectedInspector(Inspector? selectedInspector) {
    if (selectedInspector != null) {
      state = state.copyWith(
        inspectorId: selectedInspector.id,
        namaInspektor: selectedInspector.name,
      );
    } else {
      state = state.copyWith(
        inspectorId: null, // Directly set to null
        namaInspektor: null, // Directly set to null
      );
    }
  }


  void updateNamaCustomer(String name) {
    state = state.copyWith(namaCustomer: name);
  }

  void updateCabangInspeksi(String? cabang) {
    final availableBranches = _ref.read(inspectionBranchesProvider).asData?.value ?? [];
    if (cabang != null && availableBranches.isNotEmpty && !availableBranches.contains(cabang)) {
      state = state.copyWith(cabangInspeksi: cabang);
    } else if (cabang == null || (availableBranches.contains(cabang)) || availableBranches.isEmpty) {
      state = state.copyWith(cabangInspeksi: cabang);
    }
  }

  void updateTanggalInspeksi(DateTime? date) {
    state = state.copyWith(tanggalInspeksi: date);
  }

  void updateMerekKendaraan(String merek) {
    state = state.copyWith(merekKendaraan: merek);
  }

  void updateTipeKendaraan(String tipe) {
    state = state.copyWith(tipeKendaraan: tipe);
  }

  void updateTahun(String tahun) {
    state = state.copyWith(tahun: tahun);
  }

  void updateTransmisi(String transmisi) {
    state = state.copyWith(transmisi: transmisi);
  }

  void updateWarnaKendaraan(String warna) {
    state = state.copyWith(warnaKendaraan: warna);
  }

  void updateOdometer(String odometer) {
    state = state.copyWith(odometer: odometer);
  }

  void updateKepemilikan(String kepemilikan) {
    state = state.copyWith(kepemilikan: kepemilikan);
  }

  void updatePlatNomor(String platNomor) {
    state = state.copyWith(platNomor: platNomor);
  }

  void updatePajak1TahunDate(DateTime? date) {
    state = state.copyWith(pajak1TahunDate: date);
  }

  void updatePajak5TahunDate(DateTime? date) {
    state = state.copyWith(pajak5TahunDate: date);
  }

  void updateBiayaPajak(String biaya) {
    state = state.copyWith(biayaPajak: biaya);
  }

  // Page Three Update Methods
  void updateBukuService(String? value) {
    state = state.copyWith(bukuService: value);
  }

  void updateKunciSerep(String? value) {
    state = state.copyWith(kunciSerep: value);
  }

  void updateBukuManual(String? value) {
    state = state.copyWith(bukuManual: value);
  }

  void updateBanSerep(String? value) {
    state = state.copyWith(banSerep: value);
  }

  void updateBpkb(String? value) {
    state = state.copyWith(bpkb: value);
  }

  void updateDongkrak(String? value) {
    state = state.copyWith(dongkrak: value);
  }

  void updateToolkit(String? value) {
    state = state.copyWith(toolkit: value);
  }

  void updateNoRangka(String? value) {
    state = state.copyWith(noRangka: value);
  }

  void updateNoMesin(String? value) {
    state = state.copyWith(noMesin: value);
  }

  // New update methods for Page Four
  void updateIndikasiTabrakan(String? value) {
    state = state.copyWith(indikasiTabrakan: value);
  }

  void updateIndikasiBanjir(String? value) {
    state = state.copyWith(indikasiBanjir: value);
  }

  void updateIndikasiOdometerReset(String? value) {
    state = state.copyWith(indikasiOdometerReset: value);
  }

  void updatePosisiBan(String? value) {
    state = state.copyWith(posisiBan: value);
  }

  void updateMerk(String? value) {
    state = state.copyWith(merk: value);
  }

  void updateTipeVelg(String? value) {
    state = state.copyWith(tipeVelg: value);
  }

  void updateKetebalan(String? value) {
    state = state.copyWith(ketebalan: value);
  }

  // New update methods for selected indices
  void updateInteriorSelectedValue(int value) {
    state = state.copyWith(interiorSelectedValue: value);
  }

  void updateEksteriorSelectedValue(int value) {
    state = state.copyWith(eksteriorSelectedValue: value);
  }

  void updateKakiKakiSelectedValue(int value) {
    state = state.copyWith(kakiKakiSelectedValue: value);
  }

  void updateMesinSelectedValue(int value) {
    state = state.copyWith(mesinSelectedValue: value);
  }

  void updatePenilaianKeseluruhanSelectedValue(int value) {
    state = state.copyWith(penilaianKeseluruhanSelectedValue: value);
  }

  // NEW: Update methods for ExpandableTextField data
  void updateKeteranganInterior(List<String> lines) {
    state = state.copyWith(keteranganInterior: lines);
  }

  void updateKeteranganEksterior(List<String> lines) {
    state = state.copyWith(keteranganEksterior: lines);
  }

  void updateKeteranganKakiKaki(List<String> lines) {
    state = state.copyWith(keteranganKakiKaki: lines);
  }

  void updateKeteranganMesin(List<String> lines) {
    state = state.copyWith(keteranganMesin: lines);
  }

  void updateDeskripsiKeseluruhan(List<String> lines) {
    state = state.copyWith(deskripsiKeseluruhan: lines);
  }

  // New update methods for Page Five One
  void updateAirbagSelectedValue(int? value) {
    state = state.copyWith(airbagSelectedValue: value);
  }

  void updateSistemAudioSelectedValue(int? value) {
    state = state.copyWith(sistemAudioSelectedValue: value);
  }

  void updatePowerWindowSelectedValue(int? value) {
    state = state.copyWith(powerWindowSelectedValue: value);
  }

  void updateSistemAcSelectedValue(int? value) {
    state = state.copyWith(sistemAcSelectedValue: value);
  }

  void updateFiturCatatanList(List<String> lines) {
    state = state.copyWith(fiturCatatanList: lines);
  }

  // New update methods for Page Five Two
  void updateGetaranMesinSelectedValue(int? value) {
    state = state.copyWith(getaranMesinSelectedValue: value);
  }

  void updateSuaraMesinSelectedValue(int? value) {
    state = state.copyWith(suaraMesinSelectedValue: value);
  }

  void updateTransmisiSelectedValue(int? value) {
    state = state.copyWith(transmisiSelectedValue: value);
  }

  void updatePompaPowerSteeringSelectedValue(int? value) {
    state = state.copyWith(pompaPowerSteeringSelectedValue: value);
  }

  void updateCoverTimingChainSelectedValue(int? value) {
    state = state.copyWith(coverTimingChainSelectedValue: value);
  }

  void updateOliPowerSteeringSelectedValue(int? value) {
    state = state.copyWith(oliPowerSteeringSelectedValue: value);
  }

  void updateAccuSelectedValue(int? value) {
    state = state.copyWith(accuSelectedValue: value);
  }

  void updateKompressorAcSelectedValue(int? value) {
    state = state.copyWith(kompressorAcSelectedValue: value);
  }

  void updateFanSelectedValue(int? value) {
    state = state.copyWith(fanSelectedValue: value);
  }

  void updateSelangSelectedValue(int? value) {
    state = state.copyWith(selangSelectedValue: value);
  }

  void updateKarterOliSelectedValue(int? value) {
    state = state.copyWith(karterOliSelectedValue: value);
  }

  void updateOilRemSelectedValue(int? value) {
    state = state.copyWith(oilRemSelectedValue: value);
  }

  void updateKabelSelectedValue(int? value) {
    state = state.copyWith(kabelSelectedValue: value);
  }

  void updateKondensorSelectedValue(int? value) {
    state = state.copyWith(kondensorSelectedValue: value);
  }

  void updateRadiatorSelectedValue(int? value) {
    state = state.copyWith(radiatorSelectedValue: value);
  }

  void updateCylinderHeadSelectedValue(int? value) {
    state = state.copyWith(cylinderHeadSelectedValue: value);
  }

  void updateOliMesinSelectedValue(int? value) {
    state = state.copyWith(oliMesinSelectedValue: value);
  }

  void updateAirRadiatorSelectedValue(int? value) {
    state = state.copyWith(airRadiatorSelectedValue: value);
  }

  void updateCoverKlepSelectedValue(int? value) {
    state = state.copyWith(coverKlepSelectedValue: value);
  }

  void updateAlternatorSelectedValue(int? value) {
    state = state.copyWith(alternatorSelectedValue: value);
  }

  void updateWaterPumpSelectedValue(int? value) {
    state = state.copyWith(waterPumpSelectedValue: value);
  }

  void updateBeltSelectedValue(int? value) {
    state = state.copyWith(beltSelectedValue: value);
  }

  void updateOliTransmisiSelectedValue(int? value) {
    state = state.copyWith(oliTransmisiSelectedValue: value);
  }

  void updateCylinderBlockSelectedValue(int? value) {
    state = state.copyWith(cylinderBlockSelectedValue: value);
  }

  void updateBushingBesarSelectedValue(int? value) {
    state = state.copyWith(bushingBesarSelectedValue: value);
  }

  void updateBushingKecilSelectedValue(int? value) {
    state = state.copyWith(bushingKecilSelectedValue: value);
  }

  void updateTutupRadiatorSelectedValue(int? value) {
    state = state.copyWith(tutupRadiatorSelectedValue: value);
  }

  void updateMesinCatatanList(List<String> lines) {
    state = state.copyWith(mesinCatatanList: lines);
  }

  // New update methods for Page Five Three
  void updateStirSelectedValue(int? value) {
    state = state.copyWith(stirSelectedValue: value);
  }


  void updateRemTanganSelectedValue(int? value) {
    state = state.copyWith(remTanganSelectedValue: value);
  }


  void updatePedalSelectedValue(int? value) {
    state = state.copyWith(pedalSelectedValue: value);
  }


  void updateSwitchWiperSelectedValue(int? value) {
    state = state.copyWith(switchWiperSelectedValue: value);
  }


  void updateLampuHazardSelectedValue(int? value) {
    state = state.copyWith(lampuHazardSelectedValue: value);
  }


  void updatePanelDashboardSelectedValue(int? value) {
    state = state.copyWith(panelDashboardSelectedValue: value);
  }


  void updatePembukaKapMesinSelectedValue(int? value) {
    state = state.copyWith(pembukaKapMesinSelectedValue: value);
  }


  void updatePembukaBagasiSelectedValue(int? value) {
    state = state.copyWith(pembukaBagasiSelectedValue: value);
  }


  void updateJokDepanSelectedValue(int? value) {
    state = state.copyWith(jokDepanSelectedValue: value);
  }


  void updateAromaInteriorSelectedValue(int? value) {
    state = state.copyWith(aromaInteriorSelectedValue: value);
  }


  void updateHandlePintuSelectedValue(int? value) {
    state = state.copyWith(handlePintuSelectedValue: value);
  }


  void updateConsoleBoxSelectedValue(int? value) {
    state = state.copyWith(consoleBoxSelectedValue: value);
  }


  void updateSpionTengahSelectedValue(int? value) {
    state = state.copyWith(spionTengahSelectedValue: value);
  }


  void updateTuasPersnelingSelectedValue(int? value) {
    state = state.copyWith(tuasPersnelingSelectedValue: value);
  }


  void updateJokBelakangSelectedValue(int? value) {
    state = state.copyWith(jokBelakangSelectedValue: value);
  }


  void updatePanelIndikatorSelectedValue(int? value) {
    state = state.copyWith(panelIndikatorSelectedValue: value);
  }


  void updateSwitchLampuSelectedValue(int? value) {
    state = state.copyWith(switchLampuSelectedValue: value);
  }


  void updateKarpetDasarSelectedValue(int? value) {
    state = state.copyWith(karpetDasarSelectedValue: value);
  }


  void updateKlaksonSelectedValue(int? value) {
    state = state.copyWith(klaksonSelectedValue: value);
  }


  void updateSunVisorSelectedValue(int? value) {
    state = state.copyWith(sunVisorSelectedValue: value);
  }


  void updateTuasTangkiBensinSelectedValue(int? value) {
    state = state.copyWith(tuasTangkiBensinSelectedValue: value);
  }


  void updateSabukPengamanSelectedValue(int? value) {
    state = state.copyWith(sabukPengamanSelectedValue: value);
  }


  void updateTrimInteriorSelectedValue(int? value) {
    state = state.copyWith(trimInteriorSelectedValue: value);
  }


  void updatePlafonSelectedValue(int? value) {
    state = state.copyWith(plafonSelectedValue: value);
  }


  void updateInteriorCatatanList(List<String> lines) {
    state = state.copyWith(interiorCatatanList: lines);
  }

  // New update methods for Page Five Four
  void updateBumperDepanSelectedValue(int? value) {
    state = state.copyWith(bumperDepanSelectedValue: value);
  }


  void updateKapMesinSelectedValue(int? value) {
    state = state.copyWith(kapMesinSelectedValue: value);
  }


  void updateLampuUtamaSelectedValue(int? value) {
    state = state.copyWith(lampuUtamaSelectedValue: value);
  }


  void updatePanelAtapSelectedValue(int? value) {
    state = state.copyWith(panelAtapSelectedValue: value);
  }


  void updateGrillSelectedValue(int? value) {
    state = state.copyWith(grillSelectedValue: value);
  }


  void updateLampuFoglampSelectedValue(int? value) {
    state = state.copyWith(lampuFoglampSelectedValue: value);
  }


  void updateKacaBeningSelectedValue(int? value) {
    state = state.copyWith(kacaBeningSelectedValue: value);
  }


  void updateWiperBelakangSelectedValue(int? value) {
    state = state.copyWith(wiperBelakangSelectedValue: value);
  }


  void updateBumperBelakangSelectedValue(int? value) {
    state = state.copyWith(bumperBelakangSelectedValue: value);
  }


  void updateLampuBelakangSelectedValue(int? value) {
    state = state.copyWith(lampuBelakangSelectedValue: value);
  }


  void updateTrunklidSelectedValue(int? value) {
    state = state.copyWith(trunklidSelectedValue: value);
  }


  void updateKacaDepanSelectedValue(int? value) {
    state = state.copyWith(kacaDepanSelectedValue: value);
  }


  void updateFenderKananSelectedValue(int? value) {
    state = state.copyWith(fenderKananSelectedValue: value);
  }


  void updateQuarterPanelKananSelectedValue(int? value) {
    state = state.copyWith(quarterPanelKananSelectedValue: value);
  }


  void updatePintuBelakangKananSelectedValue(int? value) {
    state = state.copyWith(pintuBelakangKananSelectedValue: value);
  }


  void updateSpionKananSelectedValue(int? value) {
    state = state.copyWith(spionKananSelectedValue: value);
  }


  void updateLisplangKananSelectedValue(int? value) {
    state = state.copyWith(lisplangKananSelectedValue: value);
  }


  void updateSideSkirtKananSelectedValue(int? value) {
    state = state.copyWith(sideSkirtKananSelectedValue: value);
  }


  void updateDaunWiperSelectedValue(int? value) {
    state = state.copyWith(daunWiperSelectedValue: value);
  }


  void updatePintuBelakangSelectedValue(int? value) {
    state = state.copyWith(pintuBelakangSelectedValue: value);
  }


  void updateFenderKiriSelectedValue(int? value) {
    state = state.copyWith(fenderKiriSelectedValue: value);
  }


  void updateQuarterPanelKiriSelectedValue(int? value) {
    state = state.copyWith(quarterPanelKiriSelectedValue: value);
  }


  void updatePintuDepanSelectedValue(int? value) {
    state = state.copyWith(pintuDepanSelectedValue: value);
  }


  void updateKacaJendelaKananSelectedValue(int? value) {
    state = state.copyWith(kacaJendelaKananSelectedValue: value);
  }


  void updatePintuBelakangKiriSelectedValue(int? value) {
    state = state.copyWith(pintuBelakangKiriSelectedValue: value);
  }


  void updateSpionKiriSelectedValue(int? value) {
    state = state.copyWith(spionKiriSelectedValue: value);
  }


  void updatePintuDepanKiriSelectedValue(int? value) {
    state = state.copyWith(pintuDepanKiriSelectedValue: value);
  }


  void updateKacaJendelaKiriSelectedValue(int? value) {
    state = state.copyWith(kacaJendelaKiriSelectedValue: value);
  }


  void updateLisplangKiriSelectedValue(int? value) {
    state = state.copyWith(lisplangKiriSelectedValue: value);
  }


  void updateSideSkirtKiriSelectedValue(int? value) {
    state = state.copyWith(sideSkirtKiriSelectedValue: value);
  }


  void updateEksteriorCatatanList(List<String> lines) {
    state = state.copyWith(eksteriorCatatanList: lines);
  }

  void updateRepairEstimations(List<Map<String, String>> estimations) {
    state = state.copyWith(repairEstimations: estimations);
  }

  // New update methods for Page Five Five
  void updateBanDepanSelectedValue(int? value) {
    state = state.copyWith(banDepanSelectedValue: value);
  }


  void updateVelgDepanSelectedValue(int? value) {
    state = state.copyWith(velgDepanSelectedValue: value);
  }


  void updateDiscBrakeSelectedValue(int? value) {
    state = state.copyWith(discBrakeSelectedValue: value);
  }


  void updateMasterRemSelectedValue(int? value) {
    state = state.copyWith(masterRemSelectedValue: value);
  }


  void updateTieRodSelectedValue(int? value) {
    state = state.copyWith(tieRodSelectedValue: value);
  }


  void updateGardanSelectedValue(int? value) {
    state = state.copyWith(gardanSelectedValue: value);
  }


  void updateBanBelakangSelectedValue(int? value) {
    state = state.copyWith(banBelakangSelectedValue: value);
  }


  void updateVelgBelakangSelectedValue(int? value) {
    state = state.copyWith(velgBelakangSelectedValue: value);
  }


  void updateBrakePadSelectedValue(int? value) {
    state = state.copyWith(brakePadSelectedValue: value);
  }


  void updateCrossmemberSelectedValue(int? value) {
    state = state.copyWith(crossmemberSelectedValue: value);
  }


  void updateKnalpotSelectedValue(int? value) {
    state = state.copyWith(knalpotSelectedValue: value);
  }


  void updateBalljointSelectedValue(int? value) {
    state = state.copyWith(balljointSelectedValue: value);
  }


  void updateRocksteerSelectedValue(int? value) {
    state = state.copyWith(rocksteerSelectedValue: value);
  }


  void updateKaretBootSelectedValue(int? value) {
    state = state.copyWith(karetBootSelectedValue: value);
  }


  void updateUpperLowerArmSelectedValue(int? value) {
    state = state.copyWith(upperLowerArmSelectedValue: value);
  }


  void updateShockBreakerSelectedValue(int? value) {
    state = state.copyWith(shockBreakerSelectedValue: value);
  }


  void updateLinkStabilizerSelectedValue(int? value) {
    state = state.copyWith(linkStabilizerSelectedValue: value);
  }


  void updateBanDanKakiKakiCatatanList(List<String> lines) {
    state = state.copyWith(banDanKakiKakiCatatanList: lines);
  }

  // New update methods for Page Five Six (Test Drive)
  void updateBunyiGetaranSelectedValue(int? value) {
    state = state.copyWith(bunyiGetaranSelectedValue: value);
  }


  void updatePerformaStirSelectedValue(int? value) {
    state = state.copyWith(performaStirSelectedValue: value);
  }


  void updatePerpindahanTransmisiSelectedValue(int? value) {
    state = state.copyWith(perpindahanTransmisiSelectedValue: value);
  }


  void updateStirBalanceSelectedValue(int? value) {
    state = state.copyWith(stirBalanceSelectedValue: value);
  }


  void updatePerformaSuspensiSelectedValue(int? value) {
    state = state.copyWith(performaSuspensiSelectedValue: value);
  }


  void updatePerformaKoplingSelectedValue(int? value) {
    state = state.copyWith(performaKoplingSelectedValue: value);
  }


  void updateRpmSelectedValue(int? value) {
    state = state.copyWith(rpmSelectedValue: value);
  }


  void updateTestDriveCatatanList(List<String> lines) {
    state = state.copyWith(testDriveCatatanList: lines);
  }

  // New update methods for Page Five Seven (Tools Test)
  void updateTebalCatBodyDepanSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyDepanSelectedValue: value);
  }


  void updateTebalCatBodyKiriSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyKiriSelectedValue: value);
  }


  void updateTemperatureAcMobilSelectedValue(int? value) {
    state = state.copyWith(temperatureAcMobilSelectedValue: value);
  }


  void updateTebalCatBodyKananSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyKananSelectedValue: value);
  }


  void updateTebalCatBodyBelakangSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyBelakangSelectedValue: value);
  }


  void updateObdScannerSelectedValue(int? value) {
    state = state.copyWith(obdScannerSelectedValue: value);
  }


  void updateTebalCatBodyAtapSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyAtapSelectedValue: value);
  }


  void updateTestAccuSelectedValue(int? value) {
    state = state.copyWith(testAccuSelectedValue: value);
  }


  void updateToolsTestCatatanList(List<String> lines) {
    state = state.copyWith(toolsTestCatatanList: lines);
  }

  Future<void> _loadFormData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString != null) {
      final jsonMap = json.decode(jsonString);
      state = FormData.fromJson(jsonMap);
    }
  }

  Future<void> _saveFormData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(state.toJson());
    await prefs.setString(_storageKey, jsonString);
  }

  @override
  set state(FormData value) {
    super.state = value;
    _saveFormData();
  }

  void resetFormData() {
    state = FormData();
    _saveFormData();
  }
}

final formProvider = StateNotifierProvider<FormNotifier, FormData>((ref) {
  return FormNotifier(ref); // Pass ref to the constructor
});

extension on FormData {
  FormData copyWith({
    String? namaInspektor,
    String? inspectorId,
    String? namaCustomer,
    String? cabangInspeksi,
    DateTime? tanggalInspeksi,
    String? merekKendaraan,
    String? tipeKendaraan,
    String? tahun,
    String? transmisi,
    String? warnaKendaraan,
    String? odometer,
    String? kepemilikan,
    String? platNomor,
    DateTime? pajak1TahunDate,
    DateTime? pajak5TahunDate,
    String? biayaPajak,
    String? bukuService,
    String? kunciSerep,
    String? bukuManual,
    String? banSerep,
    String? bpkb,
    String? dongkrak,
    String? toolkit,
    String? noRangka,
    String? noMesin,
    String? indikasiTabrakan,
    String? indikasiBanjir,
    String? indikasiOdometerReset,
    String? posisiBan,
    String? merk,
    String? tipeVelg,
    String? ketebalan,
    int? interiorSelectedValue,
    int? eksteriorSelectedValue,
    int? kakiKakiSelectedValue,
    int? mesinSelectedValue,
    int? penilaianKeseluruhanSelectedValue,
    List<String>? keteranganInterior,
    List<String>? keteranganEksterior,
    List<String>? keteranganKakiKaki,
    List<String>? keteranganMesin,
    List<String>? deskripsiKeseluruhan,
    List<Map<String, String>>? repairEstimations,
    int? airbagSelectedValue,
    int? sistemAudioSelectedValue,
    int? powerWindowSelectedValue,
    int? sistemAcSelectedValue,
    List<String>? fiturCatatanList,
    int? getaranMesinSelectedValue,
    int? suaraMesinSelectedValue,
    int? transmisiSelectedValue,
    int? pompaPowerSteeringSelectedValue,
    int? coverTimingChainSelectedValue,
    int? oliPowerSteeringSelectedValue,
    int? accuSelectedValue,
    int? kompressorAcSelectedValue,
    int? fanSelectedValue,
    int? selangSelectedValue,
    int? karterOliSelectedValue,
    int? oilRemSelectedValue,
    int? kabelSelectedValue,
    int? kondensorSelectedValue,
    int? radiatorSelectedValue,
    int? cylinderHeadSelectedValue,
    int? oliMesinSelectedValue,
    int? airRadiatorSelectedValue,
    int? coverKlepSelectedValue,
    int? alternatorSelectedValue,
    int? waterPumpSelectedValue,
    int? beltSelectedValue,
    int? oliTransmisiSelectedValue,
    int? cylinderBlockSelectedValue,
    int? bushingBesarSelectedValue,
    int? bushingKecilSelectedValue,
    int? tutupRadiatorSelectedValue,
    List<String>? mesinCatatanList,
    int? stirSelectedValue,
    int? remTanganSelectedValue,
    int? pedalSelectedValue,
    int? switchWiperSelectedValue,
    int? lampuHazardSelectedValue,
    int? panelDashboardSelectedValue,
    int? pembukaKapMesinSelectedValue,
    int? pembukaBagasiSelectedValue,
    int? jokDepanSelectedValue,
    int? aromaInteriorSelectedValue,
    int? handlePintuSelectedValue,
    int? consoleBoxSelectedValue,
    int? spionTengahSelectedValue,
    int? tuasPersnelingSelectedValue,
    int? jokBelakangSelectedValue,
    int? panelIndikatorSelectedValue,
    int? switchLampuSelectedValue,
    int? karpetDasarSelectedValue,
    int? klaksonSelectedValue,
    int? sunVisorSelectedValue,
    int? tuasTangkiBensinSelectedValue,
    int? sabukPengamanSelectedValue,
    int? trimInteriorSelectedValue,
    int? plafonSelectedValue,
    List<String>? interiorCatatanList,
    int? bumperDepanSelectedValue,
    int? kapMesinSelectedValue,
    int? lampuUtamaSelectedValue,
    int? panelAtapSelectedValue,
    int? grillSelectedValue,
    int? lampuFoglampSelectedValue,
    int? kacaBeningSelectedValue,
    int? wiperBelakangSelectedValue,
    int? bumperBelakangSelectedValue,
    int? lampuBelakangSelectedValue,
    int? trunklidSelectedValue,
    int? kacaDepanSelectedValue,
    int? fenderKananSelectedValue,
    int? quarterPanelKananSelectedValue,
    int? pintuBelakangKananSelectedValue,
    int? spionKananSelectedValue,
    int? lisplangKananSelectedValue,
    int? sideSkirtKananSelectedValue,
    int? daunWiperSelectedValue,
    int? pintuBelakangSelectedValue,
    int? fenderKiriSelectedValue,
    int? quarterPanelKiriSelectedValue,
    int? pintuDepanSelectedValue,
    int? kacaJendelaKananSelectedValue,
    int? pintuBelakangKiriSelectedValue,
    int? spionKiriSelectedValue,
    int? pintuDepanKiriSelectedValue,
    int? kacaJendelaKiriSelectedValue,
    int? lisplangKiriSelectedValue,
    int? sideSkirtKiriSelectedValue,
    List<String>? eksteriorCatatanList,
    int? banDepanSelectedValue,
    int? velgDepanSelectedValue,
    int? discBrakeSelectedValue,
    int? masterRemSelectedValue,
    int? tieRodSelectedValue,
    int? gardanSelectedValue,
    int? banBelakangSelectedValue,
    int? velgBelakangSelectedValue,
    int? brakePadSelectedValue,
    int? crossmemberSelectedValue,
    int? knalpotSelectedValue,
    int? balljointSelectedValue,
    int? rocksteerSelectedValue,
    int? karetBootSelectedValue,
    int? upperLowerArmSelectedValue,
    int? shockBreakerSelectedValue,
    int? linkStabilizerSelectedValue,
    List<String>? banDanKakiKakiCatatanList,
    int? bunyiGetaranSelectedValue,
    int? performaStirSelectedValue,
    int? perpindahanTransmisiSelectedValue,
    int? stirBalanceSelectedValue,
    int? performaSuspensiSelectedValue,
    int? performaKoplingSelectedValue,
    int? rpmSelectedValue,
    List<String>? testDriveCatatanList,
    int? tebalCatBodyDepanSelectedValue,
    int? tebalCatBodyKiriSelectedValue,
    int? temperatureAcMobilSelectedValue,
    int? tebalCatBodyKananSelectedValue,
    int? tebalCatBodyBelakangSelectedValue,
    int? obdScannerSelectedValue,
    int? tebalCatBodyAtapSelectedValue,
    int? testAccuSelectedValue,
    List<String>? toolsTestCatatanList,
  }) {
    return FormData(
      namaInspektor: namaInspektor ?? this.namaInspektor,
      inspectorId: inspectorId ?? this.inspectorId,
      namaCustomer: namaCustomer ?? this.namaCustomer,
      cabangInspeksi: cabangInspeksi ?? this.cabangInspeksi,
      tanggalInspeksi: tanggalInspeksi ?? this.tanggalInspeksi,
      merekKendaraan: merekKendaraan ?? this.merekKendaraan,
      tipeKendaraan: tipeKendaraan ?? this.tipeKendaraan,
      tahun: tahun ?? this.tahun,
      transmisi: transmisi ?? this.transmisi,
      warnaKendaraan: warnaKendaraan ?? this.warnaKendaraan,
      odometer: odometer ?? this.odometer,
      kepemilikan: kepemilikan ?? this.kepemilikan,
      platNomor: platNomor ?? this.platNomor,
      pajak1TahunDate: pajak1TahunDate ?? this.pajak1TahunDate,
      pajak5TahunDate: pajak5TahunDate ?? this.pajak5TahunDate,
      biayaPajak: biayaPajak ?? this.biayaPajak,
      bukuService: bukuService ?? this.bukuService,
      kunciSerep: kunciSerep ?? this.kunciSerep,
      bukuManual: bukuManual ?? this.bukuManual,
      banSerep: banSerep ?? this.banSerep,
      bpkb: bpkb ?? this.bpkb,
      dongkrak: dongkrak ?? this.dongkrak,
      toolkit: toolkit ?? this.toolkit,
      noRangka: noRangka ?? this.noRangka,
      noMesin: noMesin ?? this.noMesin,
      indikasiTabrakan: indikasiTabrakan ?? this.indikasiTabrakan,
      indikasiBanjir: indikasiBanjir ?? this.indikasiBanjir,
      indikasiOdometerReset: indikasiOdometerReset ?? this.indikasiOdometerReset,
      posisiBan: posisiBan ?? this.posisiBan,
      merk: merk ?? this.merk,
      tipeVelg: tipeVelg ?? this.tipeVelg,
      ketebalan: ketebalan ?? this.ketebalan,
      interiorSelectedValue: interiorSelectedValue ?? this.interiorSelectedValue,
      eksteriorSelectedValue: eksteriorSelectedValue ?? this.eksteriorSelectedValue,
      kakiKakiSelectedValue: kakiKakiSelectedValue ?? this.kakiKakiSelectedValue,
      mesinSelectedValue: mesinSelectedValue ?? this.mesinSelectedValue,
      penilaianKeseluruhanSelectedValue: penilaianKeseluruhanSelectedValue ?? this.penilaianKeseluruhanSelectedValue,
      keteranganInterior: keteranganInterior ?? this.keteranganInterior,
      keteranganEksterior: keteranganEksterior ?? this.keteranganEksterior,
      keteranganKakiKaki: keteranganKakiKaki ?? this.keteranganKakiKaki,
      keteranganMesin: keteranganMesin ?? this.keteranganMesin,
      deskripsiKeseluruhan: deskripsiKeseluruhan ?? this.deskripsiKeseluruhan,
      repairEstimations: repairEstimations ?? this.repairEstimations,
      airbagSelectedValue: airbagSelectedValue ?? this.airbagSelectedValue,
      sistemAudioSelectedValue: sistemAudioSelectedValue ?? this.sistemAudioSelectedValue,
      powerWindowSelectedValue: powerWindowSelectedValue ?? this.powerWindowSelectedValue,
      sistemAcSelectedValue: sistemAcSelectedValue ?? this.sistemAcSelectedValue,
      fiturCatatanList: fiturCatatanList ?? this.fiturCatatanList,
      getaranMesinSelectedValue: getaranMesinSelectedValue ?? this.getaranMesinSelectedValue,
      suaraMesinSelectedValue: suaraMesinSelectedValue ?? this.suaraMesinSelectedValue,
      transmisiSelectedValue: transmisiSelectedValue ?? this.transmisiSelectedValue,
      pompaPowerSteeringSelectedValue: pompaPowerSteeringSelectedValue ?? this.pompaPowerSteeringSelectedValue,
      coverTimingChainSelectedValue: coverTimingChainSelectedValue ?? this.coverTimingChainSelectedValue,
      oliPowerSteeringSelectedValue: oliPowerSteeringSelectedValue ?? this.oliPowerSteeringSelectedValue,
      accuSelectedValue: accuSelectedValue ?? this.accuSelectedValue,
      kompressorAcSelectedValue: kompressorAcSelectedValue ?? this.kompressorAcSelectedValue,
      fanSelectedValue: fanSelectedValue ?? this.fanSelectedValue,
      selangSelectedValue: selangSelectedValue ?? this.selangSelectedValue,
      karterOliSelectedValue: karterOliSelectedValue ?? this.karterOliSelectedValue,
      oilRemSelectedValue: oilRemSelectedValue ?? this.oilRemSelectedValue,
      kabelSelectedValue: kabelSelectedValue ?? this.kabelSelectedValue,
      kondensorSelectedValue: kondensorSelectedValue ?? this.kondensorSelectedValue,
      radiatorSelectedValue: radiatorSelectedValue ?? this.radiatorSelectedValue,
      cylinderHeadSelectedValue: cylinderHeadSelectedValue ?? this.cylinderHeadSelectedValue,
      oliMesinSelectedValue: oliMesinSelectedValue ?? this.oliMesinSelectedValue,
      airRadiatorSelectedValue: airRadiatorSelectedValue ?? this.airRadiatorSelectedValue,
      coverKlepSelectedValue: coverKlepSelectedValue ?? this.coverKlepSelectedValue,
      alternatorSelectedValue: alternatorSelectedValue ?? this.alternatorSelectedValue,
      waterPumpSelectedValue: waterPumpSelectedValue ?? this.waterPumpSelectedValue,
      beltSelectedValue: beltSelectedValue ?? this.beltSelectedValue,
      oliTransmisiSelectedValue: oliTransmisiSelectedValue ?? this.oliTransmisiSelectedValue,
      cylinderBlockSelectedValue: cylinderBlockSelectedValue ?? this.cylinderBlockSelectedValue,
      bushingBesarSelectedValue: bushingBesarSelectedValue ?? this.bushingBesarSelectedValue,
      bushingKecilSelectedValue: bushingKecilSelectedValue ?? this.bushingKecilSelectedValue,
      tutupRadiatorSelectedValue: tutupRadiatorSelectedValue ?? this.tutupRadiatorSelectedValue,
      mesinCatatanList: mesinCatatanList ?? this.mesinCatatanList,
      stirSelectedValue: stirSelectedValue ?? this.stirSelectedValue,
      remTanganSelectedValue: remTanganSelectedValue ?? this.remTanganSelectedValue,
      pedalSelectedValue: pedalSelectedValue ?? this.pedalSelectedValue,
      switchWiperSelectedValue: switchWiperSelectedValue ?? this.switchWiperSelectedValue,
      lampuHazardSelectedValue: lampuHazardSelectedValue ?? this.lampuHazardSelectedValue,
      panelDashboardSelectedValue: panelDashboardSelectedValue ?? this.panelDashboardSelectedValue,
      pembukaKapMesinSelectedValue: pembukaKapMesinSelectedValue ?? this.pembukaKapMesinSelectedValue,
      pembukaBagasiSelectedValue: pembukaBagasiSelectedValue ?? this.pembukaBagasiSelectedValue,
      jokDepanSelectedValue: jokDepanSelectedValue ?? this.jokDepanSelectedValue,
      aromaInteriorSelectedValue: aromaInteriorSelectedValue ?? this.aromaInteriorSelectedValue,
      handlePintuSelectedValue: handlePintuSelectedValue ?? this.handlePintuSelectedValue,
      consoleBoxSelectedValue: consoleBoxSelectedValue ?? this.consoleBoxSelectedValue,
      spionTengahSelectedValue: spionTengahSelectedValue ?? this.spionTengahSelectedValue,
      tuasPersnelingSelectedValue: tuasPersnelingSelectedValue ?? this.tuasPersnelingSelectedValue,
      jokBelakangSelectedValue: jokBelakangSelectedValue ?? this.jokBelakangSelectedValue,
      panelIndikatorSelectedValue: panelIndikatorSelectedValue ?? this.panelIndikatorSelectedValue,
      switchLampuSelectedValue: switchLampuSelectedValue ?? this.switchLampuSelectedValue,
      karpetDasarSelectedValue: karpetDasarSelectedValue ?? this.karpetDasarSelectedValue,
      klaksonSelectedValue: klaksonSelectedValue ?? this.klaksonSelectedValue,
      sunVisorSelectedValue: sunVisorSelectedValue ?? this.sunVisorSelectedValue,
      tuasTangkiBensinSelectedValue: tuasTangkiBensinSelectedValue ?? this.tuasTangkiBensinSelectedValue,
      sabukPengamanSelectedValue: sabukPengamanSelectedValue ?? this.sabukPengamanSelectedValue,
      trimInteriorSelectedValue: trimInteriorSelectedValue ?? this.trimInteriorSelectedValue,
      plafonSelectedValue: plafonSelectedValue ?? this.plafonSelectedValue,
      interiorCatatanList: interiorCatatanList ?? this.interiorCatatanList,
      bumperDepanSelectedValue: bumperDepanSelectedValue ?? this.bumperDepanSelectedValue,
      kapMesinSelectedValue: kapMesinSelectedValue ?? this.kapMesinSelectedValue,
      lampuUtamaSelectedValue: lampuUtamaSelectedValue ?? this.lampuUtamaSelectedValue,
      panelAtapSelectedValue: panelAtapSelectedValue ?? this.panelAtapSelectedValue,
      grillSelectedValue: grillSelectedValue ?? this.grillSelectedValue,
      lampuFoglampSelectedValue: lampuFoglampSelectedValue ?? this.lampuFoglampSelectedValue,
      kacaBeningSelectedValue: kacaBeningSelectedValue ?? this.kacaBeningSelectedValue,
      wiperBelakangSelectedValue: wiperBelakangSelectedValue ?? this.wiperBelakangSelectedValue,
      bumperBelakangSelectedValue: bumperBelakangSelectedValue ?? this.bumperBelakangSelectedValue,
      lampuBelakangSelectedValue: lampuBelakangSelectedValue ?? this.lampuBelakangSelectedValue,
      trunklidSelectedValue: trunklidSelectedValue ?? this.trunklidSelectedValue,
      kacaDepanSelectedValue: kacaDepanSelectedValue ?? this.kacaDepanSelectedValue,
      fenderKananSelectedValue: fenderKananSelectedValue ?? this.fenderKananSelectedValue,
      quarterPanelKananSelectedValue: quarterPanelKananSelectedValue ?? this.quarterPanelKananSelectedValue,
      pintuBelakangKananSelectedValue: pintuBelakangKananSelectedValue ?? this.pintuBelakangKananSelectedValue,
      spionKananSelectedValue: spionKananSelectedValue ?? this.spionKananSelectedValue,
      lisplangKananSelectedValue: lisplangKananSelectedValue ?? this.lisplangKananSelectedValue,
      sideSkirtKananSelectedValue: sideSkirtKananSelectedValue ?? this.sideSkirtKananSelectedValue,
      daunWiperSelectedValue: daunWiperSelectedValue ?? this.daunWiperSelectedValue,
      pintuBelakangSelectedValue: pintuBelakangSelectedValue ?? this.pintuBelakangSelectedValue,
      fenderKiriSelectedValue: fenderKiriSelectedValue ?? this.fenderKiriSelectedValue,
      quarterPanelKiriSelectedValue: quarterPanelKiriSelectedValue ?? this.quarterPanelKiriSelectedValue,
      pintuDepanSelectedValue: pintuDepanSelectedValue ?? this.pintuDepanSelectedValue,
      kacaJendelaKananSelectedValue: kacaJendelaKananSelectedValue ?? this.kacaJendelaKananSelectedValue,
      pintuBelakangKiriSelectedValue: pintuBelakangKiriSelectedValue ?? this.pintuBelakangKiriSelectedValue,
      spionKiriSelectedValue: spionKiriSelectedValue ?? this.spionKiriSelectedValue,
      pintuDepanKiriSelectedValue: pintuDepanKiriSelectedValue ?? this.pintuDepanKiriSelectedValue,
      kacaJendelaKiriSelectedValue: kacaJendelaKiriSelectedValue ?? this.kacaJendelaKiriSelectedValue,
      lisplangKiriSelectedValue: lisplangKiriSelectedValue ?? this.lisplangKiriSelectedValue,
      sideSkirtKiriSelectedValue: sideSkirtKiriSelectedValue ?? this.sideSkirtKiriSelectedValue,
      eksteriorCatatanList: eksteriorCatatanList ?? this.eksteriorCatatanList,
      banDepanSelectedValue: banDepanSelectedValue ?? this.banDepanSelectedValue,
      velgDepanSelectedValue: velgDepanSelectedValue ?? this.velgDepanSelectedValue,
      discBrakeSelectedValue: discBrakeSelectedValue ?? this.discBrakeSelectedValue,
      masterRemSelectedValue: masterRemSelectedValue ?? this.masterRemSelectedValue,
      tieRodSelectedValue: tieRodSelectedValue ?? this.tieRodSelectedValue,
      gardanSelectedValue: gardanSelectedValue ?? this.gardanSelectedValue,
      banBelakangSelectedValue: banBelakangSelectedValue ?? this.banBelakangSelectedValue,
      velgBelakangSelectedValue: velgBelakangSelectedValue ?? this.velgBelakangSelectedValue,
      brakePadSelectedValue: brakePadSelectedValue ?? this.brakePadSelectedValue,
      crossmemberSelectedValue: crossmemberSelectedValue ?? this.crossmemberSelectedValue,
      knalpotSelectedValue: knalpotSelectedValue ?? this.knalpotSelectedValue,
      balljointSelectedValue: balljointSelectedValue ?? this.balljointSelectedValue,
      rocksteerSelectedValue: rocksteerSelectedValue ?? this.rocksteerSelectedValue,
      karetBootSelectedValue: karetBootSelectedValue ?? this.karetBootSelectedValue,
      upperLowerArmSelectedValue: upperLowerArmSelectedValue ?? this.upperLowerArmSelectedValue,
      shockBreakerSelectedValue: shockBreakerSelectedValue ?? this.shockBreakerSelectedValue,
      linkStabilizerSelectedValue: linkStabilizerSelectedValue ?? this.linkStabilizerSelectedValue,
      banDanKakiKakiCatatanList: banDanKakiKakiCatatanList ?? this.banDanKakiKakiCatatanList,
      bunyiGetaranSelectedValue: bunyiGetaranSelectedValue ?? this.bunyiGetaranSelectedValue,
      performaStirSelectedValue: performaStirSelectedValue ?? this.performaStirSelectedValue,
      perpindahanTransmisiSelectedValue: perpindahanTransmisiSelectedValue ?? this.perpindahanTransmisiSelectedValue,
      stirBalanceSelectedValue: stirBalanceSelectedValue ?? this.stirBalanceSelectedValue,
      performaSuspensiSelectedValue: performaSuspensiSelectedValue ?? this.performaSuspensiSelectedValue,
      performaKoplingSelectedValue: performaKoplingSelectedValue ?? this.performaKoplingSelectedValue,
      rpmSelectedValue: rpmSelectedValue ?? this.rpmSelectedValue,
      testDriveCatatanList: testDriveCatatanList ?? this.testDriveCatatanList,
      // New fields for Page Five Seven (Tools Test)
      tebalCatBodyDepanSelectedValue: tebalCatBodyDepanSelectedValue ?? this.tebalCatBodyDepanSelectedValue,
      tebalCatBodyKiriSelectedValue: tebalCatBodyKiriSelectedValue ?? this.tebalCatBodyKiriSelectedValue,
      temperatureAcMobilSelectedValue: temperatureAcMobilSelectedValue ?? this.temperatureAcMobilSelectedValue,
      tebalCatBodyKananSelectedValue: tebalCatBodyKananSelectedValue ?? this.tebalCatBodyKananSelectedValue,
      tebalCatBodyBelakangSelectedValue: tebalCatBodyBelakangSelectedValue ?? this.tebalCatBodyBelakangSelectedValue,
      obdScannerSelectedValue: obdScannerSelectedValue ?? this.obdScannerSelectedValue,
      tebalCatBodyAtapSelectedValue: tebalCatBodyAtapSelectedValue ?? this.tebalCatBodyAtapSelectedValue,
      testAccuSelectedValue: testAccuSelectedValue ?? this.testAccuSelectedValue,
      toolsTestCatatanList: toolsTestCatatanList ?? this.toolsTestCatatanList,
    );
  }
}
