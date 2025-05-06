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

  void updateCabangInspeksi(String cabang) {
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

  void updateBpkp(String? value) {
    state = state.copyWith(bpkp: value);
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

  void updateAirbagIsEnabled(bool? enabled) {
    state = state.copyWith(airbagIsEnabled: enabled);
  }

  void updateSistemAudioSelectedValue(int? value) {
    state = state.copyWith(sistemAudioSelectedValue: value);
  }

  void updateSistemAudioIsEnabled(bool? enabled) {
    state = state.copyWith(sistemAudioIsEnabled: enabled);
  }

  void updatePowerWindowSelectedValue(int? value) {
    state = state.copyWith(powerWindowSelectedValue: value);
  }

  void updatePowerWindowIsEnabled(bool? enabled) {
    state = state.copyWith(powerWindowIsEnabled: enabled);
  }

  void updateSistemAcSelectedValue(int? value) {
    state = state.copyWith(sistemAcSelectedValue: value);
  }

  void updateSistemAcIsEnabled(bool? enabled) {
    state = state.copyWith(sistemAcIsEnabled: enabled);
  }

  void updateFiturCatatanList(List<String> lines) {
    state = state.copyWith(fiturCatatanList: lines);
  }

  // New update methods for Page Five Two
  void updateGetaranMesinSelectedValue(int? value) {
    state = state.copyWith(getaranMesinSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateGetaranMesinIsEnabled(bool? enabled) {
    state = state.copyWith(getaranMesinIsEnabled: enabled);
  }

  void updateSuaraMesinSelectedValue(int? value) {
    state = state.copyWith(suaraMesinSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateSuaraMesinIsEnabled(bool? enabled) {
    state = state.copyWith(suaraMesinIsEnabled: enabled);
  }

  void updateTransmisiSelectedValue(int? value) {
    state = state.copyWith(transmisiSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateTransmisiIsEnabled(bool? enabled) {
    state = state.copyWith(transmisiIsEnabled: enabled);
  }

  void updatePompaPowerSteeringSelectedValue(int? value) {
    state = state.copyWith(pompaPowerSteeringSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePompaPowerSteeringIsEnabled(bool? enabled) {
    state = state.copyWith(pompaPowerSteeringIsEnabled: enabled);
  }

  void updateCoverTimingChainSelectedValue(int? value) {
    state = state.copyWith(coverTimingChainSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateCoverTimingChainIsEnabled(bool? enabled) {
    state = state.copyWith(coverTimingChainIsEnabled: enabled);
  }

  void updateOliPowerSteeringSelectedValue(int? value) {
    state = state.copyWith(oliPowerSteeringSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateOliPowerSteeringIsEnabled(bool? enabled) {
    state = state.copyWith(oliPowerSteeringIsEnabled: enabled);
  }

  void updateAccuSelectedValue(int? value) {
    state = state.copyWith(accuSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateAccuIsEnabled(bool? enabled) {
    state = state.copyWith(accuIsEnabled: enabled);
  }

  void updateKompressorAcSelectedValue(int? value) {
    state = state.copyWith(kompressorAcSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateKompressorAcIsEnabled(bool? enabled) {
    state = state.copyWith(kompressorAcIsEnabled: enabled);
  }

  void updateFanSelectedValue(int? value) {
    state = state.copyWith(fanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateFanIsEnabled(bool? enabled) {
    state = state.copyWith(fanIsEnabled: enabled);
  }

  void updateSelangSelectedValue(int? value) {
    state = state.copyWith(selangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateSelangIsEnabled(bool? enabled) {
    state = state.copyWith(selangIsEnabled: enabled);
  }

  void updateKarterOliSelectedValue(int? value) {
    state = state.copyWith(karterOliSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateKarterOliIsEnabled(bool? enabled) {
    state = state.copyWith(karterOliIsEnabled: enabled);
  }

  void updateOilRemSelectedValue(int? value) {
    state = state.copyWith(oilRemSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateOilRemIsEnabled(bool? enabled) {
    state = state.copyWith(oilRemIsEnabled: enabled);
  }

  void updateKabelSelectedValue(int? value) {
    state = state.copyWith(kabelSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateKabelIsEnabled(bool? enabled) {
    state = state.copyWith(kabelIsEnabled: enabled);
  }

  void updateKondensorSelectedValue(int? value) {
    state = state.copyWith(kondensorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateKondensorIsEnabled(bool? enabled) {
    state = state.copyWith(kondensorIsEnabled: enabled);
  }

  void updateRadiatorSelectedValue(int? value) {
    state = state.copyWith(radiatorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateRadiatorIsEnabled(bool? enabled) {
    state = state.copyWith(radiatorIsEnabled: enabled);
  }

  void updateCylinderHeadSelectedValue(int? value) {
    state = state.copyWith(cylinderHeadSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateCylinderHeadIsEnabled(bool? enabled) {
    state = state.copyWith(cylinderHeadIsEnabled: enabled);
  }

  void updateOliMesinSelectedValue(int? value) {
    state = state.copyWith(oliMesinSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateOliMesinIsEnabled(bool? enabled) {
    state = state.copyWith(oliMesinIsEnabled: enabled);
  }

  void updateAirRadiatorSelectedValue(int? value) {
    state = state.copyWith(airRadiatorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateAirRadiatorIsEnabled(bool? enabled) {
    state = state.copyWith(airRadiatorIsEnabled: enabled);
  }

  void updateCoverKlepSelectedValue(int? value) {
    state = state.copyWith(coverKlepSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateCoverKlepIsEnabled(bool? enabled) {
    state = state.copyWith(coverKlepIsEnabled: enabled);
  }

  void updateAlternatorSelectedValue(int? value) {
    state = state.copyWith(alternatorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateAlternatorIsEnabled(bool? enabled) {
    state = state.copyWith(alternatorIsEnabled: enabled);
  }

  void updateWaterPumpSelectedValue(int? value) {
    state = state.copyWith(waterPumpSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateWaterPumpIsEnabled(bool? enabled) {
    state = state.copyWith(waterPumpIsEnabled: enabled);
  }

  void updateBeltSelectedValue(int? value) {
    state = state.copyWith(beltSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateBeltIsEnabled(bool? enabled) {
    state = state.copyWith(beltIsEnabled: enabled);
  }

  void updateOliTransmisiSelectedValue(int? value) {
    state = state.copyWith(oliTransmisiSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateOliTransmisiIsEnabled(bool? enabled) {
    state = state.copyWith(oliTransmisiIsEnabled: enabled);
  }

  void updateCylinderBlockSelectedValue(int? value) {
    state = state.copyWith(cylinderBlockSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateCylinderBlockIsEnabled(bool? enabled) {
    state = state.copyWith(cylinderBlockIsEnabled: enabled);
  }

  void updateBushingBesarSelectedValue(int? value) {
    state = state.copyWith(bushingBesarSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateBushingBesarIsEnabled(bool? enabled) {
    state = state.copyWith(bushingBesarIsEnabled: enabled);
  }

  void updateBushingKecilSelectedValue(int? value) {
    state = state.copyWith(bushingKecilSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateBushingKecilIsEnabled(bool? enabled) {
    state = state.copyWith(bushingKecilIsEnabled: enabled);
  }

  void updateTutupRadiatorSelectedValue(int? value) {
    state = state.copyWith(tutupRadiatorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateTutupRadiatorIsEnabled(bool? enabled) {
    state = state.copyWith(tutupRadiatorIsEnabled: enabled);
  }

  void updateMesinCatatanList(List<String> lines) {
    state = state.copyWith(mesinCatatanList: lines);
  }

  // New update methods for Page Five Three
  void updateStirSelectedValue(int? value) {
    state = state.copyWith(stirSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateStirIsEnabled(bool? enabled) {
    state = state.copyWith(stirIsEnabled: enabled);
  }

  void updateRemTonganSelectedValue(int? value) {
    state = state.copyWith(remTonganSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateRemTonganIsEnabled(bool? enabled) {
    state = state.copyWith(remTonganIsEnabled: enabled);
  }

  void updatePedalSelectedValue(int? value) {
    state = state.copyWith(pedalSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePedalIsEnabled(bool? enabled) {
    state = state.copyWith(pedalIsEnabled: enabled);
  }

  void updateSwitchWiperSelectedValue(int? value) {
    state = state.copyWith(switchWiperSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateSwitchWiperIsEnabled(bool? enabled) {
    state = state.copyWith(switchWiperIsEnabled: enabled);
  }

  void updateLampuHazardSelectedValue(int? value) {
    state = state.copyWith(lampuHazardSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateLampuHazardIsEnabled(bool? enabled) {
    state = state.copyWith(lampuHazardIsEnabled: enabled);
  }

  void updatePanelDashboardSelectedValue(int? value) {
    state = state.copyWith(panelDashboardSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePanelDashboardIsEnabled(bool? enabled) {
    state = state.copyWith(panelDashboardIsEnabled: enabled);
  }

  void updatePembukaKapMesinSelectedValue(int? value) {
    state = state.copyWith(pembukaKapMesinSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePembukaKapMesinIsEnabled(bool? enabled) {
    state = state.copyWith(pembukaKapMesinIsEnabled: enabled);
  }

  void updatePembukaBagasiSelectedValue(int? value) {
    state = state.copyWith(pembukaBagasiSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePembukaBagasiIsEnabled(bool? enabled) {
    state = state.copyWith(pembukaBagasiIsEnabled: enabled);
  }

  void updateJokDepanSelectedValue(int? value) {
    state = state.copyWith(jokDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateJokDepanIsEnabled(bool? enabled) {
    state = state.copyWith(jokDepanIsEnabled: enabled);
  }

  void updateAromaInteriorSelectedValue(int? value) {
    state = state.copyWith(aromaInteriorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateAromaInteriorIsEnabled(bool? enabled) {
    state = state.copyWith(aromaInteriorIsEnabled: enabled);
  }

  void updateHandlePintuSelectedValue(int? value) {
    state = state.copyWith(handlePintuSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateHandlePintuIsEnabled(bool? enabled) {
    state = state.copyWith(handlePintuIsEnabled: enabled);
  }

  void updateConsoleBoxSelectedValue(int? value) {
    state = state.copyWith(consoleBoxSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateConsoleBoxIsEnabled(bool? enabled) {
    state = state.copyWith(consoleBoxIsEnabled: enabled);
  }

  void updateSpionTengahSelectedValue(int? value) {
    state = state.copyWith(spionTengahSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateSpionTengahIsEnabled(bool? enabled) {
    state = state.copyWith(spionTengahIsEnabled: enabled);
  }

  void updateTuasPersnelingSelectedValue(int? value) {
    state = state.copyWith(tuasPersnelingSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateTuasPersnelingIsEnabled(bool? enabled) {
    state = state.copyWith(tuasPersnelingIsEnabled: enabled);
  }

  void updateJokBelakangSelectedValue(int? value) {
    state = state.copyWith(jokBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateJokBelakangIsEnabled(bool? enabled) {
    state = state.copyWith(jokBelakangIsEnabled: enabled);
  }

  void updatePanelIndikatorSelectedValue(int? value) {
    state = state.copyWith(panelIndikatorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePanelIndikatorIsEnabled(bool? enabled) {
    state = state.copyWith(panelIndikatorIsEnabled: enabled);
  }

  void updateSwitchLampuSelectedValue(int? value) {
    state = state.copyWith(switchLampuSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateSwitchLampuIsEnabled(bool? enabled) {
    state = state.copyWith(switchLampuIsEnabled: enabled);
  }

  void updateKarpetDasarSelectedValue(int? value) {
    state = state.copyWith(karpetDasarSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateKarpetDasarIsEnabled(bool? enabled) {
    state = state.copyWith(karpetDasarIsEnabled: enabled);
  }

  void updateKlaksonSelectedValue(int? value) {
    state = state.copyWith(klaksonSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateKlaksonIsEnabled(bool? enabled) {
    state = state.copyWith(klaksonIsEnabled: enabled);
  }

  void updateSunVisorSelectedValue(int? value) {
    state = state.copyWith(sunVisorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateSunVisorIsEnabled(bool? enabled) {
    state = state.copyWith(sunVisorIsEnabled: enabled);
  }

  void updateTuasTangkiBensinSelectedValue(int? value) {
    state = state.copyWith(tuasTangkiBensinSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateTuasTangkiBensinIsEnabled(bool? enabled) {
    state = state.copyWith(tuasTangkiBensinIsEnabled: enabled);
  }

  void updateSabukPengamanSelectedValue(int? value) {
    state = state.copyWith(sabukPengamanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateSabukPengamanIsEnabled(bool? enabled) {
    state = state.copyWith(sabukPengamanIsEnabled: enabled);
  }

  void updateTrimInteriorSelectedValue(int? value) {
    state = state.copyWith(trimInteriorSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateTrimInteriorIsEnabled(bool? enabled) {
    state = state.copyWith(trimInteriorIsEnabled: enabled);
  }

  void updatePlafonSelectedValue(int? value) {
    state = state.copyWith(plafonSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePlafonIsEnabled(bool? enabled) {
    state = state.copyWith(plafonIsEnabled: enabled);
  }

  void updateInteriorCatatanList(List<String> lines) {
    state = state.copyWith(interiorCatatanList: lines);
  }

  // New update methods for Page Five Four
  void updateBumperDepanSelectedValue(int? value) {
    state = state.copyWith(bumperDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateBumperDepanIsEnabled(bool? enabled) {
    state = state.copyWith(bumperDepanIsEnabled: enabled);
  }

  void updateKapMesinSelectedValue(int? value) {
    state = state.copyWith(kapMesinSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateKapMesinIsEnabled(bool? enabled) {
    state = state.copyWith(kapMesinIsEnabled: enabled);
  }

  void updateLampuUtamaSelectedValue(int? value) {
    state = state.copyWith(lampuUtamaSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateLampuUtamaIsEnabled(bool? enabled) {
    state = state.copyWith(lampuUtamaIsEnabled: enabled);
  }

  void updatePanelAtapSelectedValue(int? value) {
    state = state.copyWith(panelAtapSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePanelAtapIsEnabled(bool? enabled) {
    state = state.copyWith(panelAtapIsEnabled: enabled);
  }

  void updateGrillSelectedValue(int? value) {
    state = state.copyWith(grillSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateGrillIsEnabled(bool? enabled) {
    state = state.copyWith(grillIsEnabled: enabled);
  }

  void updateLampuFoglampSelectedValue(int? value) {
    state = state.copyWith(lampuFoglampSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateLampuFoglampIsEnabled(bool? enabled) {
    state = state.copyWith(lampuFoglampIsEnabled: enabled);
  }

  void updateKacaBeningSelectedValue(int? value) {
    state = state.copyWith(kacaBeningSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateKacaBeningIsEnabled(bool? enabled) {
    state = state.copyWith(kacaBeningIsEnabled: enabled);
  }

  void updateWiperBelakangSelectedValue(int? value) {
    state = state.copyWith(wiperBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateWiperBelakangIsEnabled(bool? enabled) {
    state = state.copyWith(wiperBelakangIsEnabled: enabled);
  }

  void updateBumperBelakangSelectedValue(int? value) {
    state = state.copyWith(bumperBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateBumperBelakangIsEnabled(bool? enabled) {
    state = state.copyWith(bumperBelakangIsEnabled: enabled);
  }

  void updateLampuBelakangSelectedValue(int? value) {
    state = state.copyWith(lampuBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateLampuBelakangIsEnabled(bool? enabled) {
    state = state.copyWith(lampuBelakangIsEnabled: enabled);
  }

  void updateTrunklidSelectedValue(int? value) {
    state = state.copyWith(trunklidSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateTrunklidIsEnabled(bool? enabled) {
    state = state.copyWith(trunklidIsEnabled: enabled);
  }

  void updateKacaDepanSelectedValue(int? value) {
    state = state.copyWith(kacaDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateKacaDepanIsEnabled(bool? enabled) {
    state = state.copyWith(kacaDepanIsEnabled: enabled);
  }

  void updateFenderKananSelectedValue(int? value) {
    state = state.copyWith(fenderKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateFenderKananIsEnabled(bool? enabled) {
    state = state.copyWith(fenderKananIsEnabled: enabled);
  }

  void updateQuarterPanelKananSelectedValue(int? value) {
    state = state.copyWith(quarterPanelKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateQuarterPanelKananIsEnabled(bool? enabled) {
    state = state.copyWith(quarterPanelKananIsEnabled: enabled);
  }

  void updatePintuBelakangKananSelectedValue(int? value) {
    state = state.copyWith(pintuBelakangKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePintuBelakangKananIsEnabled(bool? enabled) {
    state = state.copyWith(pintuBelakangKananIsEnabled: enabled);
  }

  void updateSpionKananSelectedValue(int? value) {
    state = state.copyWith(spionKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateSpionKananIsEnabled(bool? enabled) {
    state = state.copyWith(spionKananIsEnabled: enabled);
  }

  void updateLisplangKananSelectedValue(int? value) {
    state = state.copyWith(lisplangKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateLisplangKananIsEnabled(bool? enabled) {
    state = state.copyWith(lisplangKananIsEnabled: enabled);
  }

  void updateSideSkirtKananSelectedValue(int? value) {
    state = state.copyWith(sideSkirtKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateSideSkirtKananIsEnabled(bool? enabled) {
    state = state.copyWith(sideSkirtKananIsEnabled: enabled);
  }

  void updateDaunWiperSelectedValue(int? value) {
    state = state.copyWith(daunWiperSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateDaunWiperIsEnabled(bool? enabled) {
    state = state.copyWith(daunWiperIsEnabled: enabled);
  }

  void updatePintuBelakangSelectedValue(int? value) {
    state = state.copyWith(pintuBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePintuBelakangIsEnabled(bool? enabled) {
    state = state.copyWith(pintuBelakangIsEnabled: enabled);
  }

  void updateFenderKiriSelectedValue(int? value) {
    state = state.copyWith(fenderKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateFenderKiriIsEnabled(bool? enabled) {
    state = state.copyWith(fenderKiriIsEnabled: enabled);
  }

  void updateQuarterPanelKiriSelectedValue(int? value) {
    state = state.copyWith(quarterPanelKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateQuarterPanelKiriIsEnabled(bool? enabled) {
    state = state.copyWith(quarterPanelKiriIsEnabled: enabled);
  }

  void updatePintuDepanSelectedValue(int? value) {
    state = state.copyWith(pintuDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePintuDepanIsEnabled(bool? enabled) {
    state = state.copyWith(pintuDepanIsEnabled: enabled);
  }

  void updateKacaJendelaKananSelectedValue(int? value) {
    state = state.copyWith(kacaJendelaKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateKacaJendelaKananIsEnabled(bool? enabled) {
    state = state.copyWith(kacaJendelaKananIsEnabled: enabled);
  }

  void updatePintuBelakangKiriSelectedValue(int? value) {
    state = state.copyWith(pintuBelakangKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePintuBelakangKiriIsEnabled(bool? enabled) {
    state = state.copyWith(pintuBelakangKiriIsEnabled: enabled);
  }

  void updateSpionKiriSelectedValue(int? value) {
    state = state.copyWith(spionKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateSpionKiriIsEnabled(bool? enabled) {
    state = state.copyWith(spionKiriIsEnabled: enabled);
  }

  void updatePintuDepanKiriSelectedValue(int? value) {
    state = state.copyWith(pintuDepanKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePintuDepanKiriIsEnabled(bool? enabled) {
    state = state.copyWith(pintuDepanKiriIsEnabled: enabled);
  }

  void updateKacaJendelaKiriSelectedValue(int? value) {
    state = state.copyWith(kacaJendelaKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateKacaJendelaKiriIsEnabled(bool? enabled) {
    state = state.copyWith(kacaJendelaKiriIsEnabled: enabled);
  }

  void updateLisplangKiriSelectedValue(int? value) {
    state = state.copyWith(lisplangKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateLisplangKiriIsEnabled(bool? enabled) {
    state = state.copyWith(lisplangKiriIsEnabled: enabled);
  }

  void updateSideSkirtKiriSelectedValue(int? value) {
    state = state.copyWith(sideSkirtKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateSideSkirtKiriIsEnabled(bool? enabled) {
    state = state.copyWith(sideSkirtKiriIsEnabled: enabled);
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

  void updateBanDepanIsEnabled(bool? enabled) {
    state = state.copyWith(banDepanIsEnabled: enabled);
  }

  void updateVelgDepanSelectedValue(int? value) {
    state = state.copyWith(velgDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateVelgDepanIsEnabled(bool? enabled) {
    state = state.copyWith(velgDepanIsEnabled: enabled);
  }

  void updateDiscBrakeSelectedValue(int? value) {
    state = state.copyWith(discBrakeSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateDiscBrakeIsEnabled(bool? enabled) {
    state = state.copyWith(discBrakeIsEnabled: enabled);
  }

  void updateMasterRemSelectedValue(int? value) {
    state = state.copyWith(masterRemSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateMasterRemIsEnabled(bool? enabled) {
    state = state.copyWith(masterRemIsEnabled: enabled);
  }

  void updateTieRodSelectedValue(int? value) {
    state = state.copyWith(tieRodSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateTieRodIsEnabled(bool? enabled) {
    state = state.copyWith(tieRodIsEnabled: enabled);
  }

  void updateGardanSelectedValue(int? value) {
    state = state.copyWith(gardanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateGardanIsEnabled(bool? enabled) {
    state = state.copyWith(gardanIsEnabled: enabled);
  }

  void updateBanBelakangSelectedValue(int? value) {
    state = state.copyWith(banBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateBanBelakangIsEnabled(bool? enabled) {
    state = state.copyWith(banBelakangIsEnabled: enabled);
  }

  void updateVelgBelakangSelectedValue(int? value) {
    state = state.copyWith(velgBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateVelgBelakangIsEnabled(bool? enabled) {
    state = state.copyWith(velgBelakangIsEnabled: enabled);
  }

  void updateBrakePadSelectedValue(int? value) {
    state = state.copyWith(brakePadSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateBrakePadIsEnabled(bool? enabled) {
    state = state.copyWith(brakePadIsEnabled: enabled);
  }

  void updateCrossmemberSelectedValue(int? value) {
    state = state.copyWith(crossmemberSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateCrossmemberIsEnabled(bool? enabled) {
    state = state.copyWith(crossmemberIsEnabled: enabled);
  }

  void updateKnalpotSelectedValue(int? value) {
    state = state.copyWith(knalpotSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateKnalpotIsEnabled(bool? enabled) {
    state = state.copyWith(knalpotIsEnabled: enabled);
  }

  void updateBalljointSelectedValue(int? value) {
    state = state.copyWith(balljointSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateBalljointIsEnabled(bool? enabled) {
    state = state.copyWith(balljointIsEnabled: enabled);
  }

  void updateRocksteerSelectedValue(int? value) {
    state = state.copyWith(rocksteerSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateRocksteerIsEnabled(bool? enabled) {
    state = state.copyWith(rocksteerIsEnabled: enabled);
  }

  void updateKaretBootSelectedValue(int? value) {
    state = state.copyWith(karetBootSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateKaretBootIsEnabled(bool? enabled) {
    state = state.copyWith(karetBootIsEnabled: enabled);
  }

  void updateUpperLowerArmSelectedValue(int? value) {
    state = state.copyWith(upperLowerArmSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateUpperLowerArmIsEnabled(bool? enabled) {
    state = state.copyWith(upperLowerArmIsEnabled: enabled);
  }

  void updateShockBreakerSelectedValue(int? value) {
    state = state.copyWith(shockBreakerSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateShockBreakerIsEnabled(bool? enabled) {
    state = state.copyWith(shockBreakerIsEnabled: enabled);
  }

  void updateLinkStabilizerSelectedValue(int? value) {
    state = state.copyWith(linkStabilizerSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateLinkStabilizerIsEnabled(bool? enabled) {
    state = state.copyWith(linkStabilizerIsEnabled: enabled);
  }

  void updateBanDanKakiKakiCatatanList(List<String> lines) {
    state = state.copyWith(banDanKakiKakiCatatanList: lines);
  }

  // New update methods for Page Five Six (Test Drive)
  void updateBunyiGetaranSelectedValue(int? value) {
    state = state.copyWith(bunyiGetaranSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateBunyiGetaranIsEnabled(bool? enabled) {
    state = state.copyWith(bunyiGetaranIsEnabled: enabled);
  }

  void updatePerformaStirSelectedValue(int? value) {
    state = state.copyWith(performaStirSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePerformaStirIsEnabled(bool? enabled) {
    state = state.copyWith(performaStirIsEnabled: enabled);
  }

  void updatePerpindahanTransmisiSelectedValue(int? value) {
    state = state.copyWith(perpindahanTransmisiSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePerpindahanTransmisiIsEnabled(bool? enabled) {
    state = state.copyWith(perpindahanTransmisiIsEnabled: enabled);
  }

  void updateStirBalanceSelectedValue(int? value) {
    state = state.copyWith(stirBalanceSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateStirBalanceIsEnabled(bool? enabled) {
    state = state.copyWith(stirBalanceIsEnabled: enabled);
  }

  void updatePerformaSuspensiSelectedValue(int? value) {
    state = state.copyWith(performaSuspensiSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePerformaSuspensiIsEnabled(bool? enabled) {
    state = state.copyWith(performaSuspensiIsEnabled: enabled);
  }

  void updatePerformaKoplingSelectedValue(int? value) {
    state = state.copyWith(performaKoplingSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updatePerformaKoplingIsEnabled(bool? enabled) {
    state = state.copyWith(performaKoplingIsEnabled: enabled);
  }

  void updateRpmSelectedValue(int? value) {
    state = state.copyWith(rpmSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateRpmIsEnabled(bool? enabled) {
    state = state.copyWith(rpmIsEnabled: enabled);
  }

  void updateTestDriveCatatanList(List<String> lines) {
    state = state.copyWith(testDriveCatatanList: lines);
  }

  // New update methods for Page Five Seven (Tools Test)
  void updateTebalCatBodyDepanSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyDepanSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateTebalCatBodyDepanIsEnabled(bool? enabled) {
    state = state.copyWith(tebalCatBodyDepanIsEnabled: enabled);
  }

  void updateTebalCatBodyKiriSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyKiriSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateTebalCatBodyKiriIsEnabled(bool? enabled) {
    state = state.copyWith(tebalCatBodyKiriIsEnabled: enabled);
  }

  void updateTemperatureAcMobilSelectedValue(int? value) {
    state = state.copyWith(temperatureAcMobilSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateTemperatureAcMobilIsEnabled(bool? enabled) {
    state = state.copyWith(temperatureAcMobilIsEnabled: enabled);
  }

  void updateTebalCatBodyKananSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyKananSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateTebalCatBodyKananIsEnabled(bool? enabled) {
    state = state.copyWith(tebalCatBodyKananIsEnabled: enabled);
  }

  void updateTebalCatBodyBelakangSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyBelakangSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateTebalCatBodyBelakangIsEnabled(bool? enabled) {
    state = state.copyWith(tebalCatBodyBelakangIsEnabled: enabled);
  }

  void updateObdScannerSelectedValue(int? value) {
    state = state.copyWith(obdScannerSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateObdScannerIsEnabled(bool? enabled) {
    state = state.copyWith(obdScannerIsEnabled: enabled);
  }

  void updateTebalCatBodyAtapSelectedValue(int? value) {
    state = state.copyWith(tebalCatBodyAtapSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateTebalCatBodyAtapIsEnabled(bool? enabled) {
    state = state.copyWith(tebalCatBodyAtapIsEnabled: enabled);
  }

  void updateTestAccuSelectedValue(int? value) {
    state = state.copyWith(testAccuSelectedValue: (value == null || value <= 0) ? 0 : value);
  }

  void updateTestAccuIsEnabled(bool? enabled) {
    state = state.copyWith(testAccuIsEnabled: enabled);
  }

  void updateToolsTestCatatanList(List<String> lines) {
    state = state.copyWith(toolsTestCatatanList: lines);
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
    String? bpkp,
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
    bool? airbagIsEnabled,
    int? sistemAudioSelectedValue,
    bool? sistemAudioIsEnabled,
    int? powerWindowSelectedValue,
    bool? powerWindowIsEnabled,
    int? sistemAcSelectedValue,
    bool? sistemAcIsEnabled,
    List<String>? fiturCatatanList,
    int? getaranMesinSelectedValue,
    bool? getaranMesinIsEnabled,
    int? suaraMesinSelectedValue,
    bool? suaraMesinIsEnabled,
    int? transmisiSelectedValue,
    bool? transmisiIsEnabled,
    int? pompaPowerSteeringSelectedValue,
    bool? pompaPowerSteeringIsEnabled,
    int? coverTimingChainSelectedValue,
    bool? coverTimingChainIsEnabled,
    int? oliPowerSteeringSelectedValue,
    bool? oliPowerSteeringIsEnabled,
    int? accuSelectedValue,
    bool? accuIsEnabled,
    int? kompressorAcSelectedValue,
    bool? kompressorAcIsEnabled,
    int? fanSelectedValue,
    bool? fanIsEnabled,
    int? selangSelectedValue,
    bool? selangIsEnabled,
    int? karterOliSelectedValue,
    bool? karterOliIsEnabled,
    int? oilRemSelectedValue,
    bool? oilRemIsEnabled,
    int? kabelSelectedValue,
    bool? kabelIsEnabled,
    int? kondensorSelectedValue,
    bool? kondensorIsEnabled,
    int? radiatorSelectedValue,
    bool? radiatorIsEnabled,
    int? cylinderHeadSelectedValue,
    bool? cylinderHeadIsEnabled,
    int? oliMesinSelectedValue,
    bool? oliMesinIsEnabled,
    int? airRadiatorSelectedValue,
    bool? airRadiatorIsEnabled,
    int? coverKlepSelectedValue,
    bool? coverKlepIsEnabled,
    int? alternatorSelectedValue,
    bool? alternatorIsEnabled,
    int? waterPumpSelectedValue,
    bool? waterPumpIsEnabled,
    int? beltSelectedValue,
    bool? beltIsEnabled,
    int? oliTransmisiSelectedValue,
    bool? oliTransmisiIsEnabled,
    int? cylinderBlockSelectedValue,
    bool? cylinderBlockIsEnabled,
    int? bushingBesarSelectedValue,
    bool? bushingBesarIsEnabled,
    int? bushingKecilSelectedValue,
    bool? bushingKecilIsEnabled,
    int? tutupRadiatorSelectedValue,
    bool? tutupRadiatorIsEnabled,
    List<String>? mesinCatatanList,
    int? stirSelectedValue,
    bool? stirIsEnabled,
    int? remTonganSelectedValue,
    bool? remTonganIsEnabled,
    int? pedalSelectedValue,
    bool? pedalIsEnabled,
    int? switchWiperSelectedValue,
    bool? switchWiperIsEnabled,
    int? lampuHazardSelectedValue,
    bool? lampuHazardIsEnabled,
    int? panelDashboardSelectedValue,
    bool? panelDashboardIsEnabled,
    int? pembukaKapMesinSelectedValue,
    bool? pembukaKapMesinIsEnabled,
    int? pembukaBagasiSelectedValue,
    bool? pembukaBagasiIsEnabled,
    int? jokDepanSelectedValue,
    bool? jokDepanIsEnabled,
    int? aromaInteriorSelectedValue,
    bool? aromaInteriorIsEnabled,
    int? handlePintuSelectedValue,
    bool? handlePintuIsEnabled,
    int? consoleBoxSelectedValue,
    bool? consoleBoxIsEnabled,
    int? spionTengahSelectedValue,
    bool? spionTengahIsEnabled,
    int? tuasPersnelingSelectedValue,
    bool? tuasPersnelingIsEnabled,
    int? jokBelakangSelectedValue,
    bool? jokBelakangIsEnabled,
    int? panelIndikatorSelectedValue,
    bool? panelIndikatorIsEnabled,
    int? switchLampuSelectedValue,
    bool? switchLampuIsEnabled,
    int? karpetDasarSelectedValue,
    bool? karpetDasarIsEnabled,
    int? klaksonSelectedValue,
    bool? klaksonIsEnabled,
    int? sunVisorSelectedValue,
    bool? sunVisorIsEnabled,
    int? tuasTangkiBensinSelectedValue,
    bool? tuasTangkiBensinIsEnabled,
    int? sabukPengamanSelectedValue,
    bool? sabukPengamanIsEnabled,
    int? trimInteriorSelectedValue,
    bool? trimInteriorIsEnabled,
    int? plafonSelectedValue,
    bool? plafonIsEnabled,
    List<String>? interiorCatatanList,
    int? bumperDepanSelectedValue,
    bool? bumperDepanIsEnabled,
    int? kapMesinSelectedValue,
    bool? kapMesinIsEnabled,
    int? lampuUtamaSelectedValue,
    bool? lampuUtamaIsEnabled,
    int? panelAtapSelectedValue,
    bool? panelAtapIsEnabled,
    int? grillSelectedValue,
    bool? grillIsEnabled,
    int? lampuFoglampSelectedValue,
    bool? lampuFoglampIsEnabled,
    int? kacaBeningSelectedValue,
    bool? kacaBeningIsEnabled,
    int? wiperBelakangSelectedValue,
    bool? wiperBelakangIsEnabled,
    int? bumperBelakangSelectedValue,
    bool? bumperBelakangIsEnabled,
    int? lampuBelakangSelectedValue,
    bool? lampuBelakangIsEnabled,
    int? trunklidSelectedValue,
    bool? trunklidIsEnabled,
    int? kacaDepanSelectedValue,
    bool? kacaDepanIsEnabled,
    int? fenderKananSelectedValue,
    bool? fenderKananIsEnabled,
    int? quarterPanelKananSelectedValue,
    bool? quarterPanelKananIsEnabled,
    int? pintuBelakangKananSelectedValue,
    bool? pintuBelakangKananIsEnabled,
    int? spionKananSelectedValue,
    bool? spionKananIsEnabled,
    int? lisplangKananSelectedValue,
    bool? lisplangKananIsEnabled,
    int? sideSkirtKananSelectedValue,
    bool? sideSkirtKananIsEnabled,
    int? daunWiperSelectedValue,
    bool? daunWiperIsEnabled,
    int? pintuBelakangSelectedValue,
    bool? pintuBelakangIsEnabled,
    int? fenderKiriSelectedValue,
    bool? fenderKiriIsEnabled,
    int? quarterPanelKiriSelectedValue,
    bool? quarterPanelKiriIsEnabled,
    int? pintuDepanSelectedValue,
    bool? pintuDepanIsEnabled,
    int? kacaJendelaKananSelectedValue,
    bool? kacaJendelaKananIsEnabled,
    int? pintuBelakangKiriSelectedValue,
    bool? pintuBelakangKiriIsEnabled,
    int? spionKiriSelectedValue,
    bool? spionKiriIsEnabled,
    int? pintuDepanKiriSelectedValue,
    bool? pintuDepanKiriIsEnabled,
    int? kacaJendelaKiriSelectedValue,
    bool? kacaJendelaKiriIsEnabled,
    int? lisplangKiriSelectedValue,
    bool? lisplangKiriIsEnabled,
    int? sideSkirtKiriSelectedValue,
    bool? sideSkirtKiriIsEnabled,
    List<String>? eksteriorCatatanList,
    int? banDepanSelectedValue,
    bool? banDepanIsEnabled,
    int? velgDepanSelectedValue,
    bool? velgDepanIsEnabled,
    int? discBrakeSelectedValue,
    bool? discBrakeIsEnabled,
    int? masterRemSelectedValue,
    bool? masterRemIsEnabled,
    int? tieRodSelectedValue,
    bool? tieRodIsEnabled,
    int? gardanSelectedValue,
    bool? gardanIsEnabled,
    int? banBelakangSelectedValue,
    bool? banBelakangIsEnabled,
    int? velgBelakangSelectedValue,
    bool? velgBelakangIsEnabled,
    int? brakePadSelectedValue,
    bool? brakePadIsEnabled,
    int? crossmemberSelectedValue,
    bool? crossmemberIsEnabled,
    int? knalpotSelectedValue,
    bool? knalpotIsEnabled,
    int? balljointSelectedValue,
    bool? balljointIsEnabled,
    int? rocksteerSelectedValue,
    bool? rocksteerIsEnabled,
    int? karetBootSelectedValue,
    bool? karetBootIsEnabled,
    int? upperLowerArmSelectedValue,
    bool? upperLowerArmIsEnabled,
    int? shockBreakerSelectedValue,
    bool? shockBreakerIsEnabled,
    int? linkStabilizerSelectedValue,
    bool? linkStabilizerIsEnabled,
    List<String>? banDanKakiKakiCatatanList,
    int? bunyiGetaranSelectedValue,
    bool? bunyiGetaranIsEnabled,
    int? performaStirSelectedValue,
    bool? performaStirIsEnabled,
    int? perpindahanTransmisiSelectedValue,
    bool? perpindahanTransmisiIsEnabled,
    int? stirBalanceSelectedValue,
    bool? stirBalanceIsEnabled,
    int? performaSuspensiSelectedValue,
    bool? performaSuspensiIsEnabled,
    int? performaKoplingSelectedValue,
    bool? performaKoplingIsEnabled,
    int? rpmSelectedValue,
    bool? rpmIsEnabled,
    List<String>? testDriveCatatanList,
    int? tebalCatBodyDepanSelectedValue,
    bool? tebalCatBodyDepanIsEnabled,
    int? tebalCatBodyKiriSelectedValue,
    bool? tebalCatBodyKiriIsEnabled,
    int? temperatureAcMobilSelectedValue,
    bool? temperatureAcMobilIsEnabled,
    int? tebalCatBodyKananSelectedValue,
    bool? tebalCatBodyKananIsEnabled,
    int? tebalCatBodyBelakangSelectedValue,
    bool? tebalCatBodyBelakangIsEnabled,
    int? obdScannerSelectedValue,
    bool? obdScannerIsEnabled,
    int? tebalCatBodyAtapSelectedValue,
    bool? tebalCatBodyAtapIsEnabled,
    int? testAccuSelectedValue,
    bool? testAccuIsEnabled,
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
      bpkp: bpkp ?? this.bpkp,
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
      airbagIsEnabled: airbagIsEnabled ?? this.airbagIsEnabled,
      sistemAudioSelectedValue: sistemAudioSelectedValue ?? this.sistemAudioSelectedValue,
      sistemAudioIsEnabled: sistemAudioIsEnabled ?? this.sistemAudioIsEnabled,
      powerWindowSelectedValue: powerWindowSelectedValue ?? this.powerWindowSelectedValue,
      powerWindowIsEnabled: powerWindowIsEnabled ?? this.powerWindowIsEnabled,
      sistemAcSelectedValue: sistemAcSelectedValue ?? this.sistemAcSelectedValue,
      sistemAcIsEnabled: sistemAcIsEnabled ?? this.sistemAcIsEnabled,
      fiturCatatanList: fiturCatatanList ?? this.fiturCatatanList,
      getaranMesinSelectedValue: getaranMesinSelectedValue ?? this.getaranMesinSelectedValue,
      getaranMesinIsEnabled: getaranMesinIsEnabled ?? this.getaranMesinIsEnabled,
      suaraMesinSelectedValue: suaraMesinSelectedValue ?? this.suaraMesinSelectedValue,
      suaraMesinIsEnabled: suaraMesinIsEnabled ?? this.suaraMesinIsEnabled,
      transmisiSelectedValue: transmisiSelectedValue ?? this.transmisiSelectedValue,
      transmisiIsEnabled: transmisiIsEnabled ?? this.transmisiIsEnabled,
      pompaPowerSteeringSelectedValue: pompaPowerSteeringSelectedValue ?? this.pompaPowerSteeringSelectedValue,
      pompaPowerSteeringIsEnabled: pompaPowerSteeringIsEnabled ?? this.pompaPowerSteeringIsEnabled,
      coverTimingChainSelectedValue: coverTimingChainSelectedValue ?? this.coverTimingChainSelectedValue,
      coverTimingChainIsEnabled: coverTimingChainIsEnabled ?? this.coverTimingChainIsEnabled,
      oliPowerSteeringSelectedValue: oliPowerSteeringSelectedValue ?? this.oliPowerSteeringSelectedValue,
      oliPowerSteeringIsEnabled: oliPowerSteeringIsEnabled ?? this.oliPowerSteeringIsEnabled,
      accuSelectedValue: accuSelectedValue ?? this.accuSelectedValue,
      accuIsEnabled: accuIsEnabled ?? this.accuIsEnabled,
      kompressorAcSelectedValue: kompressorAcSelectedValue ?? this.kompressorAcSelectedValue,
      kompressorAcIsEnabled: kompressorAcIsEnabled ?? this.kompressorAcIsEnabled,
      fanSelectedValue: fanSelectedValue ?? this.fanSelectedValue,
      fanIsEnabled: fanIsEnabled ?? this.fanIsEnabled,
      selangSelectedValue: selangSelectedValue ?? this.selangSelectedValue,
      selangIsEnabled: selangIsEnabled ?? this.selangIsEnabled,
      karterOliSelectedValue: karterOliSelectedValue ?? this.karterOliSelectedValue,
      karterOliIsEnabled: karterOliIsEnabled ?? this.karterOliIsEnabled,
      oilRemSelectedValue: oilRemSelectedValue ?? this.oilRemSelectedValue,
      oilRemIsEnabled: oilRemIsEnabled ?? this.oilRemIsEnabled,
      kabelSelectedValue: kabelSelectedValue ?? this.kabelSelectedValue,
      kabelIsEnabled: kabelIsEnabled ?? this.kabelIsEnabled,
      kondensorSelectedValue: kondensorSelectedValue ?? this.kondensorSelectedValue,
      kondensorIsEnabled: kondensorIsEnabled ?? this.kondensorIsEnabled,
      radiatorSelectedValue: radiatorSelectedValue ?? this.radiatorSelectedValue,
      radiatorIsEnabled: radiatorIsEnabled ?? this.radiatorIsEnabled,
      cylinderHeadSelectedValue: cylinderHeadSelectedValue ?? this.cylinderHeadSelectedValue,
      cylinderHeadIsEnabled: cylinderHeadIsEnabled ?? this.cylinderHeadIsEnabled,
      oliMesinSelectedValue: oliMesinSelectedValue ?? this.oliMesinSelectedValue,
      oliMesinIsEnabled: oliMesinIsEnabled ?? this.oliMesinIsEnabled,
      airRadiatorSelectedValue: airRadiatorSelectedValue ?? this.airRadiatorSelectedValue,
      airRadiatorIsEnabled: airRadiatorIsEnabled ?? this.airRadiatorIsEnabled,
      coverKlepSelectedValue: coverKlepSelectedValue ?? this.coverKlepSelectedValue,
      coverKlepIsEnabled: coverKlepIsEnabled ?? this.coverKlepIsEnabled,
      alternatorSelectedValue: alternatorSelectedValue ?? this.alternatorSelectedValue,
      alternatorIsEnabled: alternatorIsEnabled ?? this.alternatorIsEnabled,
      waterPumpSelectedValue: waterPumpSelectedValue ?? this.waterPumpSelectedValue,
      waterPumpIsEnabled: waterPumpIsEnabled ?? this.waterPumpIsEnabled,
      beltSelectedValue: beltSelectedValue ?? this.beltSelectedValue,
      beltIsEnabled: beltIsEnabled ?? this.beltIsEnabled,
      oliTransmisiSelectedValue: oliTransmisiSelectedValue ?? this.oliTransmisiSelectedValue,
      oliTransmisiIsEnabled: oliTransmisiIsEnabled ?? this.oliTransmisiIsEnabled,
      cylinderBlockSelectedValue: cylinderBlockSelectedValue ?? this.cylinderBlockSelectedValue,
      cylinderBlockIsEnabled: cylinderBlockIsEnabled ?? this.cylinderBlockIsEnabled,
      bushingBesarSelectedValue: bushingBesarSelectedValue ?? this.bushingBesarSelectedValue,
      bushingBesarIsEnabled: bushingBesarIsEnabled ?? this.bushingBesarIsEnabled,
      bushingKecilSelectedValue: bushingKecilSelectedValue ?? this.bushingKecilSelectedValue,
      bushingKecilIsEnabled: bushingKecilIsEnabled ?? this.bushingKecilIsEnabled,
      tutupRadiatorSelectedValue: tutupRadiatorSelectedValue ?? this.tutupRadiatorSelectedValue,
      tutupRadiatorIsEnabled: tutupRadiatorIsEnabled ?? this.tutupRadiatorIsEnabled,
      mesinCatatanList: mesinCatatanList ?? this.mesinCatatanList,
      stirSelectedValue: stirSelectedValue ?? this.stirSelectedValue,
      stirIsEnabled: stirIsEnabled ?? this.stirIsEnabled,
      remTonganSelectedValue: remTonganSelectedValue ?? this.remTonganSelectedValue,
      remTonganIsEnabled: remTonganIsEnabled ?? this.remTonganIsEnabled,
      pedalSelectedValue: pedalSelectedValue ?? this.pedalSelectedValue,
      pedalIsEnabled: pedalIsEnabled ?? this.pedalIsEnabled,
      switchWiperSelectedValue: switchWiperSelectedValue ?? this.switchWiperSelectedValue,
      switchWiperIsEnabled: switchWiperIsEnabled ?? this.switchWiperIsEnabled,
      lampuHazardSelectedValue: lampuHazardSelectedValue ?? this.lampuHazardSelectedValue,
      lampuHazardIsEnabled: lampuHazardIsEnabled ?? this.lampuHazardIsEnabled,
      panelDashboardSelectedValue: panelDashboardSelectedValue ?? this.panelDashboardSelectedValue,
      panelDashboardIsEnabled: panelDashboardIsEnabled ?? this.panelDashboardIsEnabled,
      pembukaKapMesinSelectedValue: pembukaKapMesinSelectedValue ?? this.pembukaKapMesinSelectedValue,
      pembukaKapMesinIsEnabled: pembukaKapMesinIsEnabled ?? this.pembukaKapMesinIsEnabled,
      pembukaBagasiSelectedValue: pembukaBagasiSelectedValue ?? this.pembukaBagasiSelectedValue,
      pembukaBagasiIsEnabled: pembukaBagasiIsEnabled ?? this.pembukaBagasiIsEnabled,
      jokDepanSelectedValue: jokDepanSelectedValue ?? this.jokDepanSelectedValue,
      jokDepanIsEnabled: jokDepanIsEnabled ?? this.jokDepanIsEnabled,
      aromaInteriorSelectedValue: aromaInteriorSelectedValue ?? this.aromaInteriorSelectedValue,
      aromaInteriorIsEnabled: aromaInteriorIsEnabled ?? this.aromaInteriorIsEnabled,
      handlePintuSelectedValue: handlePintuSelectedValue ?? this.handlePintuSelectedValue,
      handlePintuIsEnabled: handlePintuIsEnabled ?? this.handlePintuIsEnabled,
      consoleBoxSelectedValue: consoleBoxSelectedValue ?? this.consoleBoxSelectedValue,
      consoleBoxIsEnabled: consoleBoxIsEnabled ?? this.consoleBoxIsEnabled,
      spionTengahSelectedValue: spionTengahSelectedValue ?? this.spionTengahSelectedValue,
      spionTengahIsEnabled: spionTengahIsEnabled ?? this.spionTengahIsEnabled,
      tuasPersnelingSelectedValue: tuasPersnelingSelectedValue ?? this.tuasPersnelingSelectedValue,
      tuasPersnelingIsEnabled: tuasPersnelingIsEnabled ?? this.tuasPersnelingIsEnabled,
      jokBelakangSelectedValue: jokBelakangSelectedValue ?? this.jokBelakangSelectedValue,
      jokBelakangIsEnabled: jokBelakangIsEnabled ?? this.jokBelakangIsEnabled,
      panelIndikatorSelectedValue: panelIndikatorSelectedValue ?? this.panelIndikatorSelectedValue,
      panelIndikatorIsEnabled: panelIndikatorIsEnabled ?? this.panelIndikatorIsEnabled,
      switchLampuSelectedValue: switchLampuSelectedValue ?? this.switchLampuSelectedValue,
      switchLampuIsEnabled: switchLampuIsEnabled ?? this.switchLampuIsEnabled,
      karpetDasarSelectedValue: karpetDasarSelectedValue ?? this.karpetDasarSelectedValue,
      karpetDasarIsEnabled: karpetDasarIsEnabled ?? this.karpetDasarIsEnabled,
      klaksonSelectedValue: klaksonSelectedValue ?? this.klaksonSelectedValue,
      klaksonIsEnabled: klaksonIsEnabled ?? this.klaksonIsEnabled,
      sunVisorSelectedValue: sunVisorSelectedValue ?? this.sunVisorSelectedValue,
      sunVisorIsEnabled: sunVisorIsEnabled ?? this.sunVisorIsEnabled,
      tuasTangkiBensinSelectedValue: tuasTangkiBensinSelectedValue ?? this.tuasTangkiBensinSelectedValue,
      tuasTangkiBensinIsEnabled: tuasTangkiBensinIsEnabled ?? this.tuasTangkiBensinIsEnabled,
      sabukPengamanSelectedValue: sabukPengamanSelectedValue ?? this.sabukPengamanSelectedValue,
      sabukPengamanIsEnabled: sabukPengamanIsEnabled ?? this.sabukPengamanIsEnabled,
      trimInteriorSelectedValue: trimInteriorSelectedValue ?? this.trimInteriorSelectedValue,
      trimInteriorIsEnabled: trimInteriorIsEnabled ?? this.trimInteriorIsEnabled,
      plafonSelectedValue: plafonSelectedValue ?? this.plafonSelectedValue,
      plafonIsEnabled: plafonIsEnabled ?? this.plafonIsEnabled,
      interiorCatatanList: interiorCatatanList ?? this.interiorCatatanList,
      bumperDepanSelectedValue: bumperDepanSelectedValue ?? this.bumperDepanSelectedValue,
      bumperDepanIsEnabled: bumperDepanIsEnabled ?? this.bumperDepanIsEnabled,
      kapMesinSelectedValue: kapMesinSelectedValue ?? this.kapMesinSelectedValue,
      kapMesinIsEnabled: kapMesinIsEnabled ?? this.kapMesinIsEnabled,
      lampuUtamaSelectedValue: lampuUtamaSelectedValue ?? this.lampuUtamaSelectedValue,
      lampuUtamaIsEnabled: lampuUtamaIsEnabled ?? this.lampuUtamaIsEnabled,
      panelAtapSelectedValue: panelAtapSelectedValue ?? this.panelAtapSelectedValue,
      panelAtapIsEnabled: panelAtapIsEnabled ?? this.panelAtapIsEnabled,
      grillSelectedValue: grillSelectedValue ?? this.grillSelectedValue,
      grillIsEnabled: grillIsEnabled ?? this.grillIsEnabled,
      lampuFoglampSelectedValue: lampuFoglampSelectedValue ?? this.lampuFoglampSelectedValue,
      lampuFoglampIsEnabled: lampuFoglampIsEnabled ?? this.lampuFoglampIsEnabled,
      kacaBeningSelectedValue: kacaBeningSelectedValue ?? this.kacaBeningSelectedValue,
      kacaBeningIsEnabled: kacaBeningIsEnabled ?? this.kacaBeningIsEnabled,
      wiperBelakangSelectedValue: wiperBelakangSelectedValue ?? this.wiperBelakangSelectedValue,
      wiperBelakangIsEnabled: wiperBelakangIsEnabled ?? this.wiperBelakangIsEnabled,
      bumperBelakangSelectedValue: bumperBelakangSelectedValue ?? this.bumperBelakangSelectedValue,
      bumperBelakangIsEnabled: bumperBelakangIsEnabled ?? this.bumperBelakangIsEnabled,
      lampuBelakangSelectedValue: lampuBelakangSelectedValue ?? this.lampuBelakangSelectedValue,
      lampuBelakangIsEnabled: lampuBelakangIsEnabled ?? this.lampuBelakangIsEnabled,
      trunklidSelectedValue: trunklidSelectedValue ?? this.trunklidSelectedValue,
      trunklidIsEnabled: trunklidIsEnabled ?? this.trunklidIsEnabled,
      kacaDepanSelectedValue: kacaDepanSelectedValue ?? this.kacaDepanSelectedValue,
      kacaDepanIsEnabled: kacaDepanIsEnabled ?? this.kacaDepanIsEnabled,
      fenderKananSelectedValue: fenderKananSelectedValue ?? this.fenderKananSelectedValue,
      fenderKananIsEnabled: fenderKananIsEnabled ?? this.fenderKananIsEnabled,
      quarterPanelKananSelectedValue: quarterPanelKananSelectedValue ?? this.quarterPanelKananSelectedValue,
      quarterPanelKananIsEnabled: quarterPanelKananIsEnabled ?? this.quarterPanelKananIsEnabled,
      pintuBelakangKananSelectedValue: pintuBelakangKananSelectedValue ?? this.pintuBelakangKananSelectedValue,
      pintuBelakangKananIsEnabled: pintuBelakangKananIsEnabled ?? this.pintuBelakangKananIsEnabled,
      spionKananSelectedValue: spionKananSelectedValue ?? this.spionKananSelectedValue,
      spionKananIsEnabled: spionKananIsEnabled ?? this.spionKananIsEnabled,
      lisplangKananSelectedValue: lisplangKananSelectedValue ?? this.lisplangKananSelectedValue,
      lisplangKananIsEnabled: lisplangKananIsEnabled ?? this.lisplangKananIsEnabled,
      sideSkirtKananSelectedValue: sideSkirtKananSelectedValue ?? this.sideSkirtKananSelectedValue,
      sideSkirtKananIsEnabled: sideSkirtKananIsEnabled ?? this.sideSkirtKananIsEnabled,
      daunWiperSelectedValue: daunWiperSelectedValue ?? this.daunWiperSelectedValue,
      daunWiperIsEnabled: daunWiperIsEnabled ?? this.daunWiperIsEnabled,
      pintuBelakangSelectedValue: pintuBelakangSelectedValue ?? this.pintuBelakangSelectedValue,
      pintuBelakangIsEnabled: pintuBelakangIsEnabled ?? this.pintuBelakangIsEnabled,
      fenderKiriSelectedValue: fenderKiriSelectedValue ?? this.fenderKiriSelectedValue,
      fenderKiriIsEnabled: fenderKiriIsEnabled ?? this.fenderKiriIsEnabled,
      quarterPanelKiriSelectedValue: quarterPanelKiriSelectedValue ?? this.quarterPanelKiriSelectedValue,
      quarterPanelKiriIsEnabled: quarterPanelKiriIsEnabled ?? this.quarterPanelKiriIsEnabled,
      pintuDepanSelectedValue: pintuDepanSelectedValue ?? this.pintuDepanSelectedValue,
      pintuDepanIsEnabled: pintuDepanIsEnabled ?? this.pintuDepanIsEnabled,
      kacaJendelaKananSelectedValue: kacaJendelaKananSelectedValue ?? this.kacaJendelaKananSelectedValue,
      kacaJendelaKananIsEnabled: kacaJendelaKananIsEnabled ?? this.kacaJendelaKananIsEnabled,
      pintuBelakangKiriSelectedValue: pintuBelakangKiriSelectedValue ?? this.pintuBelakangKiriSelectedValue,
      pintuBelakangKiriIsEnabled: pintuBelakangKiriIsEnabled ?? this.pintuBelakangKiriIsEnabled,
      spionKiriSelectedValue: spionKiriSelectedValue ?? this.spionKiriSelectedValue,
      spionKiriIsEnabled: spionKiriIsEnabled ?? this.spionKiriIsEnabled,
      pintuDepanKiriSelectedValue: pintuDepanKiriSelectedValue ?? this.pintuDepanKiriSelectedValue,
      pintuDepanKiriIsEnabled: pintuDepanKiriIsEnabled ?? this.pintuDepanKiriIsEnabled,
      kacaJendelaKiriSelectedValue: kacaJendelaKiriSelectedValue ?? this.kacaJendelaKiriSelectedValue,
      kacaJendelaKiriIsEnabled: kacaJendelaKiriIsEnabled ?? this.kacaJendelaKiriIsEnabled,
      lisplangKiriSelectedValue: lisplangKiriSelectedValue ?? this.lisplangKiriSelectedValue,
      lisplangKiriIsEnabled: lisplangKiriIsEnabled ?? this.lisplangKiriIsEnabled,
      sideSkirtKiriSelectedValue: sideSkirtKiriSelectedValue ?? this.sideSkirtKiriSelectedValue,
      sideSkirtKiriIsEnabled: sideSkirtKiriIsEnabled ?? this.sideSkirtKiriIsEnabled,
      eksteriorCatatanList: eksteriorCatatanList ?? this.eksteriorCatatanList,
      banDepanSelectedValue: banDepanSelectedValue ?? this.banDepanSelectedValue,
      banDepanIsEnabled: banDepanIsEnabled ?? this.banDepanIsEnabled,
      velgDepanSelectedValue: velgDepanSelectedValue ?? this.velgDepanSelectedValue,
      velgDepanIsEnabled: velgDepanIsEnabled ?? this.velgDepanIsEnabled,
      discBrakeSelectedValue: discBrakeSelectedValue ?? this.discBrakeSelectedValue,
      discBrakeIsEnabled: discBrakeIsEnabled ?? this.discBrakeIsEnabled,
      masterRemSelectedValue: masterRemSelectedValue ?? this.masterRemSelectedValue,
      masterRemIsEnabled: masterRemIsEnabled ?? this.masterRemIsEnabled,
      tieRodSelectedValue: tieRodSelectedValue ?? this.tieRodSelectedValue,
      tieRodIsEnabled: tieRodIsEnabled ?? this.tieRodIsEnabled,
      gardanSelectedValue: gardanSelectedValue ?? this.gardanSelectedValue,
      gardanIsEnabled: gardanIsEnabled ?? this.gardanIsEnabled,
      banBelakangSelectedValue: banBelakangSelectedValue ?? this.banBelakangSelectedValue,
      banBelakangIsEnabled: banBelakangIsEnabled ?? this.banBelakangIsEnabled,
      velgBelakangSelectedValue: velgBelakangSelectedValue ?? this.velgBelakangSelectedValue,
      velgBelakangIsEnabled: velgBelakangIsEnabled ?? this.velgBelakangIsEnabled,
      brakePadSelectedValue: brakePadSelectedValue ?? this.brakePadSelectedValue,
      brakePadIsEnabled: brakePadIsEnabled ?? this.brakePadIsEnabled,
      crossmemberSelectedValue: crossmemberSelectedValue ?? this.crossmemberSelectedValue,
      crossmemberIsEnabled: crossmemberIsEnabled ?? this.crossmemberIsEnabled,
      knalpotSelectedValue: knalpotSelectedValue ?? this.knalpotSelectedValue,
      knalpotIsEnabled: knalpotIsEnabled ?? this.knalpotIsEnabled,
      balljointSelectedValue: balljointSelectedValue ?? this.balljointSelectedValue,
      balljointIsEnabled: balljointIsEnabled ?? this.balljointIsEnabled,
      rocksteerSelectedValue: rocksteerSelectedValue ?? this.rocksteerSelectedValue,
      rocksteerIsEnabled: rocksteerIsEnabled ?? this.rocksteerIsEnabled,
      karetBootSelectedValue: karetBootSelectedValue ?? this.karetBootSelectedValue,
      karetBootIsEnabled: karetBootIsEnabled ?? this.karetBootIsEnabled,
      upperLowerArmSelectedValue: upperLowerArmSelectedValue ?? this.upperLowerArmSelectedValue,
      upperLowerArmIsEnabled: upperLowerArmIsEnabled ?? this.upperLowerArmIsEnabled,
      shockBreakerSelectedValue: shockBreakerSelectedValue ?? this.shockBreakerSelectedValue,
      shockBreakerIsEnabled: shockBreakerIsEnabled ?? this.shockBreakerIsEnabled,
      linkStabilizerSelectedValue: linkStabilizerSelectedValue ?? this.linkStabilizerSelectedValue,
      linkStabilizerIsEnabled: linkStabilizerIsEnabled ?? this.linkStabilizerIsEnabled,
      banDanKakiKakiCatatanList: banDanKakiKakiCatatanList ?? this.banDanKakiKakiCatatanList,
      bunyiGetaranSelectedValue: bunyiGetaranSelectedValue ?? this.bunyiGetaranSelectedValue,
      bunyiGetaranIsEnabled: bunyiGetaranIsEnabled ?? this.bunyiGetaranIsEnabled,
      performaStirSelectedValue: performaStirSelectedValue ?? this.performaStirSelectedValue,
      performaStirIsEnabled: performaStirIsEnabled ?? this.performaStirIsEnabled,
      perpindahanTransmisiSelectedValue: perpindahanTransmisiSelectedValue ?? this.perpindahanTransmisiSelectedValue,
      perpindahanTransmisiIsEnabled: perpindahanTransmisiIsEnabled ?? this.perpindahanTransmisiIsEnabled,
      stirBalanceSelectedValue: stirBalanceSelectedValue ?? this.stirBalanceSelectedValue,
      stirBalanceIsEnabled: stirBalanceIsEnabled ?? this.stirBalanceIsEnabled,
      performaSuspensiSelectedValue: performaSuspensiSelectedValue ?? this.performaSuspensiSelectedValue,
      performaSuspensiIsEnabled: performaSuspensiIsEnabled ?? this.performaSuspensiIsEnabled,
      performaKoplingSelectedValue: performaKoplingSelectedValue ?? this.performaKoplingSelectedValue,
      performaKoplingIsEnabled: performaKoplingIsEnabled ?? this.performaKoplingIsEnabled,
      rpmSelectedValue: rpmSelectedValue ?? this.rpmSelectedValue,
      rpmIsEnabled: rpmIsEnabled ?? this.rpmIsEnabled,
      testDriveCatatanList: testDriveCatatanList ?? this.testDriveCatatanList,
      // New fields for Page Five Seven (Tools Test)
      tebalCatBodyDepanSelectedValue: tebalCatBodyDepanSelectedValue ?? this.tebalCatBodyDepanSelectedValue,
      tebalCatBodyDepanIsEnabled: tebalCatBodyDepanIsEnabled ?? this.tebalCatBodyDepanIsEnabled,
      tebalCatBodyKiriSelectedValue: tebalCatBodyKiriSelectedValue ?? this.tebalCatBodyKiriSelectedValue,
      tebalCatBodyKiriIsEnabled: tebalCatBodyKiriIsEnabled ?? this.tebalCatBodyKiriIsEnabled,
      temperatureAcMobilSelectedValue: temperatureAcMobilSelectedValue ?? this.temperatureAcMobilSelectedValue,
      temperatureAcMobilIsEnabled: temperatureAcMobilIsEnabled ?? this.temperatureAcMobilIsEnabled,
      tebalCatBodyKananSelectedValue: tebalCatBodyKananSelectedValue ?? this.tebalCatBodyKananSelectedValue,
      tebalCatBodyKananIsEnabled: tebalCatBodyKananIsEnabled ?? this.tebalCatBodyKananIsEnabled,
      tebalCatBodyBelakangSelectedValue: tebalCatBodyBelakangSelectedValue ?? this.tebalCatBodyBelakangSelectedValue,
      tebalCatBodyBelakangIsEnabled: tebalCatBodyBelakangIsEnabled ?? this.tebalCatBodyBelakangIsEnabled,
      obdScannerSelectedValue: obdScannerSelectedValue ?? this.obdScannerSelectedValue,
      obdScannerIsEnabled: obdScannerIsEnabled ?? this.obdScannerIsEnabled,
      tebalCatBodyAtapSelectedValue: tebalCatBodyAtapSelectedValue ?? this.tebalCatBodyAtapSelectedValue,
      tebalCatBodyAtapIsEnabled: tebalCatBodyAtapIsEnabled ?? this.tebalCatBodyAtapIsEnabled,
      testAccuSelectedValue: testAccuSelectedValue ?? this.testAccuSelectedValue,
      testAccuIsEnabled: testAccuIsEnabled ?? this.testAccuIsEnabled,
      toolsTestCatatanList: toolsTestCatatanList ?? this.toolsTestCatatanList,
    );
  }
}
