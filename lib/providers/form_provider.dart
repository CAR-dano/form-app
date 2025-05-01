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

  // Page Four Update Methods
  void updateInteriorSelectedIndex(int index) {
    state = state.copyWith(interiorSelectedIndex: index);
  }

  void updateKeteranganInterior(List<String> text) {
    state = state.copyWith(keteranganInterior: text);
  }

  void updateEksteriorSelectedIndex(int index) {
    state = state.copyWith(eksteriorSelectedIndex: index);
  }

  void updateKeteranganEksterior(List<String> text) {
    state = state.copyWith(keteranganEksterior: text);
  }

  void updateKakiKakiSelectedIndex(int index) {
    state = state.copyWith(kakiKakiSelectedIndex: index);
  }

  void updateKeteranganKakiKaki(List<String> text) {
    state = state.copyWith(keteranganKakiKaki: text);
  }

  void updateMesinSelectedIndex(int index) {
    state = state.copyWith(mesinSelectedIndex: index);
  }

  void updateKeteranganMesin(List<String> text) {
    state = state.copyWith(keteranganMesin: text);
  }

  void updatePenilaianKeseluruhanSelectedIndex(int index) {
    state = state.copyWith(penilaianKeseluruhanSelectedIndex: index);
  }

  void updateKeteranganPenilaianKeseluruhan(List<String> text) {
    state = state.copyWith(keteranganPenilaianKeseluruhan: text);
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
    int? interiorSelectedIndex,
    List<String>? keteranganInterior,
    int? eksteriorSelectedIndex,
    List<String>? keteranganEksterior,
    int? kakiKakiSelectedIndex,
    List<String>? keteranganKakiKaki,
    int? mesinSelectedIndex,
    List<String>? keteranganMesin,
    int? penilaianKeseluruhanSelectedIndex,
    List<String>? keteranganPenilaianKeseluruhan,
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
      interiorSelectedIndex: interiorSelectedIndex ?? this.interiorSelectedIndex,
      keteranganInterior: keteranganInterior ?? this.keteranganInterior,
      eksteriorSelectedIndex: eksteriorSelectedIndex ?? this.eksteriorSelectedIndex,
      keteranganEksterior: keteranganEksterior ?? this.keteranganEksterior,
      kakiKakiSelectedIndex: kakiKakiSelectedIndex ?? this.kakiKakiSelectedIndex,
      keteranganKakiKaki: keteranganKakiKaki ?? this.keteranganKakiKaki,
      mesinSelectedIndex: mesinSelectedIndex ?? this.mesinSelectedIndex,
      keteranganMesin: keteranganMesin ?? this.keteranganMesin,
      penilaianKeseluruhanSelectedIndex: penilaianKeseluruhanSelectedIndex ?? this.penilaianKeseluruhanSelectedIndex,
      keteranganPenilaianKeseluruhan: keteranganPenilaianKeseluruhan ?? this.keteranganPenilaianKeseluruhan,
    );
  }
}
