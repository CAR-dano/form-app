import 'package:form_app/models/inspector_data.dart'; // Import Inspector model

class FormData {
  // Page One Data
  String? namaInspektor;
  String? inspectorId;
  Inspector? selectedInspector; // Add field for selected Inspector object
  String namaCustomer;
  String? cabangInspeksi;
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
  String? bpkb;
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
  int? interiorSelectedValue;
  int? eksteriorSelectedValue;
  int? kakiKakiSelectedValue;
  int? mesinSelectedValue;
  int? penilaianKeseluruhanSelectedValue;

  // NEW: Fields for ExpandableTextField data (as List<String>)
  List<String> keteranganInterior;
  List<String> keteranganEksterior;
  List<String> keteranganKakiKaki;
  List<String> keteranganMesin;
  List<String> deskripsiKeseluruhan;

  // New fields for Page Five One
  int? airbagSelectedValue;
  int? sistemAudioSelectedValue;
  int? powerWindowSelectedValue;
  int? sistemAcSelectedValue;
  List<String> fiturCatatanList;

  // New fields for Page Five Two
  int? getaranMesinSelectedValue;
  int? suaraMesinSelectedValue;
  int? transmisiSelectedValue;
  int? pompaPowerSteeringSelectedValue;
  int? coverTimingChainSelectedValue;
  int? oliPowerSteeringSelectedValue;
  int? accuSelectedValue;
  int? kompressorAcSelectedValue;
  int? fanSelectedValue;
  int? selangSelectedValue;
  int? karterOliSelectedValue;
  int? oilRemSelectedValue;
  int? kabelSelectedValue;
  int? kondensorSelectedValue;
  int? radiatorSelectedValue;
  int? cylinderHeadSelectedValue;
  int? oliMesinSelectedValue;
  int? airRadiatorSelectedValue;
  int? coverKlepSelectedValue;
  int? alternatorSelectedValue;
  int? waterPumpSelectedValue;
  int? beltSelectedValue;
  int? oliTransmisiSelectedValue;
  int? cylinderBlockSelectedValue;
  int? bushingBesarSelectedValue;
  int? bushingKecilSelectedValue;
  int? tutupRadiatorSelectedValue;
  List<String> mesinCatatanList;

  // New fields for Page Five Three
  int? stirSelectedValue;
  int? remTanganSelectedValue;
  int? pedalSelectedValue;
  int? switchWiperSelectedValue;
  int? lampuHazardSelectedValue;
  int? panelDashboardSelectedValue;
  int? pembukaKapMesinSelectedValue;
  int? pembukaBagasiSelectedValue;
  int? jokDepanSelectedValue;
  int? aromaInteriorSelectedValue;
  int? handlePintuSelectedValue;
  int? consoleBoxSelectedValue;
  int? spionTengahSelectedValue;
  int? tuasPersnelingSelectedValue;
  int? jokBelakangSelectedValue;
  int? panelIndikatorSelectedValue;
  int? switchLampuSelectedValue;
  int? karpetDasarSelectedValue;
  int? klaksonSelectedValue;
  int? sunVisorSelectedValue;
  int? tuasTangkiBensinSelectedValue;
  int? sabukPengamanSelectedValue;
  int? trimInteriorSelectedValue;
  int? plafonSelectedValue;
  List<String> interiorCatatanList;

  // New fields for Page Five Four
  int? bumperDepanSelectedValue;
  int? kapMesinSelectedValue;
  int? lampuUtamaSelectedValue;
  int? panelAtapSelectedValue;
  int? grillSelectedValue;
  int? lampuFoglampSelectedValue;
  int? kacaBeningSelectedValue;
  int? wiperBelakangSelectedValue;
  int? bumperBelakangSelectedValue;
  int? lampuBelakangSelectedValue;
  int? trunklidSelectedValue;
  int? kacaDepanSelectedValue;
  int? fenderKananSelectedValue;
  int? quarterPanelKananSelectedValue;
  int? pintuBelakangKananSelectedValue;
  int? spionKananSelectedValue;
  int? lisplangKananSelectedValue;
  int? sideSkirtKananSelectedValue;
  int? daunWiperSelectedValue;
  int? pintuBelakangSelectedValue;
  int? fenderKiriSelectedValue;
  int? quarterPanelKiriSelectedValue;
  int? pintuDepanSelectedValue;
  int? kacaJendelaKananSelectedValue;
  int? pintuBelakangKiriSelectedValue;
  int? spionKiriSelectedValue;
  int? pintuDepanKiriSelectedValue;
  int? kacaJendelaKiriSelectedValue;
  int? lisplangKiriSelectedValue;
  int? sideSkirtKiriSelectedValue;
  List<String> eksteriorCatatanList;

  // New fields for Page Five Five
  int? banDepanSelectedValue;
  int? velgDepanSelectedValue;
  int? discBrakeSelectedValue;
  int? masterRemSelectedValue;
  int? tieRodSelectedValue;
  int? gardanSelectedValue;
  int? banBelakangSelectedValue;
  int? velgBelakangSelectedValue;
  int? brakePadSelectedValue;
  int? crossmemberSelectedValue;
  int? knalpotSelectedValue;
  int? balljointSelectedValue;
  int? rocksteerSelectedValue;
  int? karetBootSelectedValue;
  int? upperLowerArmSelectedValue;
  int? shockBreakerSelectedValue;
  int? linkStabilizerSelectedValue;
  List<String> banDanKakiKakiCatatanList;

  // New fields for Page Five Six (Test Drive)
  int? bunyiGetaranSelectedValue;
  int? performaStirSelectedValue;
  int? perpindahanTransmisiSelectedValue;
  int? stirBalanceSelectedValue;
  int? performaSuspensiSelectedValue;
  int? performaKoplingSelectedValue;
  int? rpmSelectedValue;
  List<String> testDriveCatatanList;

  // New fields for Page Five Seven (Tools Test)
  int? tebalCatBodyDepanSelectedValue;
  int? tebalCatBodyKiriSelectedValue;
  int? temperatureAcMobilSelectedValue;
  int? tebalCatBodyKananSelectedValue;
  int? tebalCatBodyBelakangSelectedValue;
  int? obdScannerSelectedValue;
  int? tebalCatBodyAtapSelectedValue;
  int? testAccuSelectedValue;
  List<String> toolsTestCatatanList;

  // New field for repair estimations
  List<Map<String, String>> repairEstimations;

  FormData({
    this.inspectorId,
    this.namaInspektor,
    this.selectedInspector, // Add to constructor
    this.namaCustomer = '',
    this.cabangInspeksi,
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
    this.bpkb,
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
    this.interiorSelectedValue,
    this.eksteriorSelectedValue,
    this.kakiKakiSelectedValue,
    this.mesinSelectedValue,
    this.penilaianKeseluruhanSelectedValue,
    this.keteranganInterior = const [],
    this.keteranganEksterior = const [],
    this.keteranganKakiKaki = const [],
    this.keteranganMesin = const [],
    this.deskripsiKeseluruhan = const [],
    this.repairEstimations = const [],
    this.airbagSelectedValue,
    this.sistemAudioSelectedValue,
    this.powerWindowSelectedValue,
    this.sistemAcSelectedValue,
    this.getaranMesinSelectedValue,
    this.fiturCatatanList = const [],
    this.suaraMesinSelectedValue,
    this.transmisiSelectedValue,
    this.pompaPowerSteeringSelectedValue,
    this.coverTimingChainSelectedValue,
    this.oliPowerSteeringSelectedValue,
    this.accuSelectedValue,
    this.kompressorAcSelectedValue,
    this.fanSelectedValue,
    this.selangSelectedValue,
    this.karterOliSelectedValue,
    this.oilRemSelectedValue,
    this.kabelSelectedValue,
    this.kondensorSelectedValue,
    this.radiatorSelectedValue,
    this.cylinderHeadSelectedValue,
    this.oliMesinSelectedValue,
    this.airRadiatorSelectedValue,
    this.coverKlepSelectedValue,
    this.alternatorSelectedValue,
    this.waterPumpSelectedValue,
    this.beltSelectedValue,
    this.oliTransmisiSelectedValue,
    this.cylinderBlockSelectedValue,
    this.bushingBesarSelectedValue,
    this.bushingKecilSelectedValue,
    this.tutupRadiatorSelectedValue,
    this.mesinCatatanList = const [],
    this.stirSelectedValue,
    this.remTanganSelectedValue,
    this.pedalSelectedValue,
    this.switchWiperSelectedValue,
    this.lampuHazardSelectedValue,
    this.panelDashboardSelectedValue,
    this.pembukaKapMesinSelectedValue,
    this.pembukaBagasiSelectedValue,
    this.jokDepanSelectedValue,
    this.aromaInteriorSelectedValue,
    this.handlePintuSelectedValue,
    this.consoleBoxSelectedValue,
    this.spionTengahSelectedValue,
    this.tuasPersnelingSelectedValue,
    this.jokBelakangSelectedValue,
    this.panelIndikatorSelectedValue,
    this.switchLampuSelectedValue,
    this.karpetDasarSelectedValue,
    this.klaksonSelectedValue,
    this.sunVisorSelectedValue,
    this.tuasTangkiBensinSelectedValue,
    this.sabukPengamanSelectedValue,
    this.trimInteriorSelectedValue,
    this.plafonSelectedValue,
    this.interiorCatatanList = const [],
    this.bumperDepanSelectedValue,
    this.kapMesinSelectedValue,
    this.lampuUtamaSelectedValue,
    this.panelAtapSelectedValue,
    this.grillSelectedValue,
    this.lampuFoglampSelectedValue,
    this.kacaBeningSelectedValue,
    this.wiperBelakangSelectedValue,
    this.bumperBelakangSelectedValue,
    this.lampuBelakangSelectedValue,
    this.trunklidSelectedValue,
    this.kacaDepanSelectedValue,
    this.fenderKananSelectedValue,
    this.quarterPanelKananSelectedValue,
    this.pintuBelakangKananSelectedValue,
    this.spionKananSelectedValue,
    this.lisplangKananSelectedValue,
    this.sideSkirtKananSelectedValue,
    this.daunWiperSelectedValue,
    this.pintuBelakangSelectedValue,
    this.fenderKiriSelectedValue,
    this.quarterPanelKiriSelectedValue,
    this.pintuDepanSelectedValue,
    this.kacaJendelaKananSelectedValue,
    this.pintuBelakangKiriSelectedValue,
    this.spionKiriSelectedValue,
    this.pintuDepanKiriSelectedValue,
    this.kacaJendelaKiriSelectedValue,
    this.lisplangKiriSelectedValue,
    this.sideSkirtKiriSelectedValue,
    this.eksteriorCatatanList = const [],
    this.banDepanSelectedValue,
    this.velgDepanSelectedValue,
    this.discBrakeSelectedValue,
    this.masterRemSelectedValue,
    this.tieRodSelectedValue,
    this.gardanSelectedValue,
    this.banBelakangSelectedValue,
    this.velgBelakangSelectedValue,
    this.brakePadSelectedValue,
    this.crossmemberSelectedValue,
    this.knalpotSelectedValue,
    this.balljointSelectedValue,
    this.rocksteerSelectedValue,
    this.karetBootSelectedValue,
    this.upperLowerArmSelectedValue,
    this.shockBreakerSelectedValue,
    this.linkStabilizerSelectedValue,
    this.banDanKakiKakiCatatanList = const [],
    this.bunyiGetaranSelectedValue,
    this.performaStirSelectedValue,
    this.perpindahanTransmisiSelectedValue,
    this.stirBalanceSelectedValue,
    this.performaSuspensiSelectedValue,
    this.performaKoplingSelectedValue,
    this.rpmSelectedValue,
    this.testDriveCatatanList = const [],
    // New fields for Page Five Seven (Tools Test)
    this.tebalCatBodyDepanSelectedValue,
    this.tebalCatBodyKiriSelectedValue,
    this.temperatureAcMobilSelectedValue,
    this.tebalCatBodyKananSelectedValue,
    this.tebalCatBodyBelakangSelectedValue,
    this.obdScannerSelectedValue,
    this.tebalCatBodyAtapSelectedValue,
    this.testAccuSelectedValue,
    this.toolsTestCatatanList = const [],
  });
  // Add methods to update data if needed, or update directly
}
