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
    );
  }
}
