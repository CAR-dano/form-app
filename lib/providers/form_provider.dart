import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart';
import 'package:form_app/models/inspector_data.dart';
import 'package:form_app/models/user_data.dart'; // Import UserData model
import 'package:form_app/providers/inspection_branches_provider.dart';
import 'package:form_app/providers/inspector_provider.dart'; // Import inspection branches provider
import 'package:form_app/providers/user_info_provider.dart'; // Import user info provider
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:async'; // Import for Timer
import 'package:form_app/models/inspection_branch.dart'; // Import InspectionBranch model
import 'package:form_app/utils/crashlytics_util.dart'; // Import CrashlyticsUtil

class FormNotifier extends Notifier<FormData> {
  late final CrashlyticsUtil _crashlytics; // Add CrashlyticsUtil dependency
  static const _fileName = 'form_data.json';
  Timer? _saveTimer; // Debounce timer

  @override
  FormData build() {
    _crashlytics = ref.watch(crashlyticsUtilProvider); // Get CrashlyticsUtil instance
    
    // Load data asynchronously - this will update state after build returns
    _loadFormDataAsync();
    
    // Setup listeners for validation
    _setupProviderListeners();
    
    // Return empty form data initially - will be updated when loading completes
    return FormData();
  }

  void _loadFormDataAsync() async {
    try {
      final filePath = await _getFilePath();
      final file = File(filePath);
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final jsonMap = json.decode(jsonString);
        final loadedData = FormData.fromJson(jsonMap);

        // Update the state with loaded data
        state = loadedData;

        // Reload userInfo data to ensure cabangInspeksi is populated from user info if available
        await Future.delayed(const Duration(milliseconds: 10));
        final userInfoAsync = ref.read(userInfoProvider);
        userInfoAsync.whenData((userData) {
          if (userData != null && userData.inspectionBranchCity != null) {
            _updateState(state.copyWith(cabangInspeksi: userData.inspectionBranchCity));
          }
        });
      }
    } catch (e, stackTrace) {
      _crashlytics.recordError(e, stackTrace, reason: 'Error loading form data');
    }
  }

  void _setupProviderListeners() {
    // Auto-populate cabangInspeksi from user's inspection branch
    ref.listen<AsyncValue<UserData?>>(userInfoProvider, (previous, next) {
      next.whenData((userData) {
        if (userData != null && userData.inspectionBranchCity != null) {
          _updateState(state.copyWith(cabangInspeksi: userData.inspectionBranchCity));
        }
      });
    });

    final initialUserInfoAsync = ref.read(userInfoProvider);
    initialUserInfoAsync.whenData((userData) {
      if (userData != null && userData.inspectionBranchCity != null) {
        _updateState(state.copyWith(cabangInspeksi: userData.inspectionBranchCity));
      }
    });

    ref.listen<AsyncValue<List<InspectionBranch>>>(inspectionBranchesProvider, (previous, next) {
      next.whenData((availableBranches) {
        _validateAndUpdateCabangInspeksi(state.cabangInspeksi, availableBranches);
      });
    });

    final initialBranchesAsync = ref.read(inspectionBranchesProvider);
    initialBranchesAsync.whenData((availableBranches) {
      _validateAndUpdateCabangInspeksi(state.cabangInspeksi, availableBranches);
    });

    ref.listen<AsyncValue<List<Inspector>>>(inspectorProvider, (previous, next) {
      next.whenData((availableInspectors) {
        _validateAndUpdateSelectedInspector(state.inspectorId, availableInspectors);
      });
    });

    final initialInspectorsAsync = ref.read(inspectorProvider);
    initialInspectorsAsync.whenData((availableInspectors) {
      _validateAndUpdateSelectedInspector(state.inspectorId, availableInspectors);
    });
  }

  void _validateAndUpdateCabangInspeksi(InspectionBranch? currentCabang, List<InspectionBranch> availableBranches) {
    if (currentCabang != null) {
      // Check if the current branch's ID exists in the available branches
      if (availableBranches.isNotEmpty && !availableBranches.any((branch) => branch.id == currentCabang.id)) {
        if (state.cabangInspeksi != null) { // Check if a change is actually needed
          _updateState(state.copyWith(cabangInspeksi: null));
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
      } catch (e, stackTrace) { // Not found
        _crashlytics.recordError(e, stackTrace, reason: 'Error validating/updating selected inspector');
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
      _updateState(state.copyWith(
        selectedInspector: resolvedInspector,
        inspectorId: resolvedInspectorId,
        namaInspektor: resolvedNamaInspektor,
      ));
    }
  }


  void updateSelectedInspector(Inspector? newSelectedInspector) {
    if (newSelectedInspector != null) {
      _updateState(state.copyWith(
        selectedInspector: newSelectedInspector,
        inspectorId: newSelectedInspector.id,
        namaInspektor: newSelectedInspector.name,
      ));
    } else {
      _updateState(state.copyWith(
        selectedInspector: null,
        inspectorId: null,
        namaInspektor: null,
      ));
    }
  }


  void updateNamaCustomer(String name) {
    _updateState(state.copyWith(namaCustomer: name));
  }

  void updateCabangInspeksi(InspectionBranch? cabang) {
    _updateState(state.copyWith(cabangInspeksi: cabang));
  }

  void updateTanggalInspeksi(DateTime? date) {
    _updateState(state.copyWith(tanggalInspeksi: date));
  }

  void updateMerekKendaraan(String merek) {
    _updateState(state.copyWith(merekKendaraan: merek));
  }

  void updateTipeKendaraan(String tipe) {
    _updateState(state.copyWith(tipeKendaraan: tipe));
  }

  void updateTahun(String tahun) {
    _updateState(state.copyWith(tahun: tahun));
  }

  void updateTransmisi(String transmisi) {
    _updateState(state.copyWith(transmisi: transmisi));
  }

  void updateWarnaKendaraan(String warna) {
    _updateState(state.copyWith(warnaKendaraan: warna));
  }

  void updateOdometer(String odometer) {
    _updateState(state.copyWith(odometer: odometer));
  }

  void updateKepemilikan(String kepemilikan) {
    _updateState(state.copyWith(kepemilikan: kepemilikan));
  }

  void updatePlatNomor(String platNomor) {
    _updateState(state.copyWith(platNomor: platNomor));
  }

  void updatePajak1TahunDate(DateTime? date) {
    _updateState(state.copyWith(pajak1TahunDate: date));
  }

  void updatePajak5TahunDate(DateTime? date) {
    _updateState(state.copyWith(pajak5TahunDate: date));
  }

  void updateBiayaPajak(String biaya) {
    _updateState(state.copyWith(biayaPajak: biaya));
  }

  // Page Three Update Methods
  void updateBukuService(String? value) {
    _updateState(state.copyWith(bukuService: value));
  }

  void updateKunciSerep(String? value) {
    _updateState(state.copyWith(kunciSerep: value));
  }

  void updateBukuManual(String? value) {
    _updateState(state.copyWith(bukuManual: value));
  }

  void updateBanSerep(String? value) {
    _updateState(state.copyWith(banSerep: value));
  }

  void updateBpkb(String? value) {
    _updateState(state.copyWith(bpkb: value));
  }

  void updateDongkrak(String? value) {
    _updateState(state.copyWith(dongkrak: value));
  }

  void updateToolkit(String? value) {
    _updateState(state.copyWith(toolkit: value));
  }

  void updateNoRangka(String? value) {
    _updateState(state.copyWith(noRangka: value));
  }

  void updateNoMesin(String? value) {
    _updateState(state.copyWith(noMesin: value));
  }

  // New update methods for Page Four
  void updateIndikasiTabrakan(String? value) {
    _updateState(state.copyWith(indikasiTabrakan: value));
  }

  void updateIndikasiBanjir(String? value) {
    _updateState(state.copyWith(indikasiBanjir: value));
  }

  void updateIndikasiOdometerReset(String? value) {
    _updateState(state.copyWith(indikasiOdometerReset: value));
  }

  void updatePosisiBan(String? value) {
    _updateState(state.copyWith(posisiBan: value));
  }

  void updateMerk(String? value) {
    _updateState(state.copyWith(merk: value));
  }

  void updateTipeVelg(String? value) {
    _updateState(state.copyWith(tipeVelg: value));
  }

  void updateKetebalan(String? value) {
    _updateState(state.copyWith(ketebalan: value));
  }

  // New update methods for selected indices
  void updateInteriorSelectedValue(int value) {
    _updateState(state.copyWith(interiorSelectedValue: value));
  }

  void updateEksteriorSelectedValue(int value) {
    _updateState(state.copyWith(eksteriorSelectedValue: value));
  }

  void updateKakiKakiSelectedValue(int value) {
    _updateState(state.copyWith(kakiKakiSelectedValue: value));
  }

  void updateMesinSelectedValue(int value) {
    _updateState(state.copyWith(mesinSelectedValue: value));
  }

  // NEW: Update methods for ExpandableTextField data
  void updateKeteranganInterior(List<String> lines) {
    _updateState(state.copyWith(keteranganInterior: lines));
  }

  void updateKeteranganEksterior(List<String> lines) {
    _updateState(state.copyWith(keteranganEksterior: lines));
  }

  void updateKeteranganKakiKaki(List<String> lines) {
    _updateState(state.copyWith(keteranganKakiKaki: lines));
  }

  void updateKeteranganMesin(List<String> lines) {
    _updateState(state.copyWith(keteranganMesin: lines));
  }

  void updateDeskripsiKeseluruhan(List<String> lines) {
    _updateState(state.copyWith(deskripsiKeseluruhan: lines));
  }

  // New update methods for Page Five One
  void updateAirbagSelectedValue(int? value) {
    _updateState(state.copyWith(airbagSelectedValue: value));
  }

  void updateSistemAudioSelectedValue(int? value) {
    _updateState(state.copyWith(sistemAudioSelectedValue: value));
  }

  void updatePowerWindowSelectedValue(int? value) {
    _updateState(state.copyWith(powerWindowSelectedValue: value));
  }

  void updateSistemAcSelectedValue(int? value) {
    _updateState(state.copyWith(sistemAcSelectedValue: value));
  }

  void updateCentralLockSelectedValue(int? value) {
    _updateState(state.copyWith(centralLockSelectedValue: value));
  }

  void updateElectricMirrorSelectedValue(int? value) {
    _updateState(state.copyWith(electricMirrorSelectedValue: value));
  }

  void updateRemAbsSelectedValue(int? value) {
    _updateState(state.copyWith(remAbsSelectedValue: value));
  }

  void updateFiturCatatanList(List<String> lines) {
    _updateState(state.copyWith(fiturCatatanList: lines));
  }

  // New update methods for Page Five Two
  void updateGetaranMesinSelectedValue(int? value) {
    _updateState(state.copyWith(getaranMesinSelectedValue: value));
  }

  void updateSuaraMesinSelectedValue(int? value) {
    _updateState(state.copyWith(suaraMesinSelectedValue: value));
  }

  void updateTransmisiSelectedValue(int? value) {
    _updateState(state.copyWith(transmisiSelectedValue: value));
  }

  void updatePompaPowerSteeringSelectedValue(int? value) {
    _updateState(state.copyWith(pompaPowerSteeringSelectedValue: value));
  }

  void updateCoverTimingChainSelectedValue(int? value) {
    _updateState(state.copyWith(coverTimingChainSelectedValue: value));
  }

  void updateOliPowerSteeringSelectedValue(int? value) {
    _updateState(state.copyWith(oliPowerSteeringSelectedValue: value));
  }

  void updateAccuSelectedValue(int? value) {
    _updateState(state.copyWith(accuSelectedValue: value));
  }

  void updateKompressorAcSelectedValue(int? value) {
    _updateState(state.copyWith(kompressorAcSelectedValue: value));
  }

  void updateFanSelectedValue(int? value) {
    _updateState(state.copyWith(fanSelectedValue: value));
  }

  void updateSelangSelectedValue(int? value) {
    _updateState(state.copyWith(selangSelectedValue: value));
  }

  void updateKarterOliSelectedValue(int? value) {
    _updateState(state.copyWith(karterOliSelectedValue: value));
  }

  void updateOilRemSelectedValue(int? value) {
    _updateState(state.copyWith(oilRemSelectedValue: value));
  }

  void updateKabelSelectedValue(int? value) {
    _updateState(state.copyWith(kabelSelectedValue: value));
  }

  void updateKondensorSelectedValue(int? value) {
    _updateState(state.copyWith(kondensorSelectedValue: value));
  }

  void updateRadiatorSelectedValue(int? value) {
    _updateState(state.copyWith(radiatorSelectedValue: value));
  }

  void updateCylinderHeadSelectedValue(int? value) {
    _updateState(state.copyWith(cylinderHeadSelectedValue: value));
  }

  void updateOliMesinSelectedValue(int? value) {
    _updateState(state.copyWith(oliMesinSelectedValue: value));
  }

  void updateAirRadiatorSelectedValue(int? value) {
    _updateState(state.copyWith(airRadiatorSelectedValue: value));
  }

  void updateCoverKlepSelectedValue(int? value) {
    _updateState(state.copyWith(coverKlepSelectedValue: value));
  }

  void updateAlternatorSelectedValue(int? value) {
    _updateState(state.copyWith(alternatorSelectedValue: value));
  }

  void updateWaterPumpSelectedValue(int? value) {
    _updateState(state.copyWith(waterPumpSelectedValue: value));
  }

  void updateBeltSelectedValue(int? value) {
    _updateState(state.copyWith(beltSelectedValue: value));
  }

  void updateOliTransmisiSelectedValue(int? value) {
    _updateState(state.copyWith(oliTransmisiSelectedValue: value));
  }

  void updateCylinderBlockSelectedValue(int? value) {
    _updateState(state.copyWith(cylinderBlockSelectedValue: value));
  }

  void updateBushingBesarSelectedValue(int? value) {
    _updateState(state.copyWith(bushingBesarSelectedValue: value));
  }

  void updateBushingKecilSelectedValue(int? value) {
    _updateState(state.copyWith(bushingKecilSelectedValue: value));
  }

  void updateTutupRadiatorSelectedValue(int? value) {
    _updateState(state.copyWith(tutupRadiatorSelectedValue: value));
  }

  void updateMesinCatatanList(List<String> lines) {
    _updateState(state.copyWith(mesinCatatanList: lines));
  }

  // New update methods for Page Five Three
  void updateStirSelectedValue(int? value) {
    _updateState(state.copyWith(stirSelectedValue: value));
  }


  void updateRemTanganSelectedValue(int? value) {
    _updateState(state.copyWith(remTanganSelectedValue: value));
  }


  void updatePedalSelectedValue(int? value) {
    _updateState(state.copyWith(pedalSelectedValue: value));
  }


  void updateSwitchWiperSelectedValue(int? value) {
    _updateState(state.copyWith(switchWiperSelectedValue: value));
  }


  void updateLampuHazardSelectedValue(int? value) {
    _updateState(state.copyWith(lampuHazardSelectedValue: value));
  }


  void updatePanelDashboardSelectedValue(int? value) {
    _updateState(state.copyWith(panelDashboardSelectedValue: value));
  }


  void updatePembukaKapMesinSelectedValue(int? value) {
    _updateState(state.copyWith(pembukaKapMesinSelectedValue: value));
  }


  void updatePembukaBagasiSelectedValue(int? value) {
    _updateState(state.copyWith(pembukaBagasiSelectedValue: value));
  }


  void updateJokDepanSelectedValue(int? value) {
    _updateState(state.copyWith(jokDepanSelectedValue: value));
  }


  void updateAromaInteriorSelectedValue(int? value) {
    _updateState(state.copyWith(aromaInteriorSelectedValue: value));
  }


  void updateHandlePintuSelectedValue(int? value) {
    _updateState(state.copyWith(handlePintuSelectedValue: value));
  }


  void updateConsoleBoxSelectedValue(int? value) {
    _updateState(state.copyWith(consoleBoxSelectedValue: value));
  }


  void updateSpionTengahSelectedValue(int? value) {
    _updateState(state.copyWith(spionTengahSelectedValue: value));
  }


  void updateTuasPersnelingSelectedValue(int? value) {
    _updateState(state.copyWith(tuasPersnelingSelectedValue: value));
  }


  void updateJokBelakangSelectedValue(int? value) {
    _updateState(state.copyWith(jokBelakangSelectedValue: value));
  }


  void updatePanelIndikatorSelectedValue(int? value) {
    _updateState(state.copyWith(panelIndikatorSelectedValue: value));
  }


  void updateSwitchLampuSelectedValue(int? value) {
    _updateState(state.copyWith(switchLampuSelectedValue: value));
  }


  void updateKarpetDasarSelectedValue(int? value) {
    _updateState(state.copyWith(karpetDasarSelectedValue: value));
  }


  void updateKlaksonSelectedValue(int? value) {
    _updateState(state.copyWith(klaksonSelectedValue: value));
  }


  void updateSunVisorSelectedValue(int? value) {
    _updateState(state.copyWith(sunVisorSelectedValue: value));
  }


  void updateTuasTangkiBensinSelectedValue(int? value) {
    _updateState(state.copyWith(tuasTangkiBensinSelectedValue: value));
  }


  void updateSabukPengamanSelectedValue(int? value) {
    _updateState(state.copyWith(sabukPengamanSelectedValue: value));
  }


  void updateTrimInteriorSelectedValue(int? value) {
    _updateState(state.copyWith(trimInteriorSelectedValue: value));
  }


  void updatePlafonSelectedValue(int? value) {
    _updateState(state.copyWith(plafonSelectedValue: value));
  }


  void updateInteriorCatatanList(List<String> lines) {
    _updateState(state.copyWith(interiorCatatanList: lines));
  }

  // New update methods for Page Five Four
  void updateBumperDepanSelectedValue(int? value) {
    _updateState(state.copyWith(bumperDepanSelectedValue: value));
  }


  void updateKapMesinSelectedValue(int? value) {
    _updateState(state.copyWith(kapMesinSelectedValue: value));
  }


  void updateLampuUtamaSelectedValue(int? value) {
    _updateState(state.copyWith(lampuUtamaSelectedValue: value));
  }


  void updatePanelAtapSelectedValue(int? value) {
    _updateState(state.copyWith(panelAtapSelectedValue: value));
  }


  void updateGrillSelectedValue(int? value) {
    _updateState(state.copyWith(grillSelectedValue: value));
  }


  void updateLampuFoglampSelectedValue(int? value) {
    _updateState(state.copyWith(lampuFoglampSelectedValue: value));
  }


  void updateKacaBeningSelectedValue(int? value) {
    _updateState(state.copyWith(kacaBeningSelectedValue: value));
  }


  void updateWiperBelakangSelectedValue(int? value) {
    _updateState(state.copyWith(wiperBelakangSelectedValue: value));
  }


  void updateBumperBelakangSelectedValue(int? value) {
    _updateState(state.copyWith(bumperBelakangSelectedValue: value));
  }


  void updateLampuBelakangSelectedValue(int? value) {
    _updateState(state.copyWith(lampuBelakangSelectedValue: value));
  }


  void updateTrunklidSelectedValue(int? value) {
    _updateState(state.copyWith(trunklidSelectedValue: value));
  }


  void updateKacaDepanSelectedValue(int? value) {
    _updateState(state.copyWith(kacaDepanSelectedValue: value));
  }


  void updateFenderKananSelectedValue(int? value) {
    _updateState(state.copyWith(fenderKananSelectedValue: value));
  }


  void updateQuarterPanelKananSelectedValue(int? value) {
    _updateState(state.copyWith(quarterPanelKananSelectedValue: value));
  }


  void updatePintuBelakangKananSelectedValue(int? value) {
    _updateState(state.copyWith(pintuBelakangKananSelectedValue: value));
  }


  void updateSpionKananSelectedValue(int? value) {
    _updateState(state.copyWith(spionKananSelectedValue: value));
  }


  void updateLisplangKananSelectedValue(int? value) {
    _updateState(state.copyWith(lisplangKananSelectedValue: value));
  }


  void updateSideSkirtKananSelectedValue(int? value) {
    _updateState(state.copyWith(sideSkirtKananSelectedValue: value));
  }


  void updateDaunWiperSelectedValue(int? value) {
    _updateState(state.copyWith(daunWiperSelectedValue: value));
  }


  void updatePintuBelakangSelectedValue(int? value) {
    _updateState(state.copyWith(pintuBelakangSelectedValue: value));
  }


  void updateFenderKiriSelectedValue(int? value) {
    _updateState(state.copyWith(fenderKiriSelectedValue: value));
  }


  void updateQuarterPanelKiriSelectedValue(int? value) {
    _updateState(state.copyWith(quarterPanelKiriSelectedValue: value));
  }


  void updatePintuDepanSelectedValue(int? value) {
    _updateState(state.copyWith(pintuDepanSelectedValue: value));
  }


  void updateKacaJendelaKananSelectedValue(int? value) {
    _updateState(state.copyWith(kacaJendelaKananSelectedValue: value));
  }


  void updatePintuBelakangKiriSelectedValue(int? value) {
    _updateState(state.copyWith(pintuBelakangKiriSelectedValue: value));
  }


  void updateSpionKiriSelectedValue(int? value) {
    _updateState(state.copyWith(spionKiriSelectedValue: value));
  }


  void updatePintuDepanKiriSelectedValue(int? value) {
    _updateState(state.copyWith(pintuDepanKiriSelectedValue: value));
  }


  void updateKacaJendelaKiriSelectedValue(int? value) {
    _updateState(state.copyWith(kacaJendelaKiriSelectedValue: value));
  }


  void updateLisplangKiriSelectedValue(int? value) {
    _updateState(state.copyWith(lisplangKiriSelectedValue: value));
  }


  void updateSideSkirtKiriSelectedValue(int? value) {
    _updateState(state.copyWith(sideSkirtKiriSelectedValue: value));
  }


  void updateEksteriorCatatanList(List<String> lines) {
    _updateState(state.copyWith(eksteriorCatatanList: lines));
  }

  void updateRepairEstimations(List<Map<String, String>> estimations) {
    _updateState(state.copyWith(repairEstimations: estimations));
  }

  // New update methods for Page Five Five
  void updateBanDepanSelectedValue(int? value) {
    _updateState(state.copyWith(banDepanSelectedValue: value));
  }


  void updateVelgDepanSelectedValue(int? value) {
    _updateState(state.copyWith(velgDepanSelectedValue: value));
  }


  void updateDiscBrakeSelectedValue(int? value) {
    _updateState(state.copyWith(discBrakeSelectedValue: value));
  }


  void updateMasterRemSelectedValue(int? value) {
    _updateState(state.copyWith(masterRemSelectedValue: value));
  }


  void updateTieRodSelectedValue(int? value) {
    _updateState(state.copyWith(tieRodSelectedValue: value));
  }


  void updateGardanSelectedValue(int? value) {
    _updateState(state.copyWith(gardanSelectedValue: value));
  }


  void updateBanBelakangSelectedValue(int? value) {
    _updateState(state.copyWith(banBelakangSelectedValue: value));
  }


  void updateVelgBelakangSelectedValue(int? value) {
    _updateState(state.copyWith(velgBelakangSelectedValue: value));
  }


  void updateBrakePadSelectedValue(int? value) {
    _updateState(state.copyWith(brakePadSelectedValue: value));
  }


  void updateCrossmemberSelectedValue(int? value) {
    _updateState(state.copyWith(crossmemberSelectedValue: value));
  }


  void updateKnalpotSelectedValue(int? value) {
    _updateState(state.copyWith(knalpotSelectedValue: value));
  }


  void updateBalljointSelectedValue(int? value) {
    _updateState(state.copyWith(balljointSelectedValue: value));
  }


  void updateRacksteerSelectedValue(int? value) {
    _updateState(state.copyWith(racksteerSelectedValue: value));
  }


  void updateKaretBootSelectedValue(int? value) {
    _updateState(state.copyWith(karetBootSelectedValue: value));
  }


  void updateUpperLowerArmSelectedValue(int? value) {
    _updateState(state.copyWith(upperLowerArmSelectedValue: value));
  }


  void updateShockBreakerSelectedValue(int? value) {
    _updateState(state.copyWith(shockBreakerSelectedValue: value));
  }


  void updateLinkStabilizerSelectedValue(int? value) {
    _updateState(state.copyWith(linkStabilizerSelectedValue: value));
  }


  void updateBanDanKakiKakiCatatanList(List<String> lines) {
    _updateState(state.copyWith(banDanKakiKakiCatatanList: lines));
  }

  // New update methods for Page Five Six (Test Drive)
  void updateBunyiGetaranSelectedValue(int? value) {
    _updateState(state.copyWith(bunyiGetaranSelectedValue: value));
  }


  void updatePerformaStirSelectedValue(int? value) {
    _updateState(state.copyWith(performaStirSelectedValue: value));
  }


  void updatePerpindahanTransmisiSelectedValue(int? value) {
    _updateState(state.copyWith(perpindahanTransmisiSelectedValue: value));
  }


  void updateStirBalanceSelectedValue(int? value) {
    _updateState(state.copyWith(stirBalanceSelectedValue: value));
  }


  void updatePerformaSuspensiSelectedValue(int? value) {
    _updateState(state.copyWith(performaSuspensiSelectedValue: value));
  }


  void updatePerformaKoplingSelectedValue(int? value) {
    _updateState(state.copyWith(performaKoplingSelectedValue: value));
  }


  void updateRpmSelectedValue(int? value) {
    _updateState(state.copyWith(rpmSelectedValue: value));
  }


  void updateTestDriveCatatanList(List<String> lines) {
    _updateState(state.copyWith(testDriveCatatanList: lines));
  }

  // New update methods for Page Five Seven (Tools Test)
  void updateTebalCatBodyDepanSelectedValue(int? value) {
    _updateState(state.copyWith(tebalCatBodyDepanSelectedValue: value));
  }


  void updateTebalCatBodyKiriSelectedValue(int? value) {
    _updateState(state.copyWith(tebalCatBodyKiriSelectedValue: value));
  }


  void updateTemperatureAcMobilSelectedValue(int? value) {
    _updateState(state.copyWith(temperatureAcMobilSelectedValue: value));
  }


  void updateTebalCatBodyKananSelectedValue(int? value) {
    _updateState(state.copyWith(tebalCatBodyKananSelectedValue: value));
  }


  void updateTebalCatBodyBelakangSelectedValue(int? value) {
    _updateState(state.copyWith(tebalCatBodyBelakangSelectedValue: value));
  }


  void updateObdScannerSelectedValue(int? value) {
    _updateState(state.copyWith(obdScannerSelectedValue: value));
  }


  void updateTebalCatBodyAtapSelectedValue(int? value) {
    _updateState(state.copyWith(tebalCatBodyAtapSelectedValue: value));
  }


  void updateTestAccuSelectedValue(int? value) {
    _updateState(state.copyWith(testAccuSelectedValue: value));
  }


  void updateToolsTestCatatanList(List<String> lines) {
    _updateState(state.copyWith(toolsTestCatatanList: lines));
  }

  void updateCatDepanKap(String? value) {
    _updateState(state.copyWith(catDepanKap: value));
  }

  void updateCatBelakangBumper(String? value) {
    _updateState(state.copyWith(catBelakangBumper: value));
  }

  void updateCatBelakangTrunk(String? value) {
    _updateState(state.copyWith(catBelakangTrunk: value));
  }

  void updateCatKananFenderDepan(String? value) {
    _updateState(state.copyWith(catKananFenderDepan: value));
  }

  void updateCatKananPintuDepan(String? value) {
    _updateState(state.copyWith(catKananPintuDepan: value));
  }

  void updateCatKananPintuBelakang(String? value) {
    _updateState(state.copyWith(catKananPintuBelakang: value));
  }

  void updateCatKananFenderBelakang(String? value) {
    _updateState(state.copyWith(catKananFenderBelakang: value));
  }

  void updateCatKiriFenderDepan(String? value) {
    _updateState(state.copyWith(catKiriFenderDepan: value));
  }

  void updateCatKiriPintuDepan(String? value) {
    _updateState(state.copyWith(catKiriPintuDepan: value));
  }

  void updateCatKiriPintuBelakang(String? value) {
    _updateState(state.copyWith(catKiriPintuBelakang: value));
  }

  void updateCatKiriFenderBelakang(String? value) {
    _updateState(state.copyWith(catKiriFenderBelakang: value));
  }

  void updateCatKiriSideSkirt(String? value) {
    _updateState(state.copyWith(catKiriSideSkirt: value));
  }

  void updateCatKananSideSkirt(String? value) {
    _updateState(state.copyWith(catKananSideSkirt: value));
  }

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_fileName';
  }

  Future<void> _saveFormData() async {
    try {
      final filePath = await _getFilePath();
      final file = File(filePath);
      final jsonString = json.encode(state.toJson());
      await file.writeAsString(jsonString, flush: true); // Ensure data is flushed to disk
    } catch (e, stackTrace) {
      _crashlytics.recordError(e, stackTrace, reason: 'Error saving form data');
      // Handle errors during file saving
      if (kDebugMode) {
        print('Error saving form data: $e');
      }
    }
  }

  void _updateState(FormData newState) {
    state = newState;
    // Debounce the save operation
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(milliseconds: 500), () {
      _saveFormData();
    });
  }

  void resetFormData() {
    _updateState(FormData());
    _saveTimer?.cancel(); // Cancel any pending saves
    _saveFormData(); // Save immediately after reset
  }
}

final formProvider = NotifierProvider<FormNotifier, FormData>(() {
  return FormNotifier();
});
