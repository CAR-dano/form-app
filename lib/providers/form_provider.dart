import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart';
import 'package:form_app/models/inspector_data.dart';
import 'package:form_app/providers/inspection_branches_provider.dart';
import 'package:form_app/providers/inspector_provider.dart'; // Import inspection branches provider
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:form_app/models/inspection_branch.dart'; // Import InspectionBranch model

class FormNotifier extends StateNotifier<FormData> {
  final Ref _ref;
  static const _fileName = 'form_data.json';

  FormNotifier(this._ref) : super(FormData()) {
    // Load initial data first
    _loadFormData().then((_) {
      // Then setup listeners and perform initial validation with loaded state
      _ref.listen<AsyncValue<List<InspectionBranch>>>(inspectionBranchesProvider, (previous, next) {
        next.whenData((availableBranches) {
          _validateAndUpdateCabangInspeksi(state.cabangInspeksi, availableBranches);
        });
      });
      final initialBranchesAsync = _ref.read(inspectionBranchesProvider);
      initialBranchesAsync.whenData((availableBranches) {
        _validateAndUpdateCabangInspeksi(state.cabangInspeksi, availableBranches);
      });

      _ref.listen<AsyncValue<List<Inspector>>>(inspectorProvider, (previous, next) {
        next.whenData((availableInspectors) {
          // Pass the currently loaded/set inspectorId from state
          _validateAndUpdateSelectedInspector(state.inspectorId, availableInspectors);
        });
      });
      final initialInspectorsAsync = _ref.read(inspectorProvider);
      initialInspectorsAsync.whenData((availableInspectors) {
        // Pass the currently loaded/set inspectorId from state
        _validateAndUpdateSelectedInspector(state.inspectorId, availableInspectors);
      });
    });
  }

  void _validateAndUpdateCabangInspeksi(InspectionBranch? currentCabang, List<InspectionBranch> availableBranches) {
    if (currentCabang != null) {
      // Check if the current branch's ID exists in the available branches
      if (availableBranches.isNotEmpty && !availableBranches.any((branch) => branch.id == currentCabang.id)) {
        if (state.cabangInspeksi != null) { // Check if a change is actually needed
          state = state.copyWith(cabangInspeksi: null);
        }
      }
    }
  }

  void _validateAndUpdateSelectedInspector(String? currentInspectorId, List<Inspector> availableInspectors) {
    Inspector? resolvedInspector;
    String? resolvedNamaInspektor;
    String? resolvedInspectorId;

    if (currentInspectorId != null && availableInspectors.isNotEmpty) {
      try {
        resolvedInspector = availableInspectors.firstWhere((inspector) => inspector.id == currentInspectorId);
        resolvedNamaInspektor = resolvedInspector.name;
        resolvedInspectorId = resolvedInspector.id;
      } catch (e) { // Not found
        resolvedInspector = null;
        resolvedNamaInspektor = null;
        resolvedInspectorId = null;
      }
    } else {
        resolvedInspector = null;
        resolvedNamaInspektor = null;
        resolvedInspectorId = null;
    }

    if (state.selectedInspector != resolvedInspector ||
        state.inspectorId != resolvedInspectorId ||
        state.namaInspektor != resolvedNamaInspektor) {
      state = state.copyWith(
        selectedInspector: resolvedInspector,
        inspectorId: resolvedInspectorId,
        namaInspektor: resolvedNamaInspektor,
      );
    }
  }


  void updateSelectedInspector(Inspector? newSelectedInspector) {
    if (newSelectedInspector != null) {
      state = state.copyWith(
        selectedInspector: newSelectedInspector,
        inspectorId: newSelectedInspector.id,
        namaInspektor: newSelectedInspector.name,
      );
    } else {
      state = state.copyWith(
        selectedInspector: null,
        inspectorId: null,
        namaInspektor: null,
      );
    }
  }


  void updateNamaCustomer(String name) {
    state = state.copyWith(namaCustomer: name);
  }

  void updateCabangInspeksi(InspectionBranch? cabang) {
    state = state.copyWith(cabangInspeksi: cabang);
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

  void updateCentralLockSelectedValue(int? value) {
    state = state.copyWith(centralLockSelectedValue: value);
  }

  void updateElectricMirrorSelectedValue(int? value) {
    state = state.copyWith(electricMirrorSelectedValue: value);
  }

  void updateRemAbsSelectedValue(int? value) {
    state = state.copyWith(remAbsSelectedValue: value);
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


  void updateRacksteerSelectedValue(int? value) {
    state = state.copyWith(racksteerSelectedValue: value);
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

  void updateCatDepanKap(String? value) {
    state = state.copyWith(catDepanKap: value);
  }

  void updateCatBelakangBumper(String? value) {
    state = state.copyWith(catBelakangBumper: value);
  }

  void updateCatBelakangTrunk(String? value) {
    state = state.copyWith(catBelakangTrunk: value);
  }

  void updateCatKananFenderDepan(String? value) {
    state = state.copyWith(catKananFenderDepan: value);
  }

  void updateCatKananPintuDepan(String? value) {
    state = state.copyWith(catKananPintuDepan: value);
  }

  void updateCatKananPintuBelakang(String? value) {
    state = state.copyWith(catKananPintuBelakang: value);
  }

  void updateCatKananFenderBelakang(String? value) {
    state = state.copyWith(catKananFenderBelakang: value);
  }

  void updateCatKiriFenderDepan(String? value) {
    state = state.copyWith(catKiriFenderDepan: value);
  }

  void updateCatKiriPintuDepan(String? value) {
    state = state.copyWith(catKiriPintuDepan: value);
  }

  void updateCatKiriPintuBelakang(String? value) {
    state = state.copyWith(catKiriPintuBelakang: value);
  }

  void updateCatKiriFenderBelakang(String? value) {
    state = state.copyWith(catKiriFenderBelakang: value);
  }

  void updateCatKiriSideSkirt(String? value) {
    state = state.copyWith(catKiriSideSkirt: value);
  }

  void updateCatKananSideSkirt(String? value) {
    state = state.copyWith(catKananSideSkirt: value);
  }

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_fileName';
  }

  Future<void> _loadFormData() async {
    try {
      final filePath = await _getFilePath();
      final file = File(filePath);
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final jsonMap = json.decode(jsonString);
        super.state = FormData.fromJson(jsonMap);
      }
    } catch (e) {
      // Handle errors during file loading
      if (kDebugMode) {
        print('Error loading form data: $e');
      }
    }
  }

  Future<void> _saveFormData() async {
    try {
      final filePath = await _getFilePath();
      final file = File(filePath);
      final jsonString = json.encode(state.toJson());
      await file.writeAsString(jsonString);
    } catch (e) {
      // Handle errors during file saving
      if (kDebugMode) {
        print('Error saving form data: $e');
      }
    }
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
