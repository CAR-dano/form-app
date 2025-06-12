import 'package:form_app/models/inspector_data.dart'; // Import Inspector model
import 'package:form_app/models/inspection_branch.dart'; // Import InspectionBranch model
import 'package:uuid/uuid.dart';

class FormData {
  String id; // Unique ID for the form instance
  // Page One Data
  String? namaInspektor;
  String? inspectorId;
  Inspector? selectedInspector; // Add field for selected Inspector object
  String namaCustomer;
  InspectionBranch? cabangInspeksi; // Change type to InspectionBranch
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

  // NEW: Fields for ExpandableTextField data (as List<String>)
  List<String>? keteranganInterior;
  List<String>? keteranganEksterior;
  List<String>? keteranganKakiKaki;
  List<String>? keteranganMesin;
  List<String>? deskripsiKeseluruhan;

  // New fields for Page Five One
  int? airbagSelectedValue;
  int? sistemAudioSelectedValue;
  int? powerWindowSelectedValue;
  int? sistemAcSelectedValue;
  int? centralLockSelectedValue; // New field
  int? electricMirrorSelectedValue; // New field
  int? remAbsSelectedValue; // New field
  List<String>? fiturCatatanList;

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
  List<String>? mesinCatatanList;

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
  List<String>? interiorCatatanList;

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
  List<String>? eksteriorCatatanList;

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
  List<String>? banDanKakiKakiCatatanList;

  // New fields for Page Five Six (Test Drive)
  int? bunyiGetaranSelectedValue;
  int? performaStirSelectedValue;
  int? perpindahanTransmisiSelectedValue;
  int? stirBalanceSelectedValue;
  int? performaSuspensiSelectedValue;
  int? performaKoplingSelectedValue;
  int? rpmSelectedValue;
  List<String>? testDriveCatatanList;

  // New fields for Page Five Seven (Tools Test)
  int? tebalCatBodyDepanSelectedValue;
  int? tebalCatBodyKiriSelectedValue;
  int? temperatureAcMobilSelectedValue;
  int? tebalCatBodyKananSelectedValue;
  int? tebalCatBodyBelakangSelectedValue;
  int? obdScannerSelectedValue;
  int? tebalCatBodyAtapSelectedValue;
  int? testAccuSelectedValue;
  List<String>? toolsTestCatatanList;

  // New field for repair estimations
  List<Map<String, String>> repairEstimations;

  String? catDepanKap;
  String? catBelakangBumper;
  String? catBelakangTrunk;
  String? catKananFenderDepan;
  String? catKananPintuDepan;
  String? catKananPintuBelakang;
  String? catKananFenderBelakang; 
  String? catKiriFenderDepan;
  String? catKiriPintuDepan;
  String? catKiriPintuBelakang;
  String? catKiriFenderBelakang;
  String? catKiriSideSkirt;
  String? catKananSideSkirt;
  int currentPageIndex; // New field to store the current page index


  FormData({
    String? id, // Make id optional in constructor for existing data
    this.currentPageIndex = 0, // Initialize with 0
    this.inspectorId,
    this.namaInspektor,
    this.selectedInspector,
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
    this.centralLockSelectedValue, // New field
    this.electricMirrorSelectedValue, // New field
    this.remAbsSelectedValue, // New field
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
    //new fields for page eight
    this.catDepanKap,
    this.catBelakangBumper,
    this.catBelakangTrunk,
    this.catKananFenderDepan,
    this.catKananPintuDepan,
    this.catKananPintuBelakang,
    this.catKananFenderBelakang,
    this.catKiriFenderDepan,
    this.catKiriPintuDepan,
    this.catKiriPintuBelakang,
    this.catKiriFenderBelakang,
    this.catKiriSideSkirt,
    this.catKananSideSkirt,
  }) : id = id ?? const Uuid().v4(); // Generate ID if not provided
  // Add methods to update data if needed, or update directly

  Map<String, dynamic> toJson() {
    return {
      'id': id, // Include id in toJson
      'namaInspektor': namaInspektor,
      'inspectorId': inspectorId,
      'namaCustomer': namaCustomer,
      'cabangInspeksi': cabangInspeksi != null ? {'id': cabangInspeksi!.id, 'city': cabangInspeksi!.city} : null,
      'tanggalInspeksi': tanggalInspeksi?.toIso8601String(),
      'merekKendaraan': merekKendaraan,
      'tipeKendaraan': tipeKendaraan,
      'tahun': tahun,
      'transmisi': transmisi,
      'warnaKendaraan': warnaKendaraan,
      'odometer': odometer,
      'kepemilikan': kepemilikan,
      'platNomor': platNomor,
      'pajak1TahunDate': pajak1TahunDate?.toIso8601String(),
      'pajak5TahunDate': pajak5TahunDate?.toIso8601String(),
      'biayaPajak': biayaPajak,
      'bukuService': bukuService,
      'kunciSerep': kunciSerep,
      'bukuManual': bukuManual,
      'banSerep': banSerep,
      'bpkb': bpkb,
      'dongkrak': dongkrak,
      'toolkit': toolkit,
      'noRangka': noRangka,
      'noMesin': noMesin,
      'indikasiTabrakan': indikasiTabrakan,
      'indikasiBanjir': indikasiBanjir,
      'indikasiOdometerReset': indikasiOdometerReset,
      'posisiBan': posisiBan,
      'merk': merk,
      'tipeVelg': tipeVelg,
      'ketebalan': ketebalan,
      'interiorSelectedValue': interiorSelectedValue,
      'eksteriorSelectedValue': eksteriorSelectedValue,
      'kakiKakiSelectedValue': kakiKakiSelectedValue,
      'mesinSelectedValue': mesinSelectedValue,
      'keteranganInterior': keteranganInterior,
      'keteranganEksterior': keteranganEksterior,
      'keteranganKakiKaki': keteranganKakiKaki,
      'keteranganMesin': keteranganMesin,
      'deskripsiKeseluruhan': deskripsiKeseluruhan,
      'repairEstimations': repairEstimations,
      'airbagSelectedValue': airbagSelectedValue,
      'sistemAudioSelectedValue': sistemAudioSelectedValue,
      'powerWindowSelectedValue': powerWindowSelectedValue,
      'sistemAcSelectedValue': sistemAcSelectedValue,
      'centralLockSelectedValue': centralLockSelectedValue, // New field
      'electricMirrorSelectedValue': electricMirrorSelectedValue, // New field
      'remAbsSelectedValue': remAbsSelectedValue, // New field
      'fiturCatatanList': fiturCatatanList,
      'getaranMesinSelectedValue': getaranMesinSelectedValue,
      'suaraMesinSelectedValue': suaraMesinSelectedValue,
      'transmisiSelectedValue': transmisiSelectedValue,
      'pompaPowerSteeringSelectedValue': pompaPowerSteeringSelectedValue,
      'coverTimingChainSelectedValue': coverTimingChainSelectedValue,
      'oliPowerSteeringSelectedValue': oliPowerSteeringSelectedValue,
      'accuSelectedValue': accuSelectedValue,
      'kompressorAcSelectedValue': kompressorAcSelectedValue,
      'fanSelectedValue': fanSelectedValue,
      'selangSelectedValue': selangSelectedValue,
      'karterOliSelectedValue': karterOliSelectedValue,
      'oilRemSelectedValue': oilRemSelectedValue,
      'kabelSelectedValue': kabelSelectedValue,
      'kondensorSelectedValue': kondensorSelectedValue,
      'radiatorSelectedValue': radiatorSelectedValue,
      'cylinderHeadSelectedValue': cylinderHeadSelectedValue,
      'oliMesinSelectedValue': oliMesinSelectedValue,
      'airRadiatorSelectedValue': airRadiatorSelectedValue,
      'coverKlepSelectedValue': coverKlepSelectedValue,
      'alternatorSelectedValue': alternatorSelectedValue,
      'waterPumpSelectedValue': waterPumpSelectedValue,
      'beltSelectedValue': beltSelectedValue,
      'oliTransmisiSelectedValue': oliTransmisiSelectedValue,
      'cylinderBlockSelectedValue': cylinderBlockSelectedValue,
      'bushingBesarSelectedValue': bushingBesarSelectedValue,
      'bushingKecilSelectedValue': bushingKecilSelectedValue,
      'tutupRadiatorSelectedValue': tutupRadiatorSelectedValue,
      'mesinCatatanList': mesinCatatanList,
      'stirSelectedValue': stirSelectedValue,
      'remTanganSelectedValue': remTanganSelectedValue,
      'pedalSelectedValue': pedalSelectedValue,
      'switchWiperSelectedValue': switchWiperSelectedValue,
      'lampuHazardSelectedValue': lampuHazardSelectedValue,
      'panelDashboardSelectedValue': panelDashboardSelectedValue,
      'pembukaKapMesinSelectedValue': pembukaKapMesinSelectedValue,
      'pembukaBagasiSelectedValue': pembukaBagasiSelectedValue,
      'jokDepanSelectedValue': jokDepanSelectedValue,
      'aromaInteriorSelectedValue': aromaInteriorSelectedValue,
      'handlePintuSelectedValue': handlePintuSelectedValue,
      'consoleBoxSelectedValue': consoleBoxSelectedValue,
      'spionTengahSelectedValue': spionTengahSelectedValue,
      'tuasPersnelingSelectedValue': tuasPersnelingSelectedValue,
      'jokBelakangSelectedValue': jokBelakangSelectedValue,
      'panelIndikatorSelectedValue': panelIndikatorSelectedValue,
      'switchLampuSelectedValue': switchLampuSelectedValue,
      'karpetDasarSelectedValue': karpetDasarSelectedValue,
      'klaksonSelectedValue': klaksonSelectedValue,
      'sunVisorSelectedValue': sunVisorSelectedValue,
      'tuasTangkiBensinSelectedValue': tuasTangkiBensinSelectedValue,
      'sabukPengamanSelectedValue': sabukPengamanSelectedValue,
      'trimInteriorSelectedValue': trimInteriorSelectedValue,
      'plafonSelectedValue': plafonSelectedValue,
      'interiorCatatanList': interiorCatatanList,
      'bumperDepanSelectedValue': bumperDepanSelectedValue,
      'kapMesinSelectedValue': kapMesinSelectedValue,
      'lampuUtamaSelectedValue': lampuUtamaSelectedValue,
      'panelAtapSelectedValue': panelAtapSelectedValue,
      'grillSelectedValue': grillSelectedValue,
      'lampuFoglampSelectedValue': lampuFoglampSelectedValue,
      'kacaBeningSelectedValue': kacaBeningSelectedValue,
      'wiperBelakangSelectedValue': wiperBelakangSelectedValue,
      'bumperBelakangSelectedValue': bumperBelakangSelectedValue,
      'lampuBelakangSelectedValue': lampuBelakangSelectedValue,
      'trunklidSelectedValue': trunklidSelectedValue,
      'kacaDepanSelectedValue': kacaDepanSelectedValue,
      'fenderKananSelectedValue': fenderKananSelectedValue,
      'quarterPanelKananSelectedValue': quarterPanelKananSelectedValue,
      'pintuBelakangKananSelectedValue': pintuBelakangKananSelectedValue,
      'spionKananSelectedValue': spionKananSelectedValue,
      'lisplangKananSelectedValue': lisplangKananSelectedValue,
      'sideSkirtKananSelectedValue': sideSkirtKananSelectedValue,
      'daunWiperSelectedValue': daunWiperSelectedValue,
      'pintuBelakangSelectedValue': pintuBelakangSelectedValue,
      'fenderKiriSelectedValue': fenderKiriSelectedValue,
      'quarterPanelKiriSelectedValue': quarterPanelKiriSelectedValue,
      'pintuDepanSelectedValue': pintuDepanSelectedValue,
      'kacaJendelaKananSelectedValue': kacaJendelaKananSelectedValue,
      'pintuBelakangKiriSelectedValue': pintuBelakangKiriSelectedValue,
      'spionKiriSelectedValue': spionKiriSelectedValue,
      'pintuDepanKiriSelectedValue': pintuDepanKiriSelectedValue,
      'kacaJendelaKiriSelectedValue': kacaJendelaKiriSelectedValue,
      'lisplangKiriSelectedValue': lisplangKiriSelectedValue,
      'sideSkirtKiriSelectedValue': sideSkirtKiriSelectedValue,
      'eksteriorCatatanList': eksteriorCatatanList,
      'banDepanSelectedValue': banDepanSelectedValue,
      'velgDepanSelectedValue': velgDepanSelectedValue,
      'discBrakeSelectedValue': discBrakeSelectedValue,
      'masterRemSelectedValue': masterRemSelectedValue,
      'tieRodSelectedValue': tieRodSelectedValue,
      'gardanSelectedValue': gardanSelectedValue,
      'banBelakangSelectedValue': banBelakangSelectedValue,
      'velgBelakangSelectedValue': velgBelakangSelectedValue,
      'brakePadSelectedValue': brakePadSelectedValue,
      'crossmemberSelectedValue': crossmemberSelectedValue,
      'knalpotSelectedValue': knalpotSelectedValue,
      'balljointSelectedValue': balljointSelectedValue,
      'rocksteerSelectedValue': rocksteerSelectedValue,
      'karetBootSelectedValue': karetBootSelectedValue,
      'upperLowerArmSelectedValue': upperLowerArmSelectedValue,
      'shockBreakerSelectedValue': shockBreakerSelectedValue,
      'linkStabilizerSelectedValue': linkStabilizerSelectedValue,
      'banDanKakiKakiCatatanList': banDanKakiKakiCatatanList,
      'bunyiGetaranSelectedValue': bunyiGetaranSelectedValue,
      'performaStirSelectedValue': performaStirSelectedValue,
      'perpindahanTransmisiSelectedValue': perpindahanTransmisiSelectedValue,
      'stirBalanceSelectedValue': stirBalanceSelectedValue,
      'performaSuspensiSelectedValue': performaSuspensiSelectedValue,
      'performaKoplingSelectedValue': performaKoplingSelectedValue,
      'rpmSelectedValue': rpmSelectedValue,
      'testDriveCatatanList': testDriveCatatanList,
      'tebalCatBodyDepanSelectedValue': tebalCatBodyDepanSelectedValue,
      'tebalCatBodyKiriSelectedValue': tebalCatBodyKiriSelectedValue,
      'temperatureAcMobilSelectedValue': temperatureAcMobilSelectedValue,
      'tebalCatBodyKananSelectedValue': tebalCatBodyKananSelectedValue,
      'tebalCatBodyBelakangSelectedValue': tebalCatBodyBelakangSelectedValue,
      'obdScannerSelectedValue': obdScannerSelectedValue,
      'tebalCatBodyAtapSelectedValue': tebalCatBodyAtapSelectedValue,
      'testAccuSelectedValue': testAccuSelectedValue,
      'toolsTestCatatanList': toolsTestCatatanList,
      'catDepanKap': catDepanKap,
      'catBelakangBumper': catBelakangBumper,
      'catBelakangTrunk': catBelakangTrunk,
      'catKananFenderDepan': catKananFenderDepan,
      'catKananPintuDepan': catKananPintuDepan,
      'catKananPintuBelakang': catKananPintuBelakang,
      'catKananFenderBelakang': catKananFenderBelakang,
      'catKiriFenderDepan': catKiriFenderDepan,
      'catKiriPintuDepan': catKiriPintuDepan,
      'catKiriPintuBelakang': catKiriPintuBelakang,
      'catKiriFenderBelakang': catKiriFenderBelakang,
      'catKiriSideSkirt': catKiriSideSkirt,
      'catKananSideSkirt': catKananSideSkirt,
      'currentPageIndex': currentPageIndex, // Include in toJson
    };
  }

  factory FormData.fromJson(Map<String, dynamic> json) {
    return FormData(
      id: json['id'] as String?, // Parse id from json
      currentPageIndex: json['currentPageIndex'] as int? ?? 0, // Parse from json, default to 0
      namaInspektor: json['namaInspektor'] as String?,
      inspectorId: json['inspectorId'] as String?,
      namaCustomer: json['namaCustomer'] as String? ?? '',
      cabangInspeksi: json['cabangInspeksi'] != null
          ? InspectionBranch.fromJson(json['cabangInspeksi'] as Map<String, dynamic>)
          : null,
      tanggalInspeksi: json['tanggalInspeksi'] != null
          ? DateTime.parse(json['tanggalInspeksi'] as String)
          : null,
      merekKendaraan: json['merekKendaraan'] as String? ?? '',
      tipeKendaraan: json['tipeKendaraan'] as String? ?? '',
      tahun: json['tahun'] as String? ?? '',
      transmisi: json['transmisi'] as String? ?? '',
      warnaKendaraan: json['warnaKendaraan'] as String? ?? '',
      odometer: json['odometer'] as String? ?? '',
      kepemilikan: json['kepemilikan'] as String? ?? '',
      platNomor: json['platNomor'] as String? ?? '',
      pajak1TahunDate: json['pajak1TahunDate'] != null
          ? DateTime.parse(json['pajak1TahunDate'] as String)
          : null,
      pajak5TahunDate: json['pajak5TahunDate'] != null
          ? DateTime.parse(json['pajak5TahunDate'] as String)
          : null,
      biayaPajak: json['biayaPajak'] as String? ?? '',
      bukuService: json['bukuService'] as String?,
      kunciSerep: json['kunciSerep'] as String?,
      bukuManual: json['bukuManual'] as String?,
      banSerep: json['banSerep'] as String?,
      bpkb: json['bpkb'] as String?,
      dongkrak: json['dongkrak'] as String?,
      toolkit: json['toolkit'] as String?,
      noRangka: json['noRangka'] as String?,
      noMesin: json['noMesin'] as String?,
      indikasiTabrakan: json['indikasiTabrakan'] as String?,
      indikasiBanjir: json['indikasiBanjir'] as String?,
      indikasiOdometerReset: json['indikasiOdometerReset'] as String?,
      posisiBan: json['posisiBan'] as String?,
      merk: json['merk'] as String?,
      tipeVelg: json['tipeVelg'] as String?,
      ketebalan: json['ketebalan'] as String?,
      interiorSelectedValue: json['interiorSelectedValue'] as int?,
      eksteriorSelectedValue: json['eksteriorSelectedValue'] as int?,
      kakiKakiSelectedValue: json['kakiKakiSelectedValue'] as int?,
      mesinSelectedValue: json['mesinSelectedValue'] as int?,
      keteranganInterior: (json['keteranganInterior'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      keteranganEksterior: (json['keteranganEksterior'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      keteranganKakiKaki: (json['keteranganKakiKaki'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      keteranganMesin: (json['keteranganMesin'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      deskripsiKeseluruhan: (json['deskripsiKeseluruhan'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      repairEstimations: (json['repairEstimations'] as List<dynamic>?)
          ?.map((e) => Map<String, String>.from(e as Map))
          .toList() ?? const [],
      airbagSelectedValue: json['airbagSelectedValue'] as int?,
      sistemAudioSelectedValue: json['sistemAudioSelectedValue'] as int?,
      powerWindowSelectedValue: json['powerWindowSelectedValue'] as int?,
      sistemAcSelectedValue: json['sistemAcSelectedValue'] as int?,
      centralLockSelectedValue: json['centralLockSelectedValue'] as int?, // New field
      electricMirrorSelectedValue: json['electricMirrorSelectedValue'] as int?, // New field
      remAbsSelectedValue: json['remAbsSelectedValue'] as int?, // New field
      fiturCatatanList: (json['fiturCatatanList'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      getaranMesinSelectedValue: json['getaranMesinSelectedValue'] as int?,
      suaraMesinSelectedValue: json['suaraMesinSelectedValue'] as int?,
      transmisiSelectedValue: json['transmisiSelectedValue'] as int?,
      pompaPowerSteeringSelectedValue: json['pompaPowerSteeringSelectedValue'] as int?,
      coverTimingChainSelectedValue: json['coverTimingChainSelectedValue'] as int?,
      oliPowerSteeringSelectedValue: json['oliPowerSteeringSelectedValue'] as int?,
      accuSelectedValue: json['accuSelectedValue'] as int?,
      kompressorAcSelectedValue: json['kompressorAcSelectedValue'] as int?,
      fanSelectedValue: json['fanSelectedValue'] as int?,
      selangSelectedValue: json['selangSelectedValue'] as int?,
      karterOliSelectedValue: json['karterOliSelectedValue'] as int?,
      oilRemSelectedValue: json['oilRemSelectedValue'] as int?,
      kabelSelectedValue: json['kabelSelectedValue'] as int?,
      kondensorSelectedValue: json['kondensorSelectedValue'] as int?,
      radiatorSelectedValue: json['radiatorSelectedValue'] as int?,
      cylinderHeadSelectedValue: json['cylinderHeadSelectedValue'] as int?,
      oliMesinSelectedValue: json['oliMesinSelectedValue'] as int?,
      airRadiatorSelectedValue: json['airRadiatorSelectedValue'] as int?,
      coverKlepSelectedValue: json['coverKlepSelectedValue'] as int?,
      alternatorSelectedValue: json['alternatorSelectedValue'] as int?,
      waterPumpSelectedValue: json['waterPumpSelectedValue'] as int?,
      beltSelectedValue: json['beltSelectedValue'] as int?,
      oliTransmisiSelectedValue: json['oliTransmisiSelectedValue'] as int?,
      cylinderBlockSelectedValue: json['cylinderBlockSelectedValue'] as int?,
      bushingBesarSelectedValue: json['bushingBesarSelectedValue'] as int?,
      bushingKecilSelectedValue: json['bushingKecilSelectedValue'] as int?,
      tutupRadiatorSelectedValue: json['tutupRadiatorSelectedValue'] as int?,
      mesinCatatanList: (json['mesinCatatanList'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      stirSelectedValue: json['stirSelectedValue'] as int?,
      remTanganSelectedValue: json['remTanganSelectedValue'] as int?,
      pedalSelectedValue: json['pedalSelectedValue'] as int?,
      switchWiperSelectedValue: json['switchWiperSelectedValue'] as int?,
      lampuHazardSelectedValue: json['lampuHazardSelectedValue'] as int?,
      panelDashboardSelectedValue: json['panelDashboardSelectedValue'] as int?,
      pembukaKapMesinSelectedValue: json['pembukaKapMesinSelectedValue'] as int?,
      pembukaBagasiSelectedValue: json['pembukaBagasiSelectedValue'] as int?,
      jokDepanSelectedValue: json['jokDepanSelectedValue'] as int?,
      aromaInteriorSelectedValue: json['aromaInteriorSelectedValue'] as int?,
      handlePintuSelectedValue: json['handlePintuSelectedValue'] as int?,
      consoleBoxSelectedValue: json['consoleBoxSelectedValue'] as int?,
      spionTengahSelectedValue: json['spionTengahSelectedValue'] as int?,
      tuasPersnelingSelectedValue: json['tuasPersnelingSelectedValue'] as int?,
      jokBelakangSelectedValue: json['jokBelakangSelectedValue'] as int?,
      panelIndikatorSelectedValue: json['panelIndikatorSelectedValue'] as int?,
      switchLampuSelectedValue: json['switchLampuSelectedValue'] as int?,
      karpetDasarSelectedValue: json['karpetDasarSelectedValue'] as int?,
      klaksonSelectedValue: json['klaksonSelectedValue'] as int?,
      sunVisorSelectedValue: json['sunVisorSelectedValue'] as int?,
      tuasTangkiBensinSelectedValue: json['tuasTangkiBensinSelectedValue'] as int?,
      sabukPengamanSelectedValue: json['sabukPengamanSelectedValue'] as int?,
      trimInteriorSelectedValue: json['trimInteriorSelectedValue'] as int?,
      plafonSelectedValue: json['plafonSelectedValue'] as int?,
      interiorCatatanList: (json['interiorCatatanList'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      bumperDepanSelectedValue: json['bumperDepanSelectedValue'] as int?,
      kapMesinSelectedValue: json['kapMesinSelectedValue'] as int?,
      lampuUtamaSelectedValue: json['lampuUtamaSelectedValue'] as int?,
      panelAtapSelectedValue: json['panelAtapSelectedValue'] as int?,
      grillSelectedValue: json['grillSelectedValue'] as int?,
      lampuFoglampSelectedValue: json['lampuFoglampSelectedValue'] as int?,
      kacaBeningSelectedValue: json['kacaBeningSelectedValue'] as int?,
      wiperBelakangSelectedValue: json['wiperBelakangSelectedValue'] as int?,
      bumperBelakangSelectedValue: json['bumperBelakangSelectedValue'] as int?,
      lampuBelakangSelectedValue: json['lampuBelakangSelectedValue'] as int?,
      trunklidSelectedValue: json['trunklidSelectedValue'] as int?,
      kacaDepanSelectedValue: json['kacaDepanSelectedValue'] as int?,
      fenderKananSelectedValue: json['fenderKananSelectedValue'] as int?,
      quarterPanelKananSelectedValue: json['quarterPanelKananSelectedValue'] as int?,
      pintuBelakangKananSelectedValue: json['pintuBelakangKananSelectedValue'] as int?,
      spionKananSelectedValue: json['spionKananSelectedValue'] as int?,
      lisplangKananSelectedValue: json['lisplangKananSelectedValue'] as int?,
      sideSkirtKananSelectedValue: json['sideSkirtKananSelectedValue'] as int?,
      daunWiperSelectedValue: json['daunWiperSelectedValue'] as int?,
      pintuBelakangSelectedValue: json['pintuBelakangSelectedValue'] as int?,
      fenderKiriSelectedValue: json['fenderKiriSelectedValue'] as int?,
      quarterPanelKiriSelectedValue: json['quarterPanelKiriSelectedValue'] as int?,
      pintuDepanSelectedValue: json['pintuDepanSelectedValue'] as int?,
      kacaJendelaKananSelectedValue: json['kacaJendelaKananSelectedValue'] as int?,
      pintuBelakangKiriSelectedValue: json['pintuBelakangKiriSelectedValue'] as int?,
      spionKiriSelectedValue: json['spionKiriSelectedValue'] as int?,
      pintuDepanKiriSelectedValue: json['pintuDepanKiriSelectedValue'] as int?,
      kacaJendelaKiriSelectedValue: json['kacaJendelaKiriSelectedValue'] as int?,
      lisplangKiriSelectedValue: json['lisplangKiriSelectedValue'] as int?,
      sideSkirtKiriSelectedValue: json['sideSkirtKiriSelectedValue'] as int?,
      eksteriorCatatanList: (json['eksteriorCatatanList'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      banDepanSelectedValue: json['banDepanSelectedValue'] as int?,
      velgDepanSelectedValue: json['velgDepanSelectedValue'] as int?,
      discBrakeSelectedValue: json['discBrakeSelectedValue'] as int?,
      masterRemSelectedValue: json['masterRemSelectedValue'] as int?,
      tieRodSelectedValue: json['tieRodSelectedValue'] as int?,
      gardanSelectedValue: json['gardanSelectedValue'] as int?,
      banBelakangSelectedValue: json['banBelakangSelectedValue'] as int?,
      velgBelakangSelectedValue: json['velgBelakangSelectedValue'] as int?,
      brakePadSelectedValue: json['brakePadSelectedValue'] as int?,
      crossmemberSelectedValue: json['crossmemberSelectedValue'] as int?,
      knalpotSelectedValue: json['knalpotSelectedValue'] as int?,
      balljointSelectedValue: json['balljointSelectedValue'] as int?,
      rocksteerSelectedValue: json['rocksteerSelectedValue'] as int?,
      karetBootSelectedValue: json['karetBootSelectedValue'] as int?,
      upperLowerArmSelectedValue: json['upperLowerArmSelectedValue'] as int?,
      shockBreakerSelectedValue: json['shockBreakerSelectedValue'] as int?,
      linkStabilizerSelectedValue: json['linkStabilizerSelectedValue'] as int?,
      banDanKakiKakiCatatanList: (json['banDanKakiKakiCatatanList'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      bunyiGetaranSelectedValue: json['bunyiGetaranSelectedValue'] as int?,
      performaStirSelectedValue: json['performaStirSelectedValue'] as int?,
      perpindahanTransmisiSelectedValue: json['perpindahanTransmisiSelectedValue'] as int?,
      stirBalanceSelectedValue: json['stirBalanceSelectedValue'] as int?,
      performaSuspensiSelectedValue: json['performaSuspensiSelectedValue'] as int?,
      performaKoplingSelectedValue: json['performaKoplingSelectedValue'] as int?,
      rpmSelectedValue: json['rpmSelectedValue'] as int?,
      testDriveCatatanList: (json['testDriveCatatanList'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      tebalCatBodyDepanSelectedValue: json['tebalCatBodyDepanSelectedValue'] as int?,
      tebalCatBodyKiriSelectedValue: json['tebalCatBodyKiriSelectedValue'] as int?,
      temperatureAcMobilSelectedValue: json['temperatureAcMobilSelectedValue'] as int?,
      tebalCatBodyKananSelectedValue: json['tebalCatBodyKananSelectedValue'] as int?,
      tebalCatBodyBelakangSelectedValue: json['tebalCatBodyBelakangSelectedValue'] as int?,
      obdScannerSelectedValue: json['obdScannerSelectedValue'] as int?,
      tebalCatBodyAtapSelectedValue: json['tebalCatBodyAtapSelectedValue'] as int?,
      testAccuSelectedValue: json['testAccuSelectedValue'] as int?,
      toolsTestCatatanList: (json['toolsTestCatatanList'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const [],
      catDepanKap: json['catDepanKap'] as String?,
      catBelakangBumper: json['catBelakangBumper'] as String?,
      catBelakangTrunk: json['catBelakangTrunk'] as String?,
      catKananFenderDepan: json['catKananFenderDepan'] as String?,
      catKananPintuDepan: json['catKananPintuDepan'] as String?,
      catKananPintuBelakang: json['catKananPintuBelakang'] as String?,
      catKananFenderBelakang: json['catKananFenderBelakang'] as String?,
      catKiriFenderDepan: json['catKiriFenderDepan'] as String?,
      catKiriPintuDepan: json['catKiriPintuDepan'] as String?,
      catKiriPintuBelakang: json['catKiriPintuBelakang'] as String?,
      catKiriFenderBelakang: json['catKiriFenderBelakang'] as String?,
      catKiriSideSkirt: json['catKiriSideSkirt'] as String?,
      catKananSideSkirt: json['catKananSideSkirt'] as String?,
    );
  }

  FormData copyWith({
    String? namaInspektor,
    String? inspectorId,
    Inspector? selectedInspector,
    String? namaCustomer,
    InspectionBranch? cabangInspeksi, // Change type to InspectionBranch
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
    int? centralLockSelectedValue, // New field
    int? electricMirrorSelectedValue, // New field
    int? remAbsSelectedValue, // New field
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
    String? catDepanKap,
    String? catBelakangBumper,
    String? catBelakangTrunk,
    String? catKananFenderDepan,
    String? catKananPintuDepan,
    String? catKananPintuBelakang,
    String? catKananFenderBelakang,
    String? catKiriFenderDepan,
    String? catKiriPintuDepan,
    String? catKiriPintuBelakang,
    String? catKiriFenderBelakang,
    String? catKiriSideSkirt,
    String? catKananSideSkirt,
    int? currentPageIndex, // Add to copyWith
  }) {
    return FormData(
      id: id, // Include id in copyWith
      currentPageIndex: currentPageIndex ?? this.currentPageIndex, // Copy current page index
      namaInspektor: namaInspektor ?? this.namaInspektor,
      inspectorId: inspectorId ?? this.inspectorId,
      selectedInspector: selectedInspector ?? this.selectedInspector,
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
      centralLockSelectedValue: centralLockSelectedValue ?? this.centralLockSelectedValue, // New field
      electricMirrorSelectedValue: electricMirrorSelectedValue ?? this.electricMirrorSelectedValue, // New field
      remAbsSelectedValue: remAbsSelectedValue ?? this.remAbsSelectedValue, // New field
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

      // fields for page eight
      catDepanKap: catDepanKap ?? this.catDepanKap,
      catBelakangBumper: catBelakangBumper ?? this.catBelakangBumper,
      catBelakangTrunk: catBelakangTrunk ?? this.catBelakangTrunk,
      catKananFenderDepan: catKananFenderDepan ?? this.catKananFenderDepan,
      catKananPintuDepan: catKananPintuDepan ?? this.catKananPintuDepan,
      catKananPintuBelakang: catKananPintuBelakang ?? this.catKananPintuBelakang,
      catKananFenderBelakang: catKananFenderBelakang ?? this.catKananFenderBelakang,
      catKiriFenderDepan: catKiriFenderDepan ?? this.catKiriFenderDepan,
      catKiriPintuDepan: catKiriPintuDepan ?? this.catKiriPintuDepan,
      catKiriPintuBelakang: catKiriPintuBelakang ?? this.catKiriPintuBelakang,
      catKiriFenderBelakang: catKiriFenderBelakang ?? this.catKiriFenderBelakang,
      catKiriSideSkirt: catKiriSideSkirt ?? this.catKiriSideSkirt,
      catKananSideSkirt: catKananSideSkirt ?? this.catKananSideSkirt,
    );
  }
}
