class FormData {
  // Page One Data
  String namaInspektor;
  String namaCustomer;
  String cabangInspeksi;
  DateTime? tanggalInspeksi;

  // Page Two Data
  String merekKendaraan;
  String tipeKendaraan;
  String tahun;
  String transmisi;
  String warnaKendaraan;
  String odometer;
  String kepemilikan;
  String platNomor;
  DateTime? pajak1TahunDate;
  DateTime? pajak5TahunDate;
  String biayaPajak;

  // Page Three Data (Kelengkapan)
  String? bukuService;
  String? kunciSerep;
  String? bukuManual;
  String? banSerep;
  String? bpkp;
  String? dongkrak;
  String? toolkit;
  String? noRangka;
  String? noMesin;

  // New fields for Page Four
  String? indikasiTabrakan;
  String? indikasiBanjir;
  String? indikasiOdometerReset;

  // New fields for Page Four text fields
  String? posisiBan;
  String? merk;
  String? tipeVelg;
  String? ketebalan;

  // New fields for inspection results
  int? interiorSelectedIndex;
  int? eksteriorSelectedIndex;
  int? kakiKakiSelectedIndex;
  int? mesinSelectedIndex;
  int? penilaianKeseluruhanSelectedIndex;

  // New field for repair estimations
  List<Map<String, String>> repairEstimations;

  FormData({
    this.namaInspektor = '',
    this.namaCustomer = '',
    this.cabangInspeksi = '',
    this.tanggalInspeksi,
    this.merekKendaraan = '',
    this.tipeKendaraan = '',
    this.tahun = '',
    this.transmisi = '',
    this.warnaKendaraan = '',
    this.odometer = '',
    this.kepemilikan = '',
    this.platNomor = '',
    this.pajak1TahunDate,
    this.pajak5TahunDate,
    this.biayaPajak = '',
    this.bukuService,
    this.kunciSerep,
    this.bukuManual,
    this.banSerep,
    this.bpkp,
    this.dongkrak,
    this.toolkit,
    this.noRangka,
    this.noMesin,
    this.indikasiTabrakan,
    this.indikasiBanjir,
    this.indikasiOdometerReset,
    this.posisiBan,
    this.merk,
    this.tipeVelg,
    this.ketebalan,
    this.interiorSelectedIndex,
    this.eksteriorSelectedIndex,
    this.kakiKakiSelectedIndex,
    this.mesinSelectedIndex,
    this.penilaianKeseluruhanSelectedIndex,
    List<Map<String, String>>? repairEstimations,
  }) : repairEstimations = repairEstimations ?? [];

  // Add methods to update data if needed, or update directly
}
