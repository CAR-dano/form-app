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
  void updateInteriorSelectedIndex(int index) {
    state = state.copyWith(interiorSelectedIndex: index);
  }

  void updateEksteriorSelectedIndex(int index) {
    state = state.copyWith(eksteriorSelectedIndex: index);
  }

  void updateKakiKakiSelectedIndex(int index) {
    state = state.copyWith(kakiKakiSelectedIndex: index);
  }

  void updateMesinSelectedIndex(int index) {
    state = state.copyWith(mesinSelectedIndex: index);
  }

  void updatePenilaianKeseluruhanSelectedIndex(int index) {
    state = state.copyWith(penilaianKeseluruhanSelectedIndex: index);
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
  void updateAirbagSelectedIndex(int? index) {
    state = state.copyWith(airbagSelectedIndex: index);
  }

  void updateAirbagIsEnabled(bool? enabled) {
    state = state.copyWith(airbagIsEnabled: enabled);
  }

  void updateSistemAudioSelectedIndex(int? index) {
    state = state.copyWith(sistemAudioSelectedIndex: index);
  }

  void updateSistemAudioIsEnabled(bool? enabled) {
    state = state.copyWith(sistemAudioIsEnabled: enabled);
  }

  void updatePowerWindowSelectedIndex(int? index) {
    state = state.copyWith(powerWindowSelectedIndex: index);
  }

  void updatePowerWindowIsEnabled(bool? enabled) {
    state = state.copyWith(powerWindowIsEnabled: enabled);
  }

  void updateSistemAcSelectedIndex(int? index) {
    state = state.copyWith(sistemAcSelectedIndex: index);
  }

  void updateSistemAcIsEnabled(bool? enabled) {
    state = state.copyWith(sistemAcIsEnabled: enabled);
  }

  void updateFiturCatatanList(List<String> lines) {
    state = state.copyWith(fiturCatatanList: lines);
  }

  // New update methods for Page Five Two
  void updateGetaranMesinSelectedIndex(int? index) {
    state = state.copyWith(getaranMesinSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateGetaranMesinIsEnabled(bool? enabled) {
    state = state.copyWith(getaranMesinIsEnabled: enabled);
  }

  void updateSuaraMesinSelectedIndex(int? index) {
    state = state.copyWith(suaraMesinSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateSuaraMesinIsEnabled(bool? enabled) {
    state = state.copyWith(suaraMesinIsEnabled: enabled);
  }

  void updateTransmisiSelectedIndex(int? index) {
    state = state.copyWith(transmisiSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateTransmisiIsEnabled(bool? enabled) {
    state = state.copyWith(transmisiIsEnabled: enabled);
  }

  void updatePompaPowerSteeringSelectedIndex(int? index) {
    state = state.copyWith(pompaPowerSteeringSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updatePompaPowerSteeringIsEnabled(bool? enabled) {
    state = state.copyWith(pompaPowerSteeringIsEnabled: enabled);
  }

  void updateCoverTimingChainSelectedIndex(int? index) {
    state = state.copyWith(coverTimingChainSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateCoverTimingChainIsEnabled(bool? enabled) {
    state = state.copyWith(coverTimingChainIsEnabled: enabled);
  }

  void updateOliPowerSteeringSelectedIndex(int? index) {
    state = state.copyWith(oliPowerSteeringSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateOliPowerSteeringIsEnabled(bool? enabled) {
    state = state.copyWith(oliPowerSteeringIsEnabled: enabled);
  }

  void updateAccuSelectedIndex(int? index) {
    state = state.copyWith(accuSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateAccuIsEnabled(bool? enabled) {
    state = state.copyWith(accuIsEnabled: enabled);
  }

  void updateKompressorAcSelectedIndex(int? index) {
    state = state.copyWith(kompressorAcSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateKompressorAcIsEnabled(bool? enabled) {
    state = state.copyWith(kompressorAcIsEnabled: enabled);
  }

  void updateFanSelectedIndex(int? index) {
    state = state.copyWith(fanSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateFanIsEnabled(bool? enabled) {
    state = state.copyWith(fanIsEnabled: enabled);
  }

  void updateSelangSelectedIndex(int? index) {
    state = state.copyWith(selangSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateSelangIsEnabled(bool? enabled) {
    state = state.copyWith(selangIsEnabled: enabled);
  }

  void updateKarterOliSelectedIndex(int? index) {
    state = state.copyWith(karterOliSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateKarterOliIsEnabled(bool? enabled) {
    state = state.copyWith(karterOliIsEnabled: enabled);
  }

  void updateOilRemSelectedIndex(int? index) {
    state = state.copyWith(oilRemSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateOilRemIsEnabled(bool? enabled) {
    state = state.copyWith(oilRemIsEnabled: enabled);
  }

  void updateKabelSelectedIndex(int? index) {
    state = state.copyWith(kabelSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateKabelIsEnabled(bool? enabled) {
    state = state.copyWith(kabelIsEnabled: enabled);
  }

  void updateKondensorSelectedIndex(int? index) {
    state = state.copyWith(kondensorSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateKondensorIsEnabled(bool? enabled) {
    state = state.copyWith(kondensorIsEnabled: enabled);
  }

  void updateRadiatorSelectedIndex(int? index) {
    state = state.copyWith(radiatorSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateRadiatorIsEnabled(bool? enabled) {
    state = state.copyWith(radiatorIsEnabled: enabled);
  }

  void updateCylinderHeadSelectedIndex(int? index) {
    state = state.copyWith(cylinderHeadSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateCylinderHeadIsEnabled(bool? enabled) {
    state = state.copyWith(cylinderHeadIsEnabled: enabled);
  }

  void updateOliMesinSelectedIndex(int? index) {
    state = state.copyWith(oliMesinSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateOliMesinIsEnabled(bool? enabled) {
    state = state.copyWith(oliMesinIsEnabled: enabled);
  }

  void updateAirRadiatorSelectedIndex(int? index) {
    state = state.copyWith(airRadiatorSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateAirRadiatorIsEnabled(bool? enabled) {
    state = state.copyWith(airRadiatorIsEnabled: enabled);
  }

  void updateCoverKlepSelectedIndex(int? index) {
    state = state.copyWith(coverKlepSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateCoverKlepIsEnabled(bool? enabled) {
    state = state.copyWith(coverKlepIsEnabled: enabled);
  }

  void updateAlternatorSelectedIndex(int? index) {
    state = state.copyWith(alternatorSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateAlternatorIsEnabled(bool? enabled) {
    state = state.copyWith(alternatorIsEnabled: enabled);
  }

  void updateWaterPumpSelectedIndex(int? index) {
    state = state.copyWith(waterPumpSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateWaterPumpIsEnabled(bool? enabled) {
    state = state.copyWith(waterPumpIsEnabled: enabled);
  }

  void updateBeltSelectedIndex(int? index) {
    state = state.copyWith(beltSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateBeltIsEnabled(bool? enabled) {
    state = state.copyWith(beltIsEnabled: enabled);
  }

  void updateOliTransmisiSelectedIndex(int? index) {
    state = state.copyWith(oliTransmisiSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateOliTransmisiIsEnabled(bool? enabled) {
    state = state.copyWith(oliTransmisiIsEnabled: enabled);
  }

  void updateCylinderBlockSelectedIndex(int? index) {
    state = state.copyWith(cylinderBlockSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateCylinderBlockIsEnabled(bool? enabled) {
    state = state.copyWith(cylinderBlockIsEnabled: enabled);
  }

  void updateBushingBesarSelectedIndex(int? index) {
    state = state.copyWith(bushingBesarSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateBushingBesarIsEnabled(bool? enabled) {
    state = state.copyWith(bushingBesarIsEnabled: enabled);
  }

  void updateBushingKecilSelectedIndex(int? index) {
    state = state.copyWith(bushingKecilSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateBushingKecilIsEnabled(bool? enabled) {
    state = state.copyWith(bushingKecilIsEnabled: enabled);
  }

  void updateTutupRadiatorSelectedIndex(int? index) {
    state = state.copyWith(tutupRadiatorSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateTutupRadiatorIsEnabled(bool? enabled) {
    state = state.copyWith(tutupRadiatorIsEnabled: enabled);
  }

  void updateMesinCatatan(String? text) {
    state = state.copyWith(mesinCatatan: text);
  }

  // New update methods for Page Five Three
  void updateStirSelectedIndex(int? index) {
    state = state.copyWith(stirSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateStirIsEnabled(bool? enabled) {
    state = state.copyWith(stirIsEnabled: enabled);
  }

  void updateRemTonganSelectedIndex(int? index) {
    state = state.copyWith(remTonganSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateRemTonganIsEnabled(bool? enabled) {
    state = state.copyWith(remTonganIsEnabled: enabled);
  }

  void updatePedalSelectedIndex(int? index) {
    state = state.copyWith(pedalSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updatePedalIsEnabled(bool? enabled) {
    state = state.copyWith(pedalIsEnabled: enabled);
  }

  void updateSwitchWiperSelectedIndex(int? index) {
    state = state.copyWith(switchWiperSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateSwitchWiperIsEnabled(bool? enabled) {
    state = state.copyWith(switchWiperIsEnabled: enabled);
  }

  void updateLampuHazardSelectedIndex(int? index) {
    state = state.copyWith(lampuHazardSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateLampuHazardIsEnabled(bool? enabled) {
    state = state.copyWith(lampuHazardIsEnabled: enabled);
  }

  void updatePanelDashboardSelectedIndex(int? index) {
    state = state.copyWith(panelDashboardSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updatePanelDashboardIsEnabled(bool? enabled) {
    state = state.copyWith(panelDashboardIsEnabled: enabled);
  }

  void updatePembukaKapMesinSelectedIndex(int? index) {
    state = state.copyWith(pembukaKapMesinSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updatePembukaKapMesinIsEnabled(bool? enabled) {
    state = state.copyWith(pembukaKapMesinIsEnabled: enabled);
  }

  void updatePembukaBagasiSelectedIndex(int? index) {
    state = state.copyWith(pembukaBagasiSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updatePembukaBagasiIsEnabled(bool? enabled) {
    state = state.copyWith(pembukaBagasiIsEnabled: enabled);
  }

  void updateJokDepanSelectedIndex(int? index) {
    state = state.copyWith(jokDepanSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateJokDepanIsEnabled(bool? enabled) {
    state = state.copyWith(jokDepanIsEnabled: enabled);
  }

  void updateAromaInteriorSelectedIndex(int? index) {
    state = state.copyWith(aromaInteriorSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateAromaInteriorIsEnabled(bool? enabled) {
    state = state.copyWith(aromaInteriorIsEnabled: enabled);
  }

  void updateHandlePintuSelectedIndex(int? index) {
    state = state.copyWith(handlePintuSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateHandlePintuIsEnabled(bool? enabled) {
    state = state.copyWith(handlePintuIsEnabled: enabled);
  }

  void updateConsoleBoxSelectedIndex(int? index) {
    state = state.copyWith(consoleBoxSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateConsoleBoxIsEnabled(bool? enabled) {
    state = state.copyWith(consoleBoxIsEnabled: enabled);
  }

  void updateSpionTengahSelectedIndex(int? index) {
    state = state.copyWith(spionTengahSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateSpionTengahIsEnabled(bool? enabled) {
    state = state.copyWith(spionTengahIsEnabled: enabled);
  }

  void updateTuasPersnelingSelectedIndex(int? index) {
    state = state.copyWith(tuasPersnelingSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateTuasPersnelingIsEnabled(bool? enabled) {
    state = state.copyWith(tuasPersnelingIsEnabled: enabled);
  }

  void updateJokBelakangSelectedIndex(int? index) {
    state = state.copyWith(jokBelakangSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateJokBelakangIsEnabled(bool? enabled) {
    state = state.copyWith(jokBelakangIsEnabled: enabled);
  }

  void updatePanelIndikatorSelectedIndex(int? index) {
    state = state.copyWith(panelIndikatorSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updatePanelIndikatorIsEnabled(bool? enabled) {
    state = state.copyWith(panelIndikatorIsEnabled: enabled);
  }

  void updateSwitchLampuSelectedIndex(int? index) {
    state = state.copyWith(switchLampuSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateSwitchLampuIsEnabled(bool? enabled) {
    state = state.copyWith(switchLampuIsEnabled: enabled);
  }

  void updateKarpetDasarSelectedIndex(int? index) {
    state = state.copyWith(karpetDasarSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateKarpetDasarIsEnabled(bool? enabled) {
    state = state.copyWith(karpetDasarIsEnabled: enabled);
  }

  void updateKlaksonSelectedIndex(int? index) {
    state = state.copyWith(klaksonSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateKlaksonIsEnabled(bool? enabled) {
    state = state.copyWith(klaksonIsEnabled: enabled);
  }

  void updateSunVisorSelectedIndex(int? index) {
    state = state.copyWith(sunVisorSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateSunVisorIsEnabled(bool? enabled) {
    state = state.copyWith(sunVisorIsEnabled: enabled);
  }

  void updateTuasTangkiBensinSelectedIndex(int? index) {
    state = state.copyWith(tuasTangkiBensinSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateTuasTangkiBensinIsEnabled(bool? enabled) {
    state = state.copyWith(tuasTangkiBensinIsEnabled: enabled);
  }

  void updateSabukPengamanSelectedIndex(int? index) {
    state = state.copyWith(sabukPengamanSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateSabukPengamanIsEnabled(bool? enabled) {
    state = state.copyWith(sabukPengamanIsEnabled: enabled);
  }

  void updateTrimInteriorSelectedIndex(int? index) {
    state = state.copyWith(trimInteriorSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateTrimInteriorIsEnabled(bool? enabled) {
    state = state.copyWith(trimInteriorIsEnabled: enabled);
  }

  void updatePlafonSelectedIndex(int? index) {
    state = state.copyWith(plafonSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updatePlafonIsEnabled(bool? enabled) {
    state = state.copyWith(plafonIsEnabled: enabled);
  }

  void updateInteriorCatatan(String? catatan) {
    state = state.copyWith(interiorCatatan: catatan);
  }

  // New update methods for Page Five Four
  void updateBumperDepanSelectedIndex(int? index) {
    state = state.copyWith(bumperDepanSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateBumperDepanIsEnabled(bool? enabled) {
    state = state.copyWith(bumperDepanIsEnabled: enabled);
  }

  void updateKapMesinSelectedIndex(int? index) {
    state = state.copyWith(kapMesinSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateKapMesinIsEnabled(bool? enabled) {
    state = state.copyWith(kapMesinIsEnabled: enabled);
  }

  void updateLampuUtamaSelectedIndex(int? index) {
    state = state.copyWith(lampuUtamaSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateLampuUtamaIsEnabled(bool? enabled) {
    state = state.copyWith(lampuUtamaIsEnabled: enabled);
  }

  void updatePanelAtapSelectedIndex(int? index) {
    state = state.copyWith(panelAtapSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updatePanelAtapIsEnabled(bool? enabled) {
    state = state.copyWith(panelAtapIsEnabled: enabled);
  }

  void updateGrillSelectedIndex(int? index) {
    state = state.copyWith(grillSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateGrillIsEnabled(bool? enabled) {
    state = state.copyWith(grillIsEnabled: enabled);
  }

  void updateLampuFoglampSelectedIndex(int? index) {
    state = state.copyWith(lampuFoglampSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateLampuFoglampIsEnabled(bool? enabled) {
    state = state.copyWith(lampuFoglampIsEnabled: enabled);
  }

  void updateKacaBeningSelectedIndex(int? index) {
    state = state.copyWith(kacaBeningSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateKacaBeningIsEnabled(bool? enabled) {
    state = state.copyWith(kacaBeningIsEnabled: enabled);
  }

  void updateWiperBelakangSelectedIndex(int? index) {
    state = state.copyWith(wiperBelakangSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateWiperBelakangIsEnabled(bool? enabled) {
    state = state.copyWith(wiperBelakangIsEnabled: enabled);
  }

  void updateBumperBelakangSelectedIndex(int? index) {
    state = state.copyWith(bumperBelakangSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateBumperBelakangIsEnabled(bool? enabled) {
    state = state.copyWith(bumperBelakangIsEnabled: enabled);
  }

  void updateLampuBelakangSelectedIndex(int? index) {
    state = state.copyWith(lampuBelakangSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateLampuBelakangIsEnabled(bool? enabled) {
    state = state.copyWith(lampuBelakangIsEnabled: enabled);
  }

  void updateTrunklidSelectedIndex(int? index) {
    state = state.copyWith(trunklidSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateTrunklidIsEnabled(bool? enabled) {
    state = state.copyWith(trunklidIsEnabled: enabled);
  }

  void updateKacaDepanSelectedIndex(int? index) {
    state = state.copyWith(kacaDepanSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateKacaDepanIsEnabled(bool? enabled) {
    state = state.copyWith(kacaDepanIsEnabled: enabled);
  }

  void updateFenderKananSelectedIndex(int? index) {
    state = state.copyWith(fenderKananSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateFenderKananIsEnabled(bool? enabled) {
    state = state.copyWith(fenderKananIsEnabled: enabled);
  }

  void updateQuarterPanelKananSelectedIndex(int? index) {
    state = state.copyWith(quarterPanelKananSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateQuarterPanelKananIsEnabled(bool? enabled) {
    state = state.copyWith(quarterPanelKananIsEnabled: enabled);
  }

  void updatePintuBelakangKananSelectedIndex(int? index) {
    state = state.copyWith(pintuBelakangKananSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updatePintuBelakangKananIsEnabled(bool? enabled) {
    state = state.copyWith(pintuBelakangKananIsEnabled: enabled);
  }

  void updateSpionKananSelectedIndex(int? index) {
    state = state.copyWith(spionKananSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateSpionKananIsEnabled(bool? enabled) {
    state = state.copyWith(spionKananIsEnabled: enabled);
  }

  void updateLisplangKananSelectedIndex(int? index) {
    state = state.copyWith(lisplangKananSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateLisplangKananIsEnabled(bool? enabled) {
    state = state.copyWith(lisplangKananIsEnabled: enabled);
  }

  void updateSideSkirtKananSelectedIndex(int? index) {
    state = state.copyWith(sideSkirtKananSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateSideSkirtKananIsEnabled(bool? enabled) {
    state = state.copyWith(sideSkirtKananIsEnabled: enabled);
  }

  void updateDaunWiperSelectedIndex(int? index) {
    state = state.copyWith(daunWiperSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateDaunWiperIsEnabled(bool? enabled) {
    state = state.copyWith(daunWiperIsEnabled: enabled);
  }

  void updatePintuBelakangSelectedIndex(int? index) {
    state = state.copyWith(pintuBelakangSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updatePintuBelakangIsEnabled(bool? enabled) {
    state = state.copyWith(pintuBelakangIsEnabled: enabled);
  }

  void updateFenderKiriSelectedIndex(int? index) {
    state = state.copyWith(fenderKiriSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateFenderKiriIsEnabled(bool? enabled) {
    state = state.copyWith(fenderKiriIsEnabled: enabled);
  }

  void updateQuarterPanelKiriSelectedIndex(int? index) {
    state = state.copyWith(quarterPanelKiriSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateQuarterPanelKiriIsEnabled(bool? enabled) {
    state = state.copyWith(quarterPanelKiriIsEnabled: enabled);
  }

  void updatePintuDepanSelectedIndex(int? index) {
    state = state.copyWith(pintuDepanSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updatePintuDepanIsEnabled(bool? enabled) {
    state = state.copyWith(pintuDepanIsEnabled: enabled);
  }

  void updateKacaJendelaKananSelectedIndex(int? index) {
    state = state.copyWith(kacaJendelaKananSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateKacaJendelaKananIsEnabled(bool? enabled) {
    state = state.copyWith(kacaJendelaKananIsEnabled: enabled);
  }

  void updatePintuBelakangKiriSelectedIndex(int? index) {
    state = state.copyWith(pintuBelakangKiriSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updatePintuBelakangKiriIsEnabled(bool? enabled) {
    state = state.copyWith(pintuBelakangKiriIsEnabled: enabled);
  }

  void updateSpionKiriSelectedIndex(int? index) {
    state = state.copyWith(spionKiriSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateSpionKiriIsEnabled(bool? enabled) {
    state = state.copyWith(spionKiriIsEnabled: enabled);
  }

  void updatePintuDepanKiriSelectedIndex(int? index) {
    state = state.copyWith(pintuDepanKiriSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updatePintuDepanKiriIsEnabled(bool? enabled) {
    state = state.copyWith(pintuDepanKiriIsEnabled: enabled);
  }

  void updateKacaJendelaKiriSelectedIndex(int? index) {
    state = state.copyWith(kacaJendelaKiriSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateKacaJendelaKiriIsEnabled(bool? enabled) {
    state = state.copyWith(kacaJendelaKiriIsEnabled: enabled);
  }

  void updateLisplangKiriSelectedIndex(int? index) {
    state = state.copyWith(lisplangKiriSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateLisplangKiriIsEnabled(bool? enabled) {
    state = state.copyWith(lisplangKiriIsEnabled: enabled);
  }

  void updateSideSkirtKiriSelectedIndex(int? index) {
    state = state.copyWith(sideSkirtKiriSelectedIndex: (index == null || index <= 0) ? 0 : index);
  }

  void updateSideSkirtKiriIsEnabled(bool? enabled) {
    state = state.copyWith(sideSkirtKiriIsEnabled: enabled);
  }

  void updateEksteriorCatatan(String? catatan) {
    state = state.copyWith(eksteriorCatatan: catatan);
  }

  void updateRepairEstimations(List<Map<String, String>> estimations) {
    state = state.copyWith(repairEstimations: estimations);
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
    int? interiorSelectedIndex,
    int? eksteriorSelectedIndex,
    int? kakiKakiSelectedIndex,
    int? mesinSelectedIndex,
    int? penilaianKeseluruhanSelectedIndex,
    List<String>? keteranganInterior,
    List<String>? keteranganEksterior,
    List<String>? keteranganKakiKaki,
    List<String>? keteranganMesin,
    List<String>? deskripsiKeseluruhan,
    List<Map<String, String>>? repairEstimations,
    int? airbagSelectedIndex,
    bool? airbagIsEnabled,
    int? sistemAudioSelectedIndex,
    bool? sistemAudioIsEnabled,
    int? powerWindowSelectedIndex,
    bool? powerWindowIsEnabled,
    int? sistemAcSelectedIndex,
    bool? sistemAcIsEnabled,
    List<String>? fiturCatatanList,
    int? getaranMesinSelectedIndex,
    bool? getaranMesinIsEnabled,
    int? suaraMesinSelectedIndex,
    bool? suaraMesinIsEnabled,
    int? transmisiSelectedIndex,
    bool? transmisiIsEnabled,
    int? pompaPowerSteeringSelectedIndex,
    bool? pompaPowerSteeringIsEnabled,
    int? coverTimingChainSelectedIndex,
    bool? coverTimingChainIsEnabled,
    int? oliPowerSteeringSelectedIndex,
    bool? oliPowerSteeringIsEnabled,
    int? accuSelectedIndex,
    bool? accuIsEnabled,
    int? kompressorAcSelectedIndex,
    bool? kompressorAcIsEnabled,
    int? fanSelectedIndex,
    bool? fanIsEnabled,
    int? selangSelectedIndex,
    bool? selangIsEnabled,
    int? karterOliSelectedIndex,
    bool? karterOliIsEnabled,
    int? oilRemSelectedIndex,
    bool? oilRemIsEnabled,
    int? kabelSelectedIndex,
    bool? kabelIsEnabled,
    int? kondensorSelectedIndex,
    bool? kondensorIsEnabled,
    int? radiatorSelectedIndex,
    bool? radiatorIsEnabled,
    int? cylinderHeadSelectedIndex,
    bool? cylinderHeadIsEnabled,
    int? oliMesinSelectedIndex,
    bool? oliMesinIsEnabled,
    int? airRadiatorSelectedIndex,
    bool? airRadiatorIsEnabled,
    int? coverKlepSelectedIndex,
    bool? coverKlepIsEnabled,
    int? alternatorSelectedIndex,
    bool? alternatorIsEnabled,
    int? waterPumpSelectedIndex,
    bool? waterPumpIsEnabled,
    int? beltSelectedIndex,
    bool? beltIsEnabled,
    int? oliTransmisiSelectedIndex,
    bool? oliTransmisiIsEnabled,
    int? cylinderBlockSelectedIndex,
    bool? cylinderBlockIsEnabled,
    int? bushingBesarSelectedIndex,
    bool? bushingBesarIsEnabled,
    int? bushingKecilSelectedIndex,
    bool? bushingKecilIsEnabled,
    int? tutupRadiatorSelectedIndex,
    bool? tutupRadiatorIsEnabled,
    String? mesinCatatan,
    int? stirSelectedIndex,
    bool? stirIsEnabled,
    int? remTonganSelectedIndex,
    bool? remTonganIsEnabled,
    int? pedalSelectedIndex,
    bool? pedalIsEnabled,
    int? switchWiperSelectedIndex,
    bool? switchWiperIsEnabled,
    int? lampuHazardSelectedIndex,
    bool? lampuHazardIsEnabled,
    int? panelDashboardSelectedIndex,
    bool? panelDashboardIsEnabled,
    int? pembukaKapMesinSelectedIndex,
    bool? pembukaKapMesinIsEnabled,
    int? pembukaBagasiSelectedIndex,
    bool? pembukaBagasiIsEnabled,
    int? jokDepanSelectedIndex,
    bool? jokDepanIsEnabled,
    int? aromaInteriorSelectedIndex,
    bool? aromaInteriorIsEnabled,
    int? handlePintuSelectedIndex,
    bool? handlePintuIsEnabled,
    int? consoleBoxSelectedIndex,
    bool? consoleBoxIsEnabled,
    int? spionTengahSelectedIndex,
    bool? spionTengahIsEnabled,
    int? tuasPersnelingSelectedIndex,
    bool? tuasPersnelingIsEnabled,
    int? jokBelakangSelectedIndex,
    bool? jokBelakangIsEnabled,
    int? panelIndikatorSelectedIndex,
    bool? panelIndikatorIsEnabled,
    int? switchLampuSelectedIndex,
    bool? switchLampuIsEnabled,
    int? karpetDasarSelectedIndex,
    bool? karpetDasarIsEnabled,
    int? klaksonSelectedIndex,
    bool? klaksonIsEnabled,
    int? sunVisorSelectedIndex,
    bool? sunVisorIsEnabled,
    int? tuasTangkiBensinSelectedIndex,
    bool? tuasTangkiBensinIsEnabled,
    int? sabukPengamanSelectedIndex,
    bool? sabukPengamanIsEnabled,
    int? trimInteriorSelectedIndex,
    bool? trimInteriorIsEnabled,
    int? plafonSelectedIndex,
    bool? plafonIsEnabled,
    String? interiorCatatan,
    int? bumperDepanSelectedIndex,
    bool? bumperDepanIsEnabled,
    int? kapMesinSelectedIndex,
    bool? kapMesinIsEnabled,
    int? lampuUtamaSelectedIndex,
    bool? lampuUtamaIsEnabled,
    int? panelAtapSelectedIndex,
    bool? panelAtapIsEnabled,
    int? grillSelectedIndex,
    bool? grillIsEnabled,
    int? lampuFoglampSelectedIndex,
    bool? lampuFoglampIsEnabled,
    int? kacaBeningSelectedIndex,
    bool? kacaBeningIsEnabled,
    int? wiperBelakangSelectedIndex,
    bool? wiperBelakangIsEnabled,
    int? bumperBelakangSelectedIndex,
    bool? bumperBelakangIsEnabled,
    int? lampuBelakangSelectedIndex,
    bool? lampuBelakangIsEnabled,
    int? trunklidSelectedIndex,
    bool? trunklidIsEnabled,
    int? kacaDepanSelectedIndex,
    bool? kacaDepanIsEnabled,
    int? fenderKananSelectedIndex,
    bool? fenderKananIsEnabled,
    int? quarterPanelKananSelectedIndex,
    bool? quarterPanelKananIsEnabled,
    int? pintuBelakangKananSelectedIndex,
    bool? pintuBelakangKananIsEnabled,
    int? spionKananSelectedIndex,
    bool? spionKananIsEnabled,
    int? lisplangKananSelectedIndex,
    bool? lisplangKananIsEnabled,
    int? sideSkirtKananSelectedIndex,
    bool? sideSkirtKananIsEnabled,
    int? daunWiperSelectedIndex,
    bool? daunWiperIsEnabled,
    int? pintuBelakangSelectedIndex,
    bool? pintuBelakangIsEnabled,
    int? fenderKiriSelectedIndex,
    bool? fenderKiriIsEnabled,
    int? quarterPanelKiriSelectedIndex,
    bool? quarterPanelKiriIsEnabled,
    int? pintuDepanSelectedIndex,
    bool? pintuDepanIsEnabled,
    int? kacaJendelaKananSelectedIndex,
    bool? kacaJendelaKananIsEnabled,
    int? pintuBelakangKiriSelectedIndex,
    bool? pintuBelakangKiriIsEnabled,
    int? spionKiriSelectedIndex,
    bool? spionKiriIsEnabled,
    int? pintuDepanKiriSelectedIndex,
    bool? pintuDepanKiriIsEnabled,
    int? kacaJendelaKiriSelectedIndex,
    bool? kacaJendelaKiriIsEnabled,
    int? lisplangKiriSelectedIndex,
    bool? lisplangKiriIsEnabled,
    int? sideSkirtKiriSelectedIndex,
    bool? sideSkirtKiriIsEnabled,
    String? eksteriorCatatan,
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
      interiorSelectedIndex: interiorSelectedIndex ?? this.interiorSelectedIndex,
      eksteriorSelectedIndex: eksteriorSelectedIndex ?? this.eksteriorSelectedIndex,
      kakiKakiSelectedIndex: kakiKakiSelectedIndex ?? this.kakiKakiSelectedIndex,
      mesinSelectedIndex: mesinSelectedIndex ?? this.mesinSelectedIndex,
      penilaianKeseluruhanSelectedIndex: penilaianKeseluruhanSelectedIndex ?? this.penilaianKeseluruhanSelectedIndex,
      keteranganInterior: keteranganInterior ?? this.keteranganInterior,
      keteranganEksterior: keteranganEksterior ?? this.keteranganEksterior,
      keteranganKakiKaki: keteranganKakiKaki ?? this.keteranganKakiKaki,
      keteranganMesin: keteranganMesin ?? this.keteranganMesin,
      deskripsiKeseluruhan: deskripsiKeseluruhan ?? this.deskripsiKeseluruhan,
      repairEstimations: repairEstimations ?? this.repairEstimations,
      airbagSelectedIndex: airbagSelectedIndex ?? this.airbagSelectedIndex,
      airbagIsEnabled: airbagIsEnabled ?? this.airbagIsEnabled,
      sistemAudioSelectedIndex: sistemAudioSelectedIndex ?? this.sistemAudioSelectedIndex,
      sistemAudioIsEnabled: sistemAudioIsEnabled ?? this.sistemAudioIsEnabled,
      powerWindowSelectedIndex: powerWindowSelectedIndex ?? this.powerWindowSelectedIndex,
      powerWindowIsEnabled: powerWindowIsEnabled ?? this.powerWindowIsEnabled,
      sistemAcSelectedIndex: sistemAcSelectedIndex ?? this.sistemAcSelectedIndex,
      sistemAcIsEnabled: sistemAcIsEnabled ?? this.sistemAcIsEnabled,
      fiturCatatanList: fiturCatatanList ?? this.fiturCatatanList,
      getaranMesinSelectedIndex: getaranMesinSelectedIndex ?? this.getaranMesinSelectedIndex,
      getaranMesinIsEnabled: getaranMesinIsEnabled ?? this.getaranMesinIsEnabled,
      suaraMesinSelectedIndex: suaraMesinSelectedIndex ?? this.suaraMesinSelectedIndex,
      suaraMesinIsEnabled: suaraMesinIsEnabled ?? this.suaraMesinIsEnabled,
      transmisiSelectedIndex: transmisiSelectedIndex ?? this.transmisiSelectedIndex,
      transmisiIsEnabled: transmisiIsEnabled ?? this.transmisiIsEnabled,
      pompaPowerSteeringSelectedIndex: pompaPowerSteeringSelectedIndex ?? this.pompaPowerSteeringSelectedIndex,
      pompaPowerSteeringIsEnabled: pompaPowerSteeringIsEnabled ?? this.pompaPowerSteeringIsEnabled,
      coverTimingChainSelectedIndex: coverTimingChainSelectedIndex ?? this.coverTimingChainSelectedIndex,
      coverTimingChainIsEnabled: coverTimingChainIsEnabled ?? this.coverTimingChainIsEnabled,
      oliPowerSteeringSelectedIndex: oliPowerSteeringSelectedIndex ?? this.oliPowerSteeringSelectedIndex,
      oliPowerSteeringIsEnabled: oliPowerSteeringIsEnabled ?? this.oliPowerSteeringIsEnabled,
      accuSelectedIndex: accuSelectedIndex ?? this.accuSelectedIndex,
      accuIsEnabled: accuIsEnabled ?? this.accuIsEnabled,
      kompressorAcSelectedIndex: kompressorAcSelectedIndex ?? this.kompressorAcSelectedIndex,
      kompressorAcIsEnabled: kompressorAcIsEnabled ?? this.kompressorAcIsEnabled,
      fanSelectedIndex: fanSelectedIndex ?? this.fanSelectedIndex,
      fanIsEnabled: fanIsEnabled ?? this.fanIsEnabled,
      selangSelectedIndex: selangSelectedIndex ?? this.selangSelectedIndex,
      selangIsEnabled: selangIsEnabled ?? this.selangIsEnabled,
      karterOliSelectedIndex: karterOliSelectedIndex ?? this.karterOliSelectedIndex,
      karterOliIsEnabled: karterOliIsEnabled ?? this.karterOliIsEnabled,
      oilRemSelectedIndex: oilRemSelectedIndex ?? this.oilRemSelectedIndex,
      oilRemIsEnabled: oilRemIsEnabled ?? this.oilRemIsEnabled,
      kabelSelectedIndex: kabelSelectedIndex ?? this.kabelSelectedIndex,
      kabelIsEnabled: kabelIsEnabled ?? this.kabelIsEnabled,
      kondensorSelectedIndex: kondensorSelectedIndex ?? this.kondensorSelectedIndex,
      kondensorIsEnabled: kondensorIsEnabled ?? this.kondensorIsEnabled,
      radiatorSelectedIndex: radiatorSelectedIndex ?? this.radiatorSelectedIndex,
      radiatorIsEnabled: radiatorIsEnabled ?? this.radiatorIsEnabled,
      cylinderHeadSelectedIndex: cylinderHeadSelectedIndex ?? this.cylinderHeadSelectedIndex,
      cylinderHeadIsEnabled: cylinderHeadIsEnabled ?? this.cylinderHeadIsEnabled,
      oliMesinSelectedIndex: oliMesinSelectedIndex ?? this.oliMesinSelectedIndex,
      oliMesinIsEnabled: oliMesinIsEnabled ?? this.oliMesinIsEnabled,
      airRadiatorSelectedIndex: airRadiatorSelectedIndex ?? this.airRadiatorSelectedIndex,
      airRadiatorIsEnabled: airRadiatorIsEnabled ?? this.airRadiatorIsEnabled,
      coverKlepSelectedIndex: coverKlepSelectedIndex ?? this.coverKlepSelectedIndex,
      coverKlepIsEnabled: coverKlepIsEnabled ?? this.coverKlepIsEnabled,
      alternatorSelectedIndex: alternatorSelectedIndex ?? this.alternatorSelectedIndex,
      alternatorIsEnabled: alternatorIsEnabled ?? this.alternatorIsEnabled,
      waterPumpSelectedIndex: waterPumpSelectedIndex ?? this.waterPumpSelectedIndex,
      waterPumpIsEnabled: waterPumpIsEnabled ?? this.waterPumpIsEnabled,
      beltSelectedIndex: beltSelectedIndex ?? this.beltSelectedIndex,
      beltIsEnabled: beltIsEnabled ?? this.beltIsEnabled,
      oliTransmisiSelectedIndex: oliTransmisiSelectedIndex ?? this.oliTransmisiSelectedIndex,
      oliTransmisiIsEnabled: oliTransmisiIsEnabled ?? this.oliTransmisiIsEnabled,
      cylinderBlockSelectedIndex: cylinderBlockSelectedIndex ?? this.cylinderBlockSelectedIndex,
      cylinderBlockIsEnabled: cylinderBlockIsEnabled ?? this.cylinderBlockIsEnabled,
      bushingBesarSelectedIndex: bushingBesarSelectedIndex ?? this.bushingBesarSelectedIndex,
      bushingBesarIsEnabled: bushingBesarIsEnabled ?? this.bushingBesarIsEnabled,
      bushingKecilSelectedIndex: bushingKecilSelectedIndex ?? this.bushingKecilSelectedIndex,
      bushingKecilIsEnabled: bushingKecilIsEnabled ?? this.bushingKecilIsEnabled,
      tutupRadiatorSelectedIndex: tutupRadiatorSelectedIndex ?? this.tutupRadiatorSelectedIndex,
      tutupRadiatorIsEnabled: tutupRadiatorIsEnabled ?? this.tutupRadiatorIsEnabled,
      mesinCatatan: mesinCatatan ?? this.mesinCatatan,
      stirSelectedIndex: stirSelectedIndex ?? this.stirSelectedIndex,
      stirIsEnabled: stirIsEnabled ?? this.stirIsEnabled,
      remTonganSelectedIndex: remTonganSelectedIndex ?? this.remTonganSelectedIndex,
      remTonganIsEnabled: remTonganIsEnabled ?? this.remTonganIsEnabled,
      pedalSelectedIndex: pedalSelectedIndex ?? this.pedalSelectedIndex,
      pedalIsEnabled: pedalIsEnabled ?? this.pedalIsEnabled,
      switchWiperSelectedIndex: switchWiperSelectedIndex ?? this.switchWiperSelectedIndex,
      switchWiperIsEnabled: switchWiperIsEnabled ?? this.switchWiperIsEnabled,
      lampuHazardSelectedIndex: lampuHazardSelectedIndex ?? this.lampuHazardSelectedIndex,
      lampuHazardIsEnabled: lampuHazardIsEnabled ?? this.lampuHazardIsEnabled,
      panelDashboardSelectedIndex: panelDashboardSelectedIndex ?? this.panelDashboardSelectedIndex,
      panelDashboardIsEnabled: panelDashboardIsEnabled ?? this.panelDashboardIsEnabled,
      pembukaKapMesinSelectedIndex: pembukaKapMesinSelectedIndex ?? this.pembukaKapMesinSelectedIndex,
      pembukaKapMesinIsEnabled: pembukaKapMesinIsEnabled ?? this.pembukaKapMesinIsEnabled,
      pembukaBagasiSelectedIndex: pembukaBagasiSelectedIndex ?? this.pembukaBagasiSelectedIndex,
      pembukaBagasiIsEnabled: pembukaBagasiIsEnabled ?? this.pembukaBagasiIsEnabled,
      jokDepanSelectedIndex: jokDepanSelectedIndex ?? this.jokDepanSelectedIndex,
      jokDepanIsEnabled: jokDepanIsEnabled ?? this.jokDepanIsEnabled,
      aromaInteriorSelectedIndex: aromaInteriorSelectedIndex ?? this.aromaInteriorSelectedIndex,
      aromaInteriorIsEnabled: aromaInteriorIsEnabled ?? this.aromaInteriorIsEnabled,
      handlePintuSelectedIndex: handlePintuSelectedIndex ?? this.handlePintuSelectedIndex,
      handlePintuIsEnabled: handlePintuIsEnabled ?? this.handlePintuIsEnabled,
      consoleBoxSelectedIndex: consoleBoxSelectedIndex ?? this.consoleBoxSelectedIndex,
      consoleBoxIsEnabled: consoleBoxIsEnabled ?? this.consoleBoxIsEnabled,
      spionTengahSelectedIndex: spionTengahSelectedIndex ?? this.spionTengahSelectedIndex,
      spionTengahIsEnabled: spionTengahIsEnabled ?? this.spionTengahIsEnabled,
      tuasPersnelingSelectedIndex: tuasPersnelingSelectedIndex ?? this.tuasPersnelingSelectedIndex,
      tuasPersnelingIsEnabled: tuasPersnelingIsEnabled ?? this.tuasPersnelingIsEnabled,
      jokBelakangSelectedIndex: jokBelakangSelectedIndex ?? this.jokBelakangSelectedIndex,
      jokBelakangIsEnabled: jokBelakangIsEnabled ?? this.jokBelakangIsEnabled,
      panelIndikatorSelectedIndex: panelIndikatorSelectedIndex ?? this.panelIndikatorSelectedIndex,
      panelIndikatorIsEnabled: panelIndikatorIsEnabled ?? this.panelIndikatorIsEnabled,
      switchLampuSelectedIndex: switchLampuSelectedIndex ?? this.switchLampuSelectedIndex,
      switchLampuIsEnabled: switchLampuIsEnabled ?? this.switchLampuIsEnabled,
      karpetDasarSelectedIndex: karpetDasarSelectedIndex ?? this.karpetDasarSelectedIndex,
      karpetDasarIsEnabled: karpetDasarIsEnabled ?? this.karpetDasarIsEnabled,
      klaksonSelectedIndex: klaksonSelectedIndex ?? this.klaksonSelectedIndex,
      klaksonIsEnabled: klaksonIsEnabled ?? this.klaksonIsEnabled,
      sunVisorSelectedIndex: sunVisorSelectedIndex ?? this.sunVisorSelectedIndex,
      sunVisorIsEnabled: sunVisorIsEnabled ?? this.sunVisorIsEnabled,
      tuasTangkiBensinSelectedIndex: tuasTangkiBensinSelectedIndex ?? this.tuasTangkiBensinSelectedIndex,
      tuasTangkiBensinIsEnabled: tuasTangkiBensinIsEnabled ?? this.tuasTangkiBensinIsEnabled,
      sabukPengamanSelectedIndex: sabukPengamanSelectedIndex ?? this.sabukPengamanSelectedIndex,
      sabukPengamanIsEnabled: sabukPengamanIsEnabled ?? this.sabukPengamanIsEnabled,
      trimInteriorSelectedIndex: trimInteriorSelectedIndex ?? this.trimInteriorSelectedIndex,
      trimInteriorIsEnabled: trimInteriorIsEnabled ?? this.trimInteriorIsEnabled,
      plafonSelectedIndex: plafonSelectedIndex ?? this.plafonSelectedIndex,
      plafonIsEnabled: plafonIsEnabled ?? this.plafonIsEnabled,
      interiorCatatan: interiorCatatan ?? this.interiorCatatan,
      bumperDepanSelectedIndex: bumperDepanSelectedIndex ?? this.bumperDepanSelectedIndex,
      bumperDepanIsEnabled: bumperDepanIsEnabled ?? this.bumperDepanIsEnabled,
      kapMesinSelectedIndex: kapMesinSelectedIndex ?? this.kapMesinSelectedIndex,
      kapMesinIsEnabled: kapMesinIsEnabled ?? this.kapMesinIsEnabled,
      lampuUtamaSelectedIndex: lampuUtamaSelectedIndex ?? this.lampuUtamaSelectedIndex,
      lampuUtamaIsEnabled: lampuUtamaIsEnabled ?? this.lampuUtamaIsEnabled,
      panelAtapSelectedIndex: panelAtapSelectedIndex ?? this.panelAtapSelectedIndex,
      panelAtapIsEnabled: panelAtapIsEnabled ?? this.panelAtapIsEnabled,
      grillSelectedIndex: grillSelectedIndex ?? this.grillSelectedIndex,
      grillIsEnabled: grillIsEnabled ?? this.grillIsEnabled,
      lampuFoglampSelectedIndex: lampuFoglampSelectedIndex ?? this.lampuFoglampSelectedIndex,
      lampuFoglampIsEnabled: lampuFoglampIsEnabled ?? this.lampuFoglampIsEnabled,
      kacaBeningSelectedIndex: kacaBeningSelectedIndex ?? this.kacaBeningSelectedIndex,
      kacaBeningIsEnabled: kacaBeningIsEnabled ?? this.kacaBeningIsEnabled,
      wiperBelakangSelectedIndex: wiperBelakangSelectedIndex ?? this.wiperBelakangSelectedIndex,
      wiperBelakangIsEnabled: wiperBelakangIsEnabled ?? this.wiperBelakangIsEnabled,
      bumperBelakangSelectedIndex: bumperBelakangSelectedIndex ?? this.bumperBelakangSelectedIndex,
      bumperBelakangIsEnabled: bumperBelakangIsEnabled ?? this.bumperBelakangIsEnabled,
      lampuBelakangSelectedIndex: lampuBelakangSelectedIndex ?? this.lampuBelakangSelectedIndex,
      lampuBelakangIsEnabled: lampuBelakangIsEnabled ?? this.lampuBelakangIsEnabled,
      trunklidSelectedIndex: trunklidSelectedIndex ?? this.trunklidSelectedIndex,
      trunklidIsEnabled: trunklidIsEnabled ?? this.trunklidIsEnabled,
      kacaDepanSelectedIndex: kacaDepanSelectedIndex ?? this.kacaDepanSelectedIndex,
      kacaDepanIsEnabled: kacaDepanIsEnabled ?? this.kacaDepanIsEnabled,
      fenderKananSelectedIndex: fenderKananSelectedIndex ?? this.fenderKananSelectedIndex,
      fenderKananIsEnabled: fenderKananIsEnabled ?? this.fenderKananIsEnabled,
      quarterPanelKananSelectedIndex: quarterPanelKananSelectedIndex ?? this.quarterPanelKananSelectedIndex,
      quarterPanelKananIsEnabled: quarterPanelKananIsEnabled ?? this.quarterPanelKananIsEnabled,
      pintuBelakangKananSelectedIndex: pintuBelakangKananSelectedIndex ?? this.pintuBelakangKananSelectedIndex,
      pintuBelakangKananIsEnabled: pintuBelakangKananIsEnabled ?? this.pintuBelakangKananIsEnabled,
      spionKananSelectedIndex: spionKananSelectedIndex ?? this.spionKananSelectedIndex,
      spionKananIsEnabled: spionKananIsEnabled ?? this.spionKananIsEnabled,
      lisplangKananSelectedIndex: lisplangKananSelectedIndex ?? this.lisplangKananSelectedIndex,
      lisplangKananIsEnabled: lisplangKananIsEnabled ?? this.lisplangKananIsEnabled,
      sideSkirtKananSelectedIndex: sideSkirtKananSelectedIndex ?? this.sideSkirtKananSelectedIndex,
      sideSkirtKananIsEnabled: sideSkirtKananIsEnabled ?? this.sideSkirtKananIsEnabled,
      daunWiperSelectedIndex: daunWiperSelectedIndex ?? this.daunWiperSelectedIndex,
      daunWiperIsEnabled: daunWiperIsEnabled ?? this.daunWiperIsEnabled,
      pintuBelakangSelectedIndex: pintuBelakangSelectedIndex ?? this.pintuBelakangSelectedIndex,
      pintuBelakangIsEnabled: pintuBelakangIsEnabled ?? this.pintuBelakangIsEnabled,
      fenderKiriSelectedIndex: fenderKiriSelectedIndex ?? this.fenderKiriSelectedIndex,
      fenderKiriIsEnabled: fenderKiriIsEnabled ?? this.fenderKiriIsEnabled,
      quarterPanelKiriSelectedIndex: quarterPanelKiriSelectedIndex ?? this.quarterPanelKiriSelectedIndex,
      quarterPanelKiriIsEnabled: quarterPanelKiriIsEnabled ?? this.quarterPanelKiriIsEnabled,
      pintuDepanSelectedIndex: pintuDepanSelectedIndex ?? this.pintuDepanSelectedIndex,
      pintuDepanIsEnabled: pintuDepanIsEnabled ?? this.pintuDepanIsEnabled,
      kacaJendelaKananSelectedIndex: kacaJendelaKananSelectedIndex ?? this.kacaJendelaKananSelectedIndex,
      kacaJendelaKananIsEnabled: kacaJendelaKananIsEnabled ?? this.kacaJendelaKananIsEnabled,
      pintuBelakangKiriSelectedIndex: pintuBelakangKiriSelectedIndex ?? this.pintuBelakangKiriSelectedIndex,
      pintuBelakangKiriIsEnabled: pintuBelakangKiriIsEnabled ?? this.pintuBelakangKiriIsEnabled,
      spionKiriSelectedIndex: spionKiriSelectedIndex ?? this.spionKiriSelectedIndex,
      spionKiriIsEnabled: spionKiriIsEnabled ?? this.spionKiriIsEnabled,
      pintuDepanKiriSelectedIndex: pintuDepanKiriSelectedIndex ?? this.pintuDepanKiriSelectedIndex,
      pintuDepanKiriIsEnabled: pintuDepanKiriIsEnabled ?? this.pintuDepanKiriIsEnabled,
      kacaJendelaKiriSelectedIndex: kacaJendelaKiriSelectedIndex ?? this.kacaJendelaKiriSelectedIndex,
      kacaJendelaKiriIsEnabled: kacaJendelaKiriIsEnabled ?? this.kacaJendelaKiriIsEnabled,
      lisplangKiriSelectedIndex: lisplangKiriSelectedIndex ?? this.lisplangKiriSelectedIndex,
      lisplangKiriIsEnabled: lisplangKiriIsEnabled ?? this.lisplangKiriIsEnabled,
      sideSkirtKiriSelectedIndex: sideSkirtKiriSelectedIndex ?? this.sideSkirtKiriSelectedIndex,
      sideSkirtKiriIsEnabled: sideSkirtKiriIsEnabled ?? this.sideSkirtKiriIsEnabled,
      eksteriorCatatan: eksteriorCatatan ?? this.eksteriorCatatan,
    );
  }
}
