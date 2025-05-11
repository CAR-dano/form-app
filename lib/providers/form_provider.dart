import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart';

class FormNotifier extends StateNotifier<FormData> {
  FormNotifier() : super(FormData());

  void updateNamaInspektor(String name) {
    state = state.copyWith(namaInspektor: name);
  }

  void updateNamaCustomer(String name) {
    state = state.copyWith(namaCustomer: name);
  }

  void updateCabangInspeksi(String? cabang) {
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
    state = state.copyWith(getaranMesinSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateGetaranMesinIsEnabled

  void updateSuaraMesinSelectedValue(int? value) {
    state = state.copyWith(suaraMesinSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateSuaraMesinIsEnabled

  void updateTransmisiSelectedValue(int? value) {
    state = state.copyWith(transmisiSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateTransmisiIsEnabled

  void updatePompaPowerSteeringSelectedValue(int? value) {
    state = state.copyWith(pompaPowerSteeringSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updatePompaPowerSteeringIsEnabled

  void updateCoverTimingChainSelectedValue(int? value) {
    state = state.copyWith(coverTimingChainSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateCoverTimingChainIsEnabled

  void updateOliPowerSteeringSelectedValue(int? value) {
    state = state.copyWith(oliPowerSteeringSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateOliPowerSteeringIsEnabled

  void updateAccuSelectedValue(int? value) {
    state = state.copyWith(accuSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateAccuIsEnabled

  void updateKompressorAcSelectedValue(int? value) {
    state = state.copyWith(kompressorAcSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateKompressorAcIsEnabled

  void updateFanSelectedValue(int? value) {
    state = state.copyWith(fanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateFanIsEnabled

  void updateSelangSelectedValue(int? value) {
    state = state.copyWith(selangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateSelangIsEnabled

  void updateKarterOliSelectedValue(int? value) {
    state = state.copyWith(karterOliSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateKarterOliIsEnabled

  void updateOilRemSelectedValue(int? value) {
    state = state.copyWith(oilRemSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateOilRemIsEnabled

  void updateKabelSelectedValue(int? value) {
    state = state.copyWith(kabelSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateKabelIsEnabled

  void updateKondensorSelectedValue(int? value) {
    state = state.copyWith(kondensorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateKondensorIsEnabled

  void updateRadiatorSelectedValue(int? value) {
    state = state.copyWith(radiatorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateRadiatorIsEnabled

  void updateCylinderHeadSelectedValue(int? value) {
    state = state.copyWith(cylinderHeadSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateCylinderHeadIsEnabled

  void updateOliMesinSelectedValue(int? value) {
    state = state.copyWith(oliMesinSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateOliMesinIsEnabled

  void updateAirRadiatorSelectedValue(int? value) {
    state = state.copyWith(airRadiatorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateAirRadiatorIsEnabled

  void updateCoverKlepSelectedValue(int? value) {
    state = state.copyWith(coverKlepSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateCoverKlepIsEnabled

  void updateAlternatorSelectedValue(int? value) {
    state = state.copyWith(alternatorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateAlternatorIsEnabled

  void updateWaterPumpSelectedValue(int? value) {
    state = state.copyWith(waterPumpSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateWaterPumpIsEnabled

  void updateBeltSelectedValue(int? value) {
    state = state.copyWith(beltSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateBeltIsEnabled

  void updateOliTransmisiSelectedValue(int? value) {
    state = state.copyWith(oliTransmisiSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateOliTransmisiIsEnabled

  void updateCylinderBlockSelectedValue(int? value) {
    state = state.copyWith(cylinderBlockSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateCylinderBlockIsEnabled

  void updateBushingBesarSelectedValue(int? value) {
    state = state.copyWith(bushingBesarSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateBushingBesarIsEnabled

  void updateBushingKecilSelectedValue(int? value) {
    state = state.copyWith(bushingKecilSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateBushingKecilIsEnabled

  void updateTutupRadiatorSelectedValue(int? value) {
    state = state.copyWith(tutupRadiatorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateTutupRadiatorIsEnabled

  void updateMesinCatatanList(List<String> lines) {
    state = state.copyWith(mesinCatatanList: lines);
  }

  // New update methods for Page Five Three
  void updateStirSelectedValue(int? value) {
    state = state.copyWith(stirSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateStirIsEnabled

  void updateRemTanganSelectedValue(int? value) {
    state = state.copyWith(remTanganSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateRemTanganIsEnabled

  void updatePedalSelectedValue(int? value) {
    state = state.copyWith(pedalSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updatePedalIsEnabled

  void updateSwitchWiperSelectedValue(int? value) {
    state = state.copyWith(switchWiperSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateSwitchWiperIsEnabled

  void updateLampuHazardSelectedValue(int? value) {
    state = state.copyWith(lampuHazardSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateLampuHazardIsEnabled

  void updatePanelDashboardSelectedValue(int? value) {
    state = state.copyWith(panelDashboardSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updatePanelDashboardIsEnabled

  void updatePembukaKapMesinSelectedValue(int? value) {
    state = state.copyWith(pembukaKapMesinSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updatePembukaKapMesinIsEnabled

  void updatePembukaBagasiSelectedValue(int? value) {
    state = state.copyWith(pembukaBagasiSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updatePembukaBagasiIsEnabled

  void updateJokDepanSelectedValue(int? value) {
    state = state.copyWith(jokDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateJokDepanIsEnabled

  void updateAromaInteriorSelectedValue(int? value) {
    state = state.copyWith(aromaInteriorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateAromaInteriorIsEnabled

  void updateHandlePintuSelectedValue(int? value) {
    state = state.copyWith(handlePintuSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateHandlePintuIsEnabled

  void updateConsoleBoxSelectedValue(int? value) {
    state = state.copyWith(consoleBoxSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateConsoleBoxIsEnabled

  void updateSpionTengahSelectedValue(int? value) {
    state = state.copyWith(spionTengahSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateSpionTengahIsEnabled

  void updateTuasPersnelingSelectedValue(int? value) {
    state = state.copyWith(tuasPersnelingSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateTuasPersnelingIsEnabled

  void updateJokBelakangSelectedValue(int? value) {
    state = state.copyWith(jokBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateJokBelakangIsEnabled

  void updatePanelIndikatorSelectedValue(int? value) {
    state = state.copyWith(panelIndikatorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updatePanelIndikatorIsEnabled

  void updateSwitchLampuSelectedValue(int? value) {
    state = state.copyWith(switchLampuSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateSwitchLampuIsEnabled

  void updateKarpetDasarSelectedValue(int? value) {
    state = state.copyWith(karpetDasarSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateKarpetDasarIsEnabled

  void updateKlaksonSelectedValue(int? value) {
    state = state.copyWith(klaksonSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateKlaksonIsEnabled

  void updateSunVisorSelectedValue(int? value) {
    state = state.copyWith(sunVisorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateSunVisorIsEnabled

  void updateTuasTangkiBensinSelectedValue(int? value) {
    state = state.copyWith(tuasTangkiBensinSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateTuasTangkiBensinIsEnabled

  void updateSabukPengamanSelectedValue(int? value) {
    state = state.copyWith(sabukPengamanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateSabukPengamanIsEnabled

  void updateTrimInteriorSelectedValue(int? value) {
    state = state.copyWith(trimInteriorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateTrimInteriorIsEnabled

  void updatePlafonSelectedValue(int? value) {
    state = state.copyWith(plafonSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updatePlafonIsEnabled

  void updateInteriorCatatanList(List<String> lines) {
    state = state.copyWith(interiorCatatanList: lines);
  }

  // New update methods for Page Five Four
  void updateBumperDepanSelectedValue(int? value) {
    state = state.copyWith(bumperDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateBumperDepanIsEnabled

  void updateKapMesinSelectedValue(int? value) {
    state = state.copyWith(kapMesinSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateKapMesinIsEnabled

  void updateLampuUtamaSelectedValue(int? value) {
    state = state.copyWith(lampuUtamaSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateLampuUtamaIsEnabled

  void updatePanelAtapSelectedValue(int? value) {
    state = state.copyWith(panelAtapSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updatePanelAtapIsEnabled

  void updateGrillSelectedValue(int? value) {
    state = state.copyWith(grillSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateGrillIsEnabled

  void updateLampuFoglampSelectedValue(int? value) {
    state = state.copyWith(lampuFoglampSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateLampuFoglampIsEnabled

  void updateKacaBeningSelectedValue(int? value) {
    state = state.copyWith(kacaBeningSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateKacaBeningIsEnabled

  void updateWiperBelakangSelectedValue(int? value) {
    state = state.copyWith(wiperBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateWiperBelakangIsEnabled

  void updateBumperBelakangSelectedValue(int? value) {
    state = state.copyWith(bumperBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateBumperBelakangIsEnabled

  void updateLampuBelakangSelectedValue(int? value) {
    state = state.copyWith(lampuBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateLampuBelakangIsEnabled

  void updateTrunklidSelectedValue(int? value) {
    state = state.copyWith(trunklidSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateTrunklidIsEnabled

  void updateKacaDepanSelectedValue(int? value) {
    state = state.copyWith(kacaDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateKacaDepanIsEnabled

  void updateFenderKananSelectedValue(int? value) {
    state = state.copyWith(fenderKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateFenderKananIsEnabled

  void updateQuarterPanelKananSelectedValue(int? value) {
    state = state.copyWith(quarterPanelKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateQuarterPanelKananIsEnabled

  void updatePintuBelakangKananSelectedValue(int? value) {
    state = state.copyWith(pintuBelakangKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updatePintuBelakangKananIsEnabled

  void updateSpionKananSelectedValue(int? value) {
    state = state.copyWith(spionKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateSpionKananIsEnabled

  void updateLisplangKananSelectedValue(int? value) {
    state = state.copyWith(lisplangKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateLisplangKananIsEnabled

  void updateSideSkirtKananSelectedValue(int? value) {
    state = state.copyWith(sideSkirtKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateSideSkirtKananIsEnabled

  void updateDaunWiperSelectedValue(int? value) {
    state = state.copyWith(daunWiperSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateDaunWiperIsEnabled

  void updatePintuBelakangSelectedValue(int? value) {
    state = state.copyWith(pintuBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updatePintuBelakangIsEnabled

  void updateFenderKiriSelectedValue(int? value) {
    state = state.copyWith(fenderKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateFenderKiriIsEnabled

  void updateQuarterPanelKiriSelectedValue(int? value) {
    state = state.copyWith(quarterPanelKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateQuarterPanelKiriIsEnabled

  void updatePintuDepanSelectedValue(int? value) {
    state = state.copyWith(pintuDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updatePintuDepanIsEnabled

  void updateKacaJendelaKananSelectedValue(int? value) {
    state = state.copyWith(kacaJendelaKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateKacaJendelaKananIsEnabled

  void updatePintuBelakangKiriSelectedValue(int? value) {
    state = state.copyWith(pintuBelakangKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updatePintuBelakangKiriIsEnabled

  void updateSpionKiriSelectedValue(int? value) {
    state = state.copyWith(spionKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateSpionKiriIsEnabled

  void updatePintuDepanKiriSelectedValue(int? value) {
    state = state.copyWith(pintuDepanKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updatePintuDepanKiriIsEnabled

  void updateKacaJendelaKiriSelectedValue(int? value) {
    state = state.copyWith(kacaJendelaKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateKacaJendelaKiriIsEnabled

  void updateLisplangKiriSelectedValue(int? value) {
    state = state.copyWith(lisplangKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateLisplangKiriIsEnabled

  void updateSideSkirtKiriSelectedValue(int? value) {
    state = state.copyWith(sideSkirtKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateSideSkirtKiriIsEnabled

  void updateEksteriorCatatanList(List<String> lines) {
    state = state.copyWith(eksteriorCatatanList: lines);
  }

  void updateRepairEstimations(List<Map<String, String>> estimations) {
    state = state.copyWith(repairEstimations: estimations);
  }

  // New update methods for Page Five Five
  void updateBanDepanSelectedValue(int? value) {
    state = state.copyWith(banDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateBanDepanIsEnabled

  void updateVelgDepanSelectedValue(int? value) {
    state = state.copyWith(velgDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateVelgDepanIsEnabled

  void updateDiscBrakeSelectedValue(int? value) {
    state = state.copyWith(discBrakeSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateDiscBrakeIsEnabled

  void updateMasterRemSelectedValue(int? value) {
    state = state.copyWith(masterRemSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateMasterRemIsEnabled

  void updateTieRodSelectedValue(int? value) {
    state = state.copyWith(tieRodSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateTieRodIsEnabled

  void updateGardanSelectedValue(int? value) {
    state = state.copyWith(gardanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateGardanIsEnabled

  void updateBanBelakangSelectedValue(int? value) {
    state = state.copyWith(banBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateBanBelakangIsEnabled

  void updateVelgBelakangSelectedValue(int? value) {
    state = state.copyWith(velgBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateVelgBelakangIsEnabled

  void updateBrakePadSelectedValue(int? value) {
    state = state.copyWith(brakePadSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateBrakePadIsEnabled

  void updateCrossmemberSelectedValue(int? value) {
    state = state.copyWith(crossmemberSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateCrossmemberIsEnabled

  void updateKnalpotSelectedValue(int? value) {
    state = state.copyWith(knalpotSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateKnalpotIsEnabled

  void updateBalljointSelectedValue(int? value) {
    state = state.copyWith(balljointSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateBalljointIsEnabled

  void updateRocksteerSelectedValue(int? value) {
    state = state.copyWith(rocksteerSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateRocksteerIsEnabled

  void updateKaretBootSelectedValue(int? value) {
    state = state.copyWith(karetBootSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateKaretBootIsEnabled

  void updateUpperLowerArmSelectedValue(int? value) {
    state = state.copyWith(upperLowerArmSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateUpperLowerArmIsEnabled

  void updateShockBreakerSelectedValue(int? value) {
    state = state.copyWith(shockBreakerSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateShockBreakerIsEnabled

  void updateLinkStabilizerSelectedValue(int? value) {
    state = state.copyWith(linkStabilizerSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateLinkStabilizerIsEnabled

  void updateBanDanKakiKakiCatatanList(List<String> lines) {
    state = state.copyWith(banDanKakiKakiCatatanList: lines);
  }

  // New update methods for Page Five Six (Test Drive)
  void updateBunyiGetaranSelectedValue(int? value) {
    state = state.copyWith(bunyiGetaranSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateBunyiGetaranIsEnabled

  void updatePerformaStirSelectedValue(int? value) {
    state = state.copyWith(performaStirSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updatePerformaStirIsEnabled

  void updatePerpindahanTransmisiSelectedValue(int? value) {
    state = state.copyWith(perpindahanTransmisiSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updatePerpindahanTransmisiIsEnabled

  void updateStirBalanceSelectedValue(int? value) {
    state = state.copyWith(stirBalanceSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateStirBalanceIsEnabled

  void updatePerformaSuspensiSelectedValue(int? value) {
    state = state.copyWith(performaSuspensiSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updatePerformaSuspensiIsEnabled

  void updatePerformaKoplingSelectedValue(int? value) {
    state = state.copyWith(performaKoplingSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updatePerformaKoplingIsEnabled

  void updateRpmSelectedValue(int? value) {
    state = state.copyWith(rpmSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateRpmIsEnabled

  void updateTestDriveCatatanList(List<String> lines) {
    state = state.copyWith(testDriveCatatanList: lines);
  }

  // New update methods for Page Five Seven (Tools Test)
  void updateTebalCatBodyDepanSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateTebalCatBodyDepanIsEnabled

  void updateTebalCatBodyKiriSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateTebalCatBodyKiriIsEnabled

  void updateTemperatureAcMobilSelectedValue(int? value) {
    state = state.copyWith(temperatureAcMobilSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateTemperatureAcMobilIsEnabled

  void updateTebalCatBodyKananSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateTebalCatBodyKananIsEnabled

  void updateTebalCatBodyBelakangSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateTebalCatBodyBelakangIsEnabled

  void updateObdScannerSelectedValue(int? value) {
    state = state.copyWith(obdScannerSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateObdScannerIsEnabled

  void updateTebalCatBodyAtapSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyAtapSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateTebalCatBodyAtapIsEnabled

  void updateTestAccuSelectedValue(int? value) {
    state = state.copyWith(testAccuSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  // Removed updateTestAccuIsEnabled

  void updateToolsTestCatatanList(List<String> lines) {
    state = state.copyWith(toolsTestCatatanList: lines);
  }

  void resetFormData() {
    state = FormData();
  }
}

final formProvider = StateNotifierProvider<FormNotifier, FormData>((ref) {
  return FormNotifier();
});

extension on FormData {
  FormData copyWith({
    String? namaInspektor,
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
    // bool? getaranMesinIsEnabled, // Removed
    int? suaraMesinSelectedValue,
    // bool? suaraMesinIsEnabled, // Removed
    int? transmisiSelectedValue,
    // bool? transmisiIsEnabled, // Removed
    int? pompaPowerSteeringSelectedValue,
    // bool? pompaPowerSteeringIsEnabled, // Removed
    int? coverTimingChainSelectedValue,
    // bool? coverTimingChainIsEnabled, // Removed
    int? oliPowerSteeringSelectedValue,
    // bool? oliPowerSteeringIsEnabled, // Removed
    int? accuSelectedValue,
    // bool? accuIsEnabled, // Removed
    int? kompressorAcSelectedValue,
    // bool? kompressorAcIsEnabled, // Removed
    int? fanSelectedValue,
    // bool? fanIsEnabled, // Removed
    int? selangSelectedValue,
    // bool? selangIsEnabled, // Removed
    int? karterOliSelectedValue,
    // bool? karterOliIsEnabled, // Removed
    int? oilRemSelectedValue,
    // bool? oilRemIsEnabled, // Removed
    int? kabelSelectedValue,
    // bool? kabelIsEnabled, // Removed
    int? kondensorSelectedValue,
    // bool? kondensorIsEnabled, // Removed
    int? radiatorSelectedValue,
    // bool? radiatorIsEnabled, // Removed
    int? cylinderHeadSelectedValue,
    // bool? cylinderHeadIsEnabled, // Removed
    int? oliMesinSelectedValue,
    // bool? oliMesinIsEnabled, // Removed
    int? airRadiatorSelectedValue,
    // bool? airRadiatorIsEnabled, // Removed
    int? coverKlepSelectedValue,
    // bool? coverKlepIsEnabled, // Removed
    int? alternatorSelectedValue,
    // bool? alternatorIsEnabled, // Removed
    int? waterPumpSelectedValue,
    // bool? waterPumpIsEnabled, // Removed
    int? beltSelectedValue,
    // bool? beltIsEnabled, // Removed
    int? oliTransmisiSelectedValue,
    // bool? oliTransmisiIsEnabled, // Removed
    int? cylinderBlockSelectedValue,
    // bool? cylinderBlockIsEnabled, // Removed
    int? bushingBesarSelectedValue,
    // bool? bushingBesarIsEnabled, // Removed
    int? bushingKecilSelectedValue,
    // bool? bushingKecilIsEnabled, // Removed
    int? tutupRadiatorSelectedValue,
    // bool? tutupRadiatorIsEnabled, // Removed
    List<String>? mesinCatatanList,
    int? stirSelectedValue,
    // bool? stirIsEnabled, // Removed
    int? remTanganSelectedValue,
    // bool? remTanganIsEnabled, // Removed
    int? pedalSelectedValue,
    // bool? pedalIsEnabled, // Removed
    int? switchWiperSelectedValue,
    // bool? switchWiperIsEnabled, // Removed
    int? lampuHazardSelectedValue,
    // bool? lampuHazardIsEnabled, // Removed
    int? panelDashboardSelectedValue,
    // bool? panelDashboardIsEnabled, // Removed
    int? pembukaKapMesinSelectedValue,
    // bool? pembukaKapMesinIsEnabled, // Removed
    int? pembukaBagasiSelectedValue,
    // bool? pembukaBagasiIsEnabled, // Removed
    int? jokDepanSelectedValue,
    // bool? jokDepanIsEnabled, // Removed
    int? aromaInteriorSelectedValue,
    // bool? aromaInteriorIsEnabled, // Removed
    int? handlePintuSelectedValue,
    // bool? handlePintuIsEnabled, // Removed
    int? consoleBoxSelectedValue,
    // bool? consoleBoxIsEnabled, // Removed
    int? spionTengahSelectedValue,
    // bool? spionTengahIsEnabled, // Removed
    int? tuasPersnelingSelectedValue,
    // bool? tuasPersnelingIsEnabled, // Removed
    int? jokBelakangSelectedValue,
    // bool? jokBelakangIsEnabled, // Removed
    int? panelIndikatorSelectedValue,
    // bool? panelIndikatorIsEnabled, // Removed
    int? switchLampuSelectedValue,
    // bool? switchLampuIsEnabled, // Removed
    int? karpetDasarSelectedValue,
    // bool? karpetDasarIsEnabled, // Removed
    int? klaksonSelectedValue,
    // bool? klaksonIsEnabled, // Removed
    int? sunVisorSelectedValue,
    // bool? sunVisorIsEnabled, // Removed
    int? tuasTangkiBensinSelectedValue,
    // bool? tuasTangkiBensinIsEnabled, // Removed
    int? sabukPengamanSelectedValue,
    // bool? sabukPengamanIsEnabled, // Removed
    int? trimInteriorSelectedValue,
    // bool? trimInteriorIsEnabled, // Removed
    int? plafonSelectedValue,
    // bool? plafonIsEnabled, // Removed
    List<String>? interiorCatatanList,
    int? bumperDepanSelectedValue,
    // bool? bumperDepanIsEnabled, // Removed
    int? kapMesinSelectedValue,
    // bool? kapMesinIsEnabled, // Removed
    int? lampuUtamaSelectedValue,
    // bool? lampuUtamaIsEnabled, // Removed
    int? panelAtapSelectedValue,
    // bool? panelAtapIsEnabled, // Removed
    int? grillSelectedValue,
    // bool? grillIsEnabled, // Removed
    int? lampuFoglampSelectedValue,
    // bool? lampuFoglampIsEnabled, // Removed
    int? kacaBeningSelectedValue,
    // bool? kacaBeningIsEnabled, // Removed
    int? wiperBelakangSelectedValue,
    // bool? wiperBelakangIsEnabled, // Removed
    int? bumperBelakangSelectedValue,
    // bool? bumperBelakangIsEnabled, // Removed
    int? lampuBelakangSelectedValue,
    // bool? lampuBelakangIsEnabled, // Removed
    int? trunklidSelectedValue,
    // bool? trunklidIsEnabled, // Removed
    int? kacaDepanSelectedValue,
    // bool? kacaDepanIsEnabled, // Removed
    int? fenderKananSelectedValue,
    // bool? fenderKananIsEnabled, // Removed
    int? quarterPanelKananSelectedValue,
    // bool? quarterPanelKananIsEnabled, // Removed
    int? pintuBelakangKananSelectedValue,
    // bool? pintuBelakangKananIsEnabled, // Removed
    int? spionKananSelectedValue,
    // bool? spionKananIsEnabled, // Removed
    int? lisplangKananSelectedValue,
    // bool? lisplangKananIsEnabled, // Removed
    int? sideSkirtKananSelectedValue,
    // bool? sideSkirtKananIsEnabled, // Removed
    int? daunWiperSelectedValue,
    // bool? daunWiperIsEnabled, // Removed
    int? pintuBelakangSelectedValue,
    // bool? pintuBelakangIsEnabled, // Removed
    int? fenderKiriSelectedValue,
    // bool? fenderKiriIsEnabled, // Removed
    int? quarterPanelKiriSelectedValue,
    // bool? quarterPanelKiriIsEnabled, // Removed
    int? pintuDepanSelectedValue,
    // bool? pintuDepanIsEnabled, // Removed
    int? kacaJendelaKananSelectedValue,
    // bool? kacaJendelaKananIsEnabled, // Removed
    int? pintuBelakangKiriSelectedValue,
    // bool? pintuBelakangKiriIsEnabled, // Removed
    int? spionKiriSelectedValue,
    // bool? spionKiriIsEnabled, // Removed
    int? pintuDepanKiriSelectedValue,
    // bool? pintuDepanKiriIsEnabled, // Removed
    int? kacaJendelaKiriSelectedValue,
    // bool? kacaJendelaKiriIsEnabled, // Removed
    int? lisplangKiriSelectedValue,
    // bool? lisplangKiriIsEnabled, // Removed
    int? sideSkirtKiriSelectedValue,
    // bool? sideSkirtKiriIsEnabled, // Removed
    List<String>? eksteriorCatatanList,
    int? banDepanSelectedValue,
    // bool? banDepanIsEnabled, // Removed
    int? velgDepanSelectedValue,
    // bool? velgDepanIsEnabled, // Removed
    int? discBrakeSelectedValue,
    // bool? discBrakeIsEnabled, // Removed
    int? masterRemSelectedValue,
    // bool? masterRemIsEnabled, // Removed
    int? tieRodSelectedValue,
    // bool? tieRodIsEnabled, // Removed
    int? gardanSelectedValue,
    // bool? gardanIsEnabled, // Removed
    int? banBelakangSelectedValue,
    // bool? banBelakangIsEnabled, // Removed
    int? velgBelakangSelectedValue,
    // bool? velgBelakangIsEnabled, // Removed
    int? brakePadSelectedValue,
    // bool? brakePadIsEnabled, // Removed
    int? crossmemberSelectedValue,
    // bool? crossmemberIsEnabled, // Removed
    int? knalpotSelectedValue,
    // bool? knalpotIsEnabled, // Removed
    int? balljointSelectedValue,
    // bool? balljointIsEnabled, // Removed
    int? rocksteerSelectedValue,
    // bool? rocksteerIsEnabled, // Removed
    int? karetBootSelectedValue,
    // bool? karetBootIsEnabled, // Removed
    int? upperLowerArmSelectedValue,
    // bool? upperLowerArmIsEnabled, // Removed
    int? shockBreakerSelectedValue,
    // bool? shockBreakerIsEnabled, // Removed
    int? linkStabilizerSelectedValue,
    // bool? linkStabilizerIsEnabled, // Removed
    List<String>? banDanKakiKakiCatatanList,
    int? bunyiGetaranSelectedValue,
    // bool? bunyiGetaranIsEnabled, // Removed
    int? performaStirSelectedValue,
    // bool? performaStirIsEnabled, // Removed
    int? perpindahanTransmisiSelectedValue,
    // bool? perpindahanTransmisiIsEnabled, // Removed
    int? stirBalanceSelectedValue,
    // bool? stirBalanceIsEnabled, // Removed
    int? performaSuspensiSelectedValue,
    // bool? performaSuspensiIsEnabled, // Removed
    int? performaKoplingSelectedValue,
    // bool? performaKoplingIsEnabled, // Removed
    int? rpmSelectedValue,
    // bool? rpmIsEnabled, // Removed
    List<String>? testDriveCatatanList,
    int? tebalCatBodyDepanSelectedValue,
    // bool? tebalCatBodyDepanIsEnabled, // Removed
    int? tebalCatBodyKiriSelectedValue,
    // bool? tebalCatBodyKiriIsEnabled, // Removed
    int? temperatureAcMobilSelectedValue,
    // bool? temperatureAcMobilIsEnabled, // Removed
    int? tebalCatBodyKananSelectedValue,
    // bool? tebalCatBodyKananIsEnabled, // Removed
    int? tebalCatBodyBelakangSelectedValue,
    // bool? tebalCatBodyBelakangIsEnabled, // Removed
    int? obdScannerSelectedValue,
    // bool? obdScannerIsEnabled, // Removed
    int? tebalCatBodyAtapSelectedValue,
    // bool? tebalCatBodyAtapIsEnabled, // Removed
    int? testAccuSelectedValue,
    // bool? testAccuIsEnabled, // Removed
    List<String>? toolsTestCatatanList,
  }) {
    return FormData(
      namaInspektor: namaInspektor ?? this.namaInspektor,
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
      // getaranMesinIsEnabled: getaranMesinIsEnabled ?? this.getaranMesinIsEnabled, // Removed
      suaraMesinSelectedValue: suaraMesinSelectedValue ?? this.suaraMesinSelectedValue,
      // suaraMesinIsEnabled: suaraMesinIsEnabled ?? this.suaraMesinIsEnabled, // Removed
      transmisiSelectedValue: transmisiSelectedValue ?? this.transmisiSelectedValue,
      // transmisiIsEnabled: transmisiIsEnabled ?? this.transmisiIsEnabled, // Removed
      pompaPowerSteeringSelectedValue: pompaPowerSteeringSelectedValue ?? this.pompaPowerSteeringSelectedValue,
      // pompaPowerSteeringIsEnabled: pompaPowerSteeringIsEnabled ?? this.pompaPowerSteeringIsEnabled, // Removed
      coverTimingChainSelectedValue: coverTimingChainSelectedValue ?? this.coverTimingChainSelectedValue,
      // coverTimingChainIsEnabled: coverTimingChainIsEnabled ?? this.coverTimingChainIsEnabled, // Removed
      oliPowerSteeringSelectedValue: oliPowerSteeringSelectedValue ?? this.oliPowerSteeringSelectedValue,
      // oliPowerSteeringIsEnabled: oliPowerSteeringIsEnabled ?? this.oliPowerSteeringIsEnabled, // Removed
      accuSelectedValue: accuSelectedValue ?? this.accuSelectedValue,
      // accuIsEnabled: accuIsEnabled ?? this.accuIsEnabled, // Removed
      kompressorAcSelectedValue: kompressorAcSelectedValue ?? this.kompressorAcSelectedValue,
      // kompressorAcIsEnabled: kompressorAcIsEnabled ?? this.kompressorAcIsEnabled, // Removed
      fanSelectedValue: fanSelectedValue ?? this.fanSelectedValue,
      // fanIsEnabled: fanIsEnabled ?? this.fanIsEnabled, // Removed
      selangSelectedValue: selangSelectedValue ?? this.selangSelectedValue,
      // selangIsEnabled: selangIsEnabled ?? this.selangIsEnabled, // Removed
      karterOliSelectedValue: karterOliSelectedValue ?? this.karterOliSelectedValue,
      // karterOliIsEnabled: karterOliIsEnabled ?? this.karterOliIsEnabled, // Removed
      oilRemSelectedValue: oilRemSelectedValue ?? this.oilRemSelectedValue,
      // oilRemIsEnabled: oilRemIsEnabled ?? this.oilRemIsEnabled, // Removed
      kabelSelectedValue: kabelSelectedValue ?? this.kabelSelectedValue,
      // kabelIsEnabled: kabelIsEnabled ?? this.kabelIsEnabled, // Removed
      kondensorSelectedValue: kondensorSelectedValue ?? this.kondensorSelectedValue,
      // kondensorIsEnabled: kondensorIsEnabled ?? this.kondensorIsEnabled, // Removed
      radiatorSelectedValue: radiatorSelectedValue ?? this.radiatorSelectedValue,
      // radiatorIsEnabled: radiatorIsEnabled ?? this.radiatorIsEnabled, // Removed
      cylinderHeadSelectedValue: cylinderHeadSelectedValue ?? this.cylinderHeadSelectedValue,
      // cylinderHeadIsEnabled: cylinderHeadIsEnabled ?? this.cylinderHeadIsEnabled, // Removed
      oliMesinSelectedValue: oliMesinSelectedValue ?? this.oliMesinSelectedValue,
      // oliMesinIsEnabled: oliMesinIsEnabled ?? this.oliMesinIsEnabled, // Removed
      airRadiatorSelectedValue: airRadiatorSelectedValue ?? this.airRadiatorSelectedValue,
      // airRadiatorIsEnabled: airRadiatorIsEnabled ?? this.airRadiatorIsEnabled, // Removed
      coverKlepSelectedValue: coverKlepSelectedValue ?? this.coverKlepSelectedValue,
      // coverKlepIsEnabled: coverKlepIsEnabled ?? this.coverKlepIsEnabled, // Removed
      alternatorSelectedValue: alternatorSelectedValue ?? this.alternatorSelectedValue,
      // alternatorIsEnabled: alternatorIsEnabled ?? this.alternatorIsEnabled, // Removed
      waterPumpSelectedValue: waterPumpSelectedValue ?? this.waterPumpSelectedValue,
      // waterPumpIsEnabled: waterPumpIsEnabled ?? this.waterPumpIsEnabled, // Removed
      beltSelectedValue: beltSelectedValue ?? this.beltSelectedValue,
      // beltIsEnabled: beltIsEnabled ?? this.beltIsEnabled, // Removed
      oliTransmisiSelectedValue: oliTransmisiSelectedValue ?? this.oliTransmisiSelectedValue,
      // oliTransmisiIsEnabled: oliTransmisiIsEnabled ?? this.oliTransmisiIsEnabled, // Removed
      cylinderBlockSelectedValue: cylinderBlockSelectedValue ?? this.cylinderBlockSelectedValue,
      // cylinderBlockIsEnabled: cylinderBlockIsEnabled ?? this.cylinderBlockIsEnabled, // Removed
      bushingBesarSelectedValue: bushingBesarSelectedValue ?? this.bushingBesarSelectedValue,
      // bushingBesarIsEnabled: bushingBesarIsEnabled ?? this.bushingBesarIsEnabled, // Removed
      bushingKecilSelectedValue: bushingKecilSelectedValue ?? this.bushingKecilSelectedValue,
      // bushingKecilIsEnabled: bushingKecilIsEnabled ?? this.bushingKecilIsEnabled, // Removed
      tutupRadiatorSelectedValue: tutupRadiatorSelectedValue ?? this.tutupRadiatorSelectedValue,
      // tutupRadiatorIsEnabled: tutupRadiatorIsEnabled ?? this.tutupRadiatorIsEnabled, // Removed
      mesinCatatanList: mesinCatatanList ?? this.mesinCatatanList,
      stirSelectedValue: stirSelectedValue ?? this.stirSelectedValue,
      // stirIsEnabled: stirIsEnabled ?? this.stirIsEnabled, // Removed
      remTanganSelectedValue: remTanganSelectedValue ?? this.remTanganSelectedValue,
      // remTanganIsEnabled: remTanganIsEnabled ?? this.remTanganIsEnabled, // Removed
      pedalSelectedValue: pedalSelectedValue ?? this.pedalSelectedValue,
      // pedalIsEnabled: pedalIsEnabled ?? this.pedalIsEnabled, // Removed
      switchWiperSelectedValue: switchWiperSelectedValue ?? this.switchWiperSelectedValue,
      // switchWiperIsEnabled: switchWiperIsEnabled ?? this.switchWiperIsEnabled, // Removed
      lampuHazardSelectedValue: lampuHazardSelectedValue ?? this.lampuHazardSelectedValue,
      // lampuHazardIsEnabled: lampuHazardIsEnabled ?? this.lampuHazardIsEnabled, // Removed
      panelDashboardSelectedValue: panelDashboardSelectedValue ?? this.panelDashboardSelectedValue,
      // panelDashboardIsEnabled: panelDashboardIsEnabled ?? this.panelDashboardIsEnabled, // Removed
      pembukaKapMesinSelectedValue: pembukaKapMesinSelectedValue ?? this.pembukaKapMesinSelectedValue,
      // pembukaKapMesinIsEnabled: pembukaKapMesinIsEnabled ?? this.pembukaKapMesinIsEnabled, // Removed
      pembukaBagasiSelectedValue: pembukaBagasiSelectedValue ?? this.pembukaBagasiSelectedValue,
      // pembukaBagasiIsEnabled: pembukaBagasiIsEnabled ?? this.pembukaBagasiIsEnabled, // Removed
      jokDepanSelectedValue: jokDepanSelectedValue ?? this.jokDepanSelectedValue,
      // jokDepanIsEnabled: jokDepanIsEnabled ?? this.jokDepanIsEnabled, // Removed
      aromaInteriorSelectedValue: aromaInteriorSelectedValue ?? this.aromaInteriorSelectedValue,
      // aromaInteriorIsEnabled: aromaInteriorIsEnabled ?? this.aromaInteriorIsEnabled, // Removed
      handlePintuSelectedValue: handlePintuSelectedValue ?? this.handlePintuSelectedValue,
      // handlePintuIsEnabled: handlePintuIsEnabled ?? this.handlePintuIsEnabled, // Removed
      consoleBoxSelectedValue: consoleBoxSelectedValue ?? this.consoleBoxSelectedValue,
      // consoleBoxIsEnabled: consoleBoxIsEnabled ?? this.consoleBoxIsEnabled, // Removed
      spionTengahSelectedValue: spionTengahSelectedValue ?? this.spionTengahSelectedValue,
      // spionTengahIsEnabled: spionTengahIsEnabled ?? this.spionTengahIsEnabled, // Removed
      tuasPersnelingSelectedValue: tuasPersnelingSelectedValue ?? this.tuasPersnelingSelectedValue,
      // tuasPersnelingIsEnabled: tuasPersnelingIsEnabled ?? this.tuasPersnelingIsEnabled, // Removed
      jokBelakangSelectedValue: jokBelakangSelectedValue ?? this.jokBelakangSelectedValue,
      // jokBelakangIsEnabled: jokBelakangIsEnabled ?? this.jokBelakangIsEnabled, // Removed
      panelIndikatorSelectedValue: panelIndikatorSelectedValue ?? this.panelIndikatorSelectedValue,
      // panelIndikatorIsEnabled: panelIndikatorIsEnabled ?? this.panelIndikatorIsEnabled, // Removed
      switchLampuSelectedValue: switchLampuSelectedValue ?? this.switchLampuSelectedValue,
      // switchLampuIsEnabled: switchLampuIsEnabled ?? this.switchLampuIsEnabled, // Removed
      karpetDasarSelectedValue: karpetDasarSelectedValue ?? this.karpetDasarSelectedValue,
      // karpetDasarIsEnabled: karpetDasarIsEnabled ?? this.karpetDasarIsEnabled, // Removed
      klaksonSelectedValue: klaksonSelectedValue ?? this.klaksonSelectedValue,
      // klaksonIsEnabled: klaksonIsEnabled ?? this.klaksonIsEnabled, // Removed
      sunVisorSelectedValue: sunVisorSelectedValue ?? this.sunVisorSelectedValue,
      // sunVisorIsEnabled: sunVisorIsEnabled ?? this.sunVisorIsEnabled, // Removed
      tuasTangkiBensinSelectedValue: tuasTangkiBensinSelectedValue ?? this.tuasTangkiBensinSelectedValue,
      // tuasTangkiBensinIsEnabled: tuasTangkiBensinIsEnabled ?? this.tuasTangkiBensinIsEnabled, // Removed
      sabukPengamanSelectedValue: sabukPengamanSelectedValue ?? this.sabukPengamanSelectedValue,
      // sabukPengamanIsEnabled: sabukPengamanIsEnabled ?? this.sabukPengamanIsEnabled, // Removed
      trimInteriorSelectedValue: trimInteriorSelectedValue ?? this.trimInteriorSelectedValue,
      // trimInteriorIsEnabled: trimInteriorIsEnabled ?? this.trimInteriorIsEnabled, // Removed
      plafonSelectedValue: plafonSelectedValue ?? this.plafonSelectedValue,
      // plafonIsEnabled: plafonIsEnabled ?? this.plafonIsEnabled, // Removed
      interiorCatatanList: interiorCatatanList ?? this.interiorCatatanList,
      bumperDepanSelectedValue: bumperDepanSelectedValue ?? this.bumperDepanSelectedValue,
      // bumperDepanIsEnabled: bumperDepanIsEnabled ?? this.bumperDepanIsEnabled, // Removed
      kapMesinSelectedValue: kapMesinSelectedValue ?? this.kapMesinSelectedValue,
      // kapMesinIsEnabled: kapMesinIsEnabled ?? this.kapMesinIsEnabled, // Removed
      lampuUtamaSelectedValue: lampuUtamaSelectedValue ?? this.lampuUtamaSelectedValue,
      // lampuUtamaIsEnabled: lampuUtamaIsEnabled ?? this.lampuUtamaIsEnabled, // Removed
      panelAtapSelectedValue: panelAtapSelectedValue ?? this.panelAtapSelectedValue,
      // panelAtapIsEnabled: panelAtapIsEnabled ?? this.panelAtapIsEnabled, // Removed
      grillSelectedValue: grillSelectedValue ?? this.grillSelectedValue,
      // grillIsEnabled: grillIsEnabled ?? this.grillIsEnabled, // Removed
      lampuFoglampSelectedValue: lampuFoglampSelectedValue ?? this.lampuFoglampSelectedValue,
      // lampuFoglampIsEnabled: lampuFoglampIsEnabled ?? this.lampuFoglampIsEnabled, // Removed
      kacaBeningSelectedValue: kacaBeningSelectedValue ?? this.kacaBeningSelectedValue,
      // kacaBeningIsEnabled: kacaBeningIsEnabled ?? this.kacaBeningIsEnabled, // Removed
      wiperBelakangSelectedValue: wiperBelakangSelectedValue ?? this.wiperBelakangSelectedValue,
      // wiperBelakangIsEnabled: wiperBelakangIsEnabled ?? this.wiperBelakangIsEnabled, // Removed
      bumperBelakangSelectedValue: bumperBelakangSelectedValue ?? this.bumperBelakangSelectedValue,
      // bumperBelakangIsEnabled: bumperBelakangIsEnabled ?? this.bumperBelakangIsEnabled, // Removed
      lampuBelakangSelectedValue: lampuBelakangSelectedValue ?? this.lampuBelakangSelectedValue,
      // lampuBelakangIsEnabled: lampuBelakangIsEnabled ?? this.lampuBelakangIsEnabled, // Removed
      trunklidSelectedValue: trunklidSelectedValue ?? this.trunklidSelectedValue,
      // trunklidIsEnabled: trunklidIsEnabled ?? this.trunklidIsEnabled, // Removed
      kacaDepanSelectedValue: kacaDepanSelectedValue ?? this.kacaDepanSelectedValue,
      // kacaDepanIsEnabled: kacaDepanIsEnabled ?? this.kacaDepanIsEnabled, // Removed
      fenderKananSelectedValue: fenderKananSelectedValue ?? this.fenderKananSelectedValue,
      // fenderKananIsEnabled: fenderKananIsEnabled ?? this.fenderKananIsEnabled, // Removed
      quarterPanelKananSelectedValue: quarterPanelKananSelectedValue ?? this.quarterPanelKananSelectedValue,
      // quarterPanelKananIsEnabled: quarterPanelKananIsEnabled ?? this.quarterPanelKananIsEnabled, // Removed
      pintuBelakangKananSelectedValue: pintuBelakangKananSelectedValue ?? this.pintuBelakangKananSelectedValue,
      // pintuBelakangKananIsEnabled: pintuBelakangKananIsEnabled ?? this.pintuBelakangKananIsEnabled, // Removed
      spionKananSelectedValue: spionKananSelectedValue ?? this.spionKananSelectedValue,
      // spionKananIsEnabled: spionKananIsEnabled ?? this.spionKananIsEnabled, // Removed
      lisplangKananSelectedValue: lisplangKananSelectedValue ?? this.lisplangKananSelectedValue,
      // lisplangKananIsEnabled: lisplangKananIsEnabled ?? this.lisplangKananIsEnabled, // Removed
      sideSkirtKananSelectedValue: sideSkirtKananSelectedValue ?? this.sideSkirtKananSelectedValue,
      // sideSkirtKananIsEnabled: sideSkirtKananIsEnabled ?? this.sideSkirtKananIsEnabled, // Removed
      daunWiperSelectedValue: daunWiperSelectedValue ?? this.daunWiperSelectedValue,
      // daunWiperIsEnabled: daunWiperIsEnabled ?? this.daunWiperIsEnabled, // Removed
      pintuBelakangSelectedValue: pintuBelakangSelectedValue ?? this.pintuBelakangSelectedValue,
      // pintuBelakangIsEnabled: pintuBelakangIsEnabled ?? this.pintuBelakangIsEnabled, // Removed
      fenderKiriSelectedValue: fenderKiriSelectedValue ?? this.fenderKiriSelectedValue,
      // fenderKiriIsEnabled: fenderKiriIsEnabled ?? this.fenderKiriIsEnabled, // Removed
      quarterPanelKiriSelectedValue: quarterPanelKiriSelectedValue ?? this.quarterPanelKiriSelectedValue,
      // quarterPanelKiriIsEnabled: quarterPanelKiriIsEnabled ?? this.quarterPanelKiriIsEnabled, // Removed
      pintuDepanSelectedValue: pintuDepanSelectedValue ?? this.pintuDepanSelectedValue,
      // pintuDepanIsEnabled: pintuDepanIsEnabled ?? this.pintuDepanIsEnabled, // Removed
      kacaJendelaKananSelectedValue: kacaJendelaKananSelectedValue ?? this.kacaJendelaKananSelectedValue,
      // kacaJendelaKananIsEnabled: kacaJendelaKananIsEnabled ?? this.kacaJendelaKananIsEnabled, // Removed
      pintuBelakangKiriSelectedValue: pintuBelakangKiriSelectedValue ?? this.pintuBelakangKiriSelectedValue,
      // pintuBelakangKiriIsEnabled: pintuBelakangKiriIsEnabled ?? this.pintuBelakangKiriIsEnabled, // Removed
      spionKiriSelectedValue: spionKiriSelectedValue ?? this.spionKiriSelectedValue,
      // spionKiriIsEnabled: spionKiriIsEnabled ?? this.spionKiriIsEnabled, // Removed
      pintuDepanKiriSelectedValue: pintuDepanKiriSelectedValue ?? this.pintuDepanKiriSelectedValue,
      // pintuDepanKiriIsEnabled: pintuDepanKiriIsEnabled ?? this.pintuDepanKiriIsEnabled, // Removed
      kacaJendelaKiriSelectedValue: kacaJendelaKiriSelectedValue ?? this.kacaJendelaKiriSelectedValue,
      // kacaJendelaKiriIsEnabled: kacaJendelaKiriIsEnabled ?? this.kacaJendelaKiriIsEnabled, // Removed
      lisplangKiriSelectedValue: lisplangKiriSelectedValue ?? this.lisplangKiriSelectedValue,
      // lisplangKiriIsEnabled: lisplangKiriIsEnabled ?? this.lisplangKiriIsEnabled, // Removed
      sideSkirtKiriSelectedValue: sideSkirtKiriSelectedValue ?? this.sideSkirtKiriSelectedValue,
      // sideSkirtKiriIsEnabled: sideSkirtKiriIsEnabled ?? this.sideSkirtKiriIsEnabled, // Removed
      eksteriorCatatanList: eksteriorCatatanList ?? this.eksteriorCatatanList,
      banDepanSelectedValue: banDepanSelectedValue ?? this.banDepanSelectedValue,
      // banDepanIsEnabled: banDepanIsEnabled ?? this.banDepanIsEnabled, // Removed
      velgDepanSelectedValue: velgDepanSelectedValue ?? this.velgDepanSelectedValue,
      // velgDepanIsEnabled: velgDepanIsEnabled ?? this.velgDepanIsEnabled, // Removed
      discBrakeSelectedValue: discBrakeSelectedValue ?? this.discBrakeSelectedValue,
      // discBrakeIsEnabled: discBrakeIsEnabled ?? this.discBrakeIsEnabled, // Removed
      masterRemSelectedValue: masterRemSelectedValue ?? this.masterRemSelectedValue,
      // masterRemIsEnabled: masterRemIsEnabled ?? this.masterRemIsEnabled, // Removed
      tieRodSelectedValue: tieRodSelectedValue ?? this.tieRodSelectedValue,
      // tieRodIsEnabled: tieRodIsEnabled ?? this.tieRodIsEnabled, // Removed
      gardanSelectedValue: gardanSelectedValue ?? this.gardanSelectedValue,
      // gardanIsEnabled: gardanIsEnabled ?? this.gardanIsEnabled, // Removed
      banBelakangSelectedValue: banBelakangSelectedValue ?? this.banBelakangSelectedValue,
      // banBelakangIsEnabled: banBelakangIsEnabled ?? this.banBelakangIsEnabled, // Removed
      velgBelakangSelectedValue: velgBelakangSelectedValue ?? this.velgBelakangSelectedValue,
      // velgBelakangIsEnabled: velgBelakangIsEnabled ?? this.velgBelakangIsEnabled, // Removed
      brakePadSelectedValue: brakePadSelectedValue ?? this.brakePadSelectedValue,
      // brakePadIsEnabled: brakePadIsEnabled ?? this.brakePadIsEnabled, // Removed
      crossmemberSelectedValue: crossmemberSelectedValue ?? this.crossmemberSelectedValue,
      // crossmemberIsEnabled: crossmemberIsEnabled ?? this.crossmemberIsEnabled, // Removed
      knalpotSelectedValue: knalpotSelectedValue ?? this.knalpotSelectedValue,
      // knalpotIsEnabled: knalpotIsEnabled ?? this.knalpotIsEnabled, // Removed
      balljointSelectedValue: balljointSelectedValue ?? this.balljointSelectedValue,
      // balljointIsEnabled: balljointIsEnabled ?? this.balljointIsEnabled, // Removed
      rocksteerSelectedValue: rocksteerSelectedValue ?? this.rocksteerSelectedValue,
      // rocksteerIsEnabled: rocksteerIsEnabled ?? this.rocksteerIsEnabled, // Removed
      karetBootSelectedValue: karetBootSelectedValue ?? this.karetBootSelectedValue,
      // karetBootIsEnabled: karetBootIsEnabled ?? this.karetBootIsEnabled, // Removed
      upperLowerArmSelectedValue: upperLowerArmSelectedValue ?? this.upperLowerArmSelectedValue,
      // upperLowerArmIsEnabled: upperLowerArmIsEnabled ?? this.upperLowerArmIsEnabled, // Removed
      shockBreakerSelectedValue: shockBreakerSelectedValue ?? this.shockBreakerSelectedValue,
      // shockBreakerIsEnabled: shockBreakerIsEnabled ?? this.shockBreakerIsEnabled, // Removed
      linkStabilizerSelectedValue: linkStabilizerSelectedValue ?? this.linkStabilizerSelectedValue,
      // linkStabilizerIsEnabled: linkStabilizerIsEnabled ?? this.linkStabilizerIsEnabled, // Removed
      banDanKakiKakiCatatanList: banDanKakiKakiCatatanList ?? this.banDanKakiKakiCatatanList,
      bunyiGetaranSelectedValue: bunyiGetaranSelectedValue ?? this.bunyiGetaranSelectedValue,
      // bunyiGetaranIsEnabled: bunyiGetaranIsEnabled ?? this.bunyiGetaranIsEnabled, // Removed
      performaStirSelectedValue: performaStirSelectedValue ?? this.performaStirSelectedValue,
      // performaStirIsEnabled: performaStirIsEnabled ?? this.performaStirIsEnabled, // Removed
      perpindahanTransmisiSelectedValue: perpindahanTransmisiSelectedValue ?? this.perpindahanTransmisiSelectedValue,
      // perpindahanTransmisiIsEnabled: perpindahanTransmisiIsEnabled ?? this.perpindahanTransmisiIsEnabled, // Removed
      stirBalanceSelectedValue: stirBalanceSelectedValue ?? this.stirBalanceSelectedValue,
      // stirBalanceIsEnabled: stirBalanceIsEnabled ?? this.stirBalanceIsEnabled, // Removed
      performaSuspensiSelectedValue: performaSuspensiSelectedValue ?? this.performaSuspensiSelectedValue,
      // performaSuspensiIsEnabled: performaSuspensiIsEnabled ?? this.performaSuspensiIsEnabled, // Removed
      performaKoplingSelectedValue: performaKoplingSelectedValue ?? this.performaKoplingSelectedValue,
      // performaKoplingIsEnabled: performaKoplingIsEnabled ?? this.performaKoplingIsEnabled, // Removed
      rpmSelectedValue: rpmSelectedValue ?? this.rpmSelectedValue,
      // rpmIsEnabled: rpmIsEnabled ?? this.rpmIsEnabled, // Removed
      testDriveCatatanList: testDriveCatatanList ?? this.testDriveCatatanList,
      // New fields for Page Five Seven (Tools Test)
      tebalCatBodyDepanSelectedValue: tebalCatBodyDepanSelectedValue ?? this.tebalCatBodyDepanSelectedValue,
      // tebalCatBodyDepanIsEnabled: tebalCatBodyDepanIsEnabled ?? this.tebalCatBodyDepanIsEnabled, // Removed
      tebalCatBodyKiriSelectedValue: tebalCatBodyKiriSelectedValue ?? this.tebalCatBodyKiriSelectedValue,
      // tebalCatBodyKiriIsEnabled: tebalCatBodyKiriIsEnabled ?? this.tebalCatBodyKiriIsEnabled, // Removed
      temperatureAcMobilSelectedValue: temperatureAcMobilSelectedValue ?? this.temperatureAcMobilSelectedValue,
      // temperatureAcMobilIsEnabled: temperatureAcMobilIsEnabled ?? this.temperatureAcMobilIsEnabled, // Removed
      tebalCatBodyKananSelectedValue: tebalCatBodyKananSelectedValue ?? this.tebalCatBodyKananSelectedValue,
      // tebalCatBodyKananIsEnabled: tebalCatBodyKananIsEnabled ?? this.tebalCatBodyKananIsEnabled, // Removed
      tebalCatBodyBelakangSelectedValue: tebalCatBodyBelakangSelectedValue ?? this.tebalCatBodyBelakangSelectedValue,
      // tebalCatBodyBelakangIsEnabled: tebalCatBodyBelakangIsEnabled ?? this.tebalCatBodyBelakangIsEnabled, // Removed
      obdScannerSelectedValue: obdScannerSelectedValue ?? this.obdScannerSelectedValue,
      // obdScannerIsEnabled: obdScannerIsEnabled ?? this.obdScannerIsEnabled, // Removed
      tebalCatBodyAtapSelectedValue: tebalCatBodyAtapSelectedValue ?? this.tebalCatBodyAtapSelectedValue,
      // tebalCatBodyAtapIsEnabled: tebalCatBodyAtapIsEnabled ?? this.tebalCatBodyAtapIsEnabled, // Removed
      testAccuSelectedValue: testAccuSelectedValue ?? this.testAccuSelectedValue,
      // testAccuIsEnabled: testAccuIsEnabled ?? this.testAccuIsEnabled, // Removed
      toolsTestCatatanList: toolsTestCatatanList ?? this.toolsTestCatatanList,
    );
  }
}
