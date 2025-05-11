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

  void updateSuaraMesinSelectedValue(int? value) {
    state = state.copyWith(suaraMesinSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateTransmisiSelectedValue(int? value) {
    state = state.copyWith(transmisiSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePompaPowerSteeringSelectedValue(int? value) {
    state = state.copyWith(pompaPowerSteeringSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateCoverTimingChainSelectedValue(int? value) {
    state = state.copyWith(coverTimingChainSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateOliPowerSteeringSelectedValue(int? value) {
    state = state.copyWith(oliPowerSteeringSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateAccuSelectedValue(int? value) {
    state = state.copyWith(accuSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateKompressorAcSelectedValue(int? value) {
    state = state.copyWith(kompressorAcSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateFanSelectedValue(int? value) {
    state = state.copyWith(fanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateSelangSelectedValue(int? value) {
    state = state.copyWith(selangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateKarterOliSelectedValue(int? value) {
    state = state.copyWith(karterOliSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateOilRemSelectedValue(int? value) {
    state = state.copyWith(oilRemSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateKabelSelectedValue(int? value) {
    state = state.copyWith(kabelSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateKondensorSelectedValue(int? value) {
    state = state.copyWith(kondensorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateRadiatorSelectedValue(int? value) {
    state = state.copyWith(radiatorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateCylinderHeadSelectedValue(int? value) {
    state = state.copyWith(cylinderHeadSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateOliMesinSelectedValue(int? value) {
    state = state.copyWith(oliMesinSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateAirRadiatorSelectedValue(int? value) {
    state = state.copyWith(airRadiatorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateCoverKlepSelectedValue(int? value) {
    state = state.copyWith(coverKlepSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateAlternatorSelectedValue(int? value) {
    state = state.copyWith(alternatorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateWaterPumpSelectedValue(int? value) {
    state = state.copyWith(waterPumpSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateBeltSelectedValue(int? value) {
    state = state.copyWith(beltSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateOliTransmisiSelectedValue(int? value) {
    state = state.copyWith(oliTransmisiSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateCylinderBlockSelectedValue(int? value) {
    state = state.copyWith(cylinderBlockSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateBushingBesarSelectedValue(int? value) {
    state = state.copyWith(bushingBesarSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateBushingKecilSelectedValue(int? value) {
    state = state.copyWith(bushingKecilSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateTutupRadiatorSelectedValue(int? value) {
    state = state.copyWith(tutupRadiatorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateMesinCatatanList(List<String> lines) {
    state = state.copyWith(mesinCatatanList: lines);
  }

  // New update methods for Page Five Three
  void updateStirSelectedValue(int? value) {
    state = state.copyWith(stirSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateRemTanganSelectedValue(int? value) {
    state = state.copyWith(remTanganSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updatePedalSelectedValue(int? value) {
    state = state.copyWith(pedalSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateSwitchWiperSelectedValue(int? value) {
    state = state.copyWith(switchWiperSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateLampuHazardSelectedValue(int? value) {
    state = state.copyWith(lampuHazardSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updatePanelDashboardSelectedValue(int? value) {
    state = state.copyWith(panelDashboardSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updatePembukaKapMesinSelectedValue(int? value) {
    state = state.copyWith(pembukaKapMesinSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updatePembukaBagasiSelectedValue(int? value) {
    state = state.copyWith(pembukaBagasiSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateJokDepanSelectedValue(int? value) {
    state = state.copyWith(jokDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateAromaInteriorSelectedValue(int? value) {
    state = state.copyWith(aromaInteriorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateHandlePintuSelectedValue(int? value) {
    state = state.copyWith(handlePintuSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateConsoleBoxSelectedValue(int? value) {
    state = state.copyWith(consoleBoxSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateSpionTengahSelectedValue(int? value) {
    state = state.copyWith(spionTengahSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateTuasPersnelingSelectedValue(int? value) {
    state = state.copyWith(tuasPersnelingSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateJokBelakangSelectedValue(int? value) {
    state = state.copyWith(jokBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updatePanelIndikatorSelectedValue(int? value) {
    state = state.copyWith(panelIndikatorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateSwitchLampuSelectedValue(int? value) {
    state = state.copyWith(switchLampuSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateKarpetDasarSelectedValue(int? value) {
    state = state.copyWith(karpetDasarSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateKlaksonSelectedValue(int? value) {
    state = state.copyWith(klaksonSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateSunVisorSelectedValue(int? value) {
    state = state.copyWith(sunVisorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateTuasTangkiBensinSelectedValue(int? value) {
    state = state.copyWith(tuasTangkiBensinSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateSabukPengamanSelectedValue(int? value) {
    state = state.copyWith(sabukPengamanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateTrimInteriorSelectedValue(int? value) {
    state = state.copyWith(trimInteriorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updatePlafonSelectedValue(int? value) {
    state = state.copyWith(plafonSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateInteriorCatatanList(List<String> lines) {
    state = state.copyWith(interiorCatatanList: lines);
  }

  // New update methods for Page Five Four
  void updateBumperDepanSelectedValue(int? value) {
    state = state.copyWith(bumperDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateKapMesinSelectedValue(int? value) {
    state = state.copyWith(kapMesinSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateLampuUtamaSelectedValue(int? value) {
    state = state.copyWith(lampuUtamaSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updatePanelAtapSelectedValue(int? value) {
    state = state.copyWith(panelAtapSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateGrillSelectedValue(int? value) {
    state = state.copyWith(grillSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateLampuFoglampSelectedValue(int? value) {
    state = state.copyWith(lampuFoglampSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateKacaBeningSelectedValue(int? value) {
    state = state.copyWith(kacaBeningSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateWiperBelakangSelectedValue(int? value) {
    state = state.copyWith(wiperBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateBumperBelakangSelectedValue(int? value) {
    state = state.copyWith(bumperBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateLampuBelakangSelectedValue(int? value) {
    state = state.copyWith(lampuBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateTrunklidSelectedValue(int? value) {
    state = state.copyWith(trunklidSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateKacaDepanSelectedValue(int? value) {
    state = state.copyWith(kacaDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateFenderKananSelectedValue(int? value) {
    state = state.copyWith(fenderKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateQuarterPanelKananSelectedValue(int? value) {
    state = state.copyWith(quarterPanelKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updatePintuBelakangKananSelectedValue(int? value) {
    state = state.copyWith(pintuBelakangKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateSpionKananSelectedValue(int? value) {
    state = state.copyWith(spionKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateLisplangKananSelectedValue(int? value) {
    state = state.copyWith(lisplangKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateSideSkirtKananSelectedValue(int? value) {
    state = state.copyWith(sideSkirtKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateDaunWiperSelectedValue(int? value) {
    state = state.copyWith(daunWiperSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updatePintuBelakangSelectedValue(int? value) {
    state = state.copyWith(pintuBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateFenderKiriSelectedValue(int? value) {
    state = state.copyWith(fenderKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateQuarterPanelKiriSelectedValue(int? value) {
    state = state.copyWith(quarterPanelKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updatePintuDepanSelectedValue(int? value) {
    state = state.copyWith(pintuDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateKacaJendelaKananSelectedValue(int? value) {
    state = state.copyWith(kacaJendelaKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updatePintuBelakangKiriSelectedValue(int? value) {
    state = state.copyWith(pintuBelakangKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateSpionKiriSelectedValue(int? value) {
    state = state.copyWith(spionKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updatePintuDepanKiriSelectedValue(int? value) {
    state = state.copyWith(pintuDepanKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateKacaJendelaKiriSelectedValue(int? value) {
    state = state.copyWith(kacaJendelaKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateLisplangKiriSelectedValue(int? value) {
    state = state.copyWith(lisplangKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateSideSkirtKiriSelectedValue(int? value) {
    state = state.copyWith(sideSkirtKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


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


  void updateVelgDepanSelectedValue(int? value) {
    state = state.copyWith(velgDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateDiscBrakeSelectedValue(int? value) {
    state = state.copyWith(discBrakeSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateMasterRemSelectedValue(int? value) {
    state = state.copyWith(masterRemSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateTieRodSelectedValue(int? value) {
    state = state.copyWith(tieRodSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateGardanSelectedValue(int? value) {
    state = state.copyWith(gardanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateBanBelakangSelectedValue(int? value) {
    state = state.copyWith(banBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateVelgBelakangSelectedValue(int? value) {
    state = state.copyWith(velgBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateBrakePadSelectedValue(int? value) {
    state = state.copyWith(brakePadSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateCrossmemberSelectedValue(int? value) {
    state = state.copyWith(crossmemberSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateKnalpotSelectedValue(int? value) {
    state = state.copyWith(knalpotSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateBalljointSelectedValue(int? value) {
    state = state.copyWith(balljointSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateRocksteerSelectedValue(int? value) {
    state = state.copyWith(rocksteerSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateKaretBootSelectedValue(int? value) {
    state = state.copyWith(karetBootSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateUpperLowerArmSelectedValue(int? value) {
    state = state.copyWith(upperLowerArmSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateShockBreakerSelectedValue(int? value) {
    state = state.copyWith(shockBreakerSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateLinkStabilizerSelectedValue(int? value) {
    state = state.copyWith(linkStabilizerSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateBanDanKakiKakiCatatanList(List<String> lines) {
    state = state.copyWith(banDanKakiKakiCatatanList: lines);
  }

  // New update methods for Page Five Six (Test Drive)
  void updateBunyiGetaranSelectedValue(int? value) {
    state = state.copyWith(bunyiGetaranSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updatePerformaStirSelectedValue(int? value) {
    state = state.copyWith(performaStirSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updatePerpindahanTransmisiSelectedValue(int? value) {
    state = state.copyWith(perpindahanTransmisiSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateStirBalanceSelectedValue(int? value) {
    state = state.copyWith(stirBalanceSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updatePerformaSuspensiSelectedValue(int? value) {
    state = state.copyWith(performaSuspensiSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updatePerformaKoplingSelectedValue(int? value) {
    state = state.copyWith(performaKoplingSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateRpmSelectedValue(int? value) {
    state = state.copyWith(rpmSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateTestDriveCatatanList(List<String> lines) {
    state = state.copyWith(testDriveCatatanList: lines);
  }

  // New update methods for Page Five Seven (Tools Test)
  void updateTebalCatBodyDepanSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateTebalCatBodyKiriSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateTemperatureAcMobilSelectedValue(int? value) {
    state = state.copyWith(temperatureAcMobilSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateTebalCatBodyKananSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateTebalCatBodyBelakangSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateObdScannerSelectedValue(int? value) {
    state = state.copyWith(obdScannerSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateTebalCatBodyAtapSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyAtapSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


  void updateTestAccuSelectedValue(int? value) {
    state = state.copyWith(testAccuSelectedValue: (value == null || value <= 0) ? 0 : value);
  }


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
