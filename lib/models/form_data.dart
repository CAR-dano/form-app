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

  // NEW: Fields for ExpandableTextField data (as List<String>)
  List<String> keteranganInterior;
  List<String> keteranganEksterior;
  List<String> keteranganKakiKaki;
  List<String> keteranganMesin;
  List<String> deskripsiKeseluruhan;

  // New fields for Page Five One
  int? airbagSelectedIndex;
  bool? airbagIsEnabled;
  int? sistemAudioSelectedIndex;
  bool? sistemAudioIsEnabled;
  int? powerWindowSelectedIndex;
  bool? powerWindowIsEnabled;
  int? sistemAcSelectedIndex;
  bool? sistemAcIsEnabled;
  String? fiturCatatan;

  // New fields for Page Five Two
  int? getaranMesinSelectedIndex;
  bool? getaranMesinIsEnabled;
  int? suaraMesinSelectedIndex;
  bool? suaraMesinIsEnabled;
  int? transmisiSelectedIndex;
  bool? transmisiIsEnabled;
  int? pompaPowerSteeringSelectedIndex;
  bool? pompaPowerSteeringIsEnabled;
  int? coverTimingChainSelectedIndex;
  bool? coverTimingChainIsEnabled;
  int? oliPowerSteeringSelectedIndex;
  bool? oliPowerSteeringIsEnabled;
  int? accuSelectedIndex;
  bool? accuIsEnabled;
  int? kompressorAcSelectedIndex;
  bool? kompressorAcIsEnabled;
  int? fanSelectedIndex;
  bool? fanIsEnabled;
  int? selangSelectedIndex;
  bool? selangIsEnabled;
  int? karterOliSelectedIndex;
  bool? karterOliIsEnabled;
  int? oilRemSelectedIndex;
  bool? oilRemIsEnabled;
  int? kabelSelectedIndex;
  bool? kabelIsEnabled;
  int? kondensorSelectedIndex;
  bool? kondensorIsEnabled;
  int? radiatorSelectedIndex;
  bool? radiatorIsEnabled;
  int? cylinderHeadSelectedIndex;
  bool? cylinderHeadIsEnabled;
  int? oliMesinSelectedIndex;
  bool? oliMesinIsEnabled;
  int? airRadiatorSelectedIndex;
  bool? airRadiatorIsEnabled;
  int? coverKlepSelectedIndex;
  bool? coverKlepIsEnabled;
  int? alternatorSelectedIndex;
  bool? alternatorIsEnabled;
  int? waterPumpSelectedIndex;
  bool? waterPumpIsEnabled;
  int? beltSelectedIndex;
  bool? beltIsEnabled;
  int? oliTransmisiSelectedIndex;
  bool? oliTransmisiIsEnabled;
  int? cylinderBlockSelectedIndex;
  bool? cylinderBlockIsEnabled;
  int? bushingBesarSelectedIndex;
  bool? bushingBesarIsEnabled;
  int? bushingKecilSelectedIndex;
  bool? bushingKecilIsEnabled;
  int? tutupRadiatorSelectedIndex;
  bool? tutupRadiatorIsEnabled;
  String? mesinCatatan;

  // New fields for Page Five Three
  int? stirSelectedIndex;
  bool? stirIsEnabled;
  int? remTonganSelectedIndex;
  bool? remTonganIsEnabled;
  int? pedalSelectedIndex;
  bool? pedalIsEnabled;
  int? switchWiperSelectedIndex;
  bool? switchWiperIsEnabled;
  int? lampuHazardSelectedIndex;
  bool? lampuHazardIsEnabled;
  int? panelDashboardSelectedIndex;
  bool? panelDashboardIsEnabled;
  int? pembukaKapMesinSelectedIndex;
  bool? pembukaKapMesinIsEnabled;
  int? pembukaBagasiSelectedIndex;
  bool? pembukaBagasiIsEnabled;
  int? jokDepanSelectedIndex;
  bool? jokDepanIsEnabled;
  int? aromaInteriorSelectedIndex;
  bool? aromaInteriorIsEnabled;
  int? handlePintuSelectedIndex;
  bool? handlePintuIsEnabled;
  int? consoleBoxSelectedIndex;
  bool? consoleBoxIsEnabled;
  int? spionTengahSelectedIndex;
  bool? spionTengahIsEnabled;
  int? tuasPersnelingSelectedIndex;
  bool? tuasPersnelingIsEnabled;
  int? jokBelakangSelectedIndex;
  bool? jokBelakangIsEnabled;
  int? panelIndikatorSelectedIndex;
  bool? panelIndikatorIsEnabled;
  int? switchLampuSelectedIndex;
  bool? switchLampuIsEnabled;
  int? karpetDasarSelectedIndex;
  bool? karpetDasarIsEnabled;
  int? klaksonSelectedIndex;
  bool? klaksonIsEnabled;
  int? sunVisorSelectedIndex;
  bool? sunVisorIsEnabled;
  int? tuasTangkiBensinSelectedIndex;
  bool? tuasTangkiBensinIsEnabled;
  int? sabukPengamanSelectedIndex;
  bool? sabukPengamanIsEnabled;
  int? trimInteriorSelectedIndex;
  bool? trimInteriorIsEnabled;
  int? plafonSelectedIndex;
  bool? plafonIsEnabled;
  String? interiorCatatan;

  // New fields for Page Five Four
  int? bumperDepanSelectedIndex;
  bool? bumperDepanIsEnabled;
  int? kapMesinSelectedIndex;
  bool? kapMesinIsEnabled;
  int? lampuUtamaSelectedIndex;
  bool? lampuUtamaIsEnabled;
  int? panelAtapSelectedIndex;
  bool? panelAtapIsEnabled;
  int? grillSelectedIndex;
  bool? grillIsEnabled;
  int? lampuFoglampSelectedIndex;
  bool? lampuFoglampIsEnabled;
  int? kacaBeningSelectedIndex;
  bool? kacaBeningIsEnabled;
  int? wiperBelakangSelectedIndex;
  bool? wiperBelakangIsEnabled;
  int? bumperBelakangSelectedIndex;
  bool? bumperBelakangIsEnabled;
  int? lampuBelakangSelectedIndex;
  bool? lampuBelakangIsEnabled;
  int? trunklidSelectedIndex;
  bool? trunklidIsEnabled;
  int? kacaDepanSelectedIndex;
  bool? kacaDepanIsEnabled;
  int? fenderKananSelectedIndex;
  bool? fenderKananIsEnabled;
  int? quarterPanelKananSelectedIndex;
  bool? quarterPanelKananIsEnabled;
  int? pintuBelakangKananSelectedIndex;
  bool? pintuBelakangKananIsEnabled;
  int? spionKananSelectedIndex;
  bool? spionKananIsEnabled;
  int? lisplangKananSelectedIndex;
  bool? lisplangKananIsEnabled;
  int? sideSkirtKananSelectedIndex;
  bool? sideSkirtKananIsEnabled;
  int? daunWiperSelectedIndex;
  bool? daunWiperIsEnabled;
  int? pintuBelakangSelectedIndex;
  bool? pintuBelakangIsEnabled;
  int? fenderKiriSelectedIndex;
  bool? fenderKiriIsEnabled;
  int? quarterPanelKiriSelectedIndex;
  bool? quarterPanelKiriIsEnabled;
  int? pintuDepanSelectedIndex;
  bool? pintuDepanIsEnabled;
  int? kacaJendelaKananSelectedIndex;
  bool? kacaJendelaKananIsEnabled;
  int? pintuBelakangKiriSelectedIndex;
  bool? pintuBelakangKiriIsEnabled;
  int? spionKiriSelectedIndex;
  bool? spionKiriIsEnabled;
  int? pintuDepanKiriSelectedIndex;
  bool? pintuDepanKiriIsEnabled;
  int? kacaJendelaKiriSelectedIndex;
  bool? kacaJendelaKiriIsEnabled;
  int? lisplangKiriSelectedIndex;
  bool? lisplangKiriIsEnabled;
  int? sideSkirtKiriSelectedIndex;
  bool? sideSkirtKiriIsEnabled;
  String? eksteriorCatatan;


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
    List<String>? keteranganInterior,
    List<String>? keteranganEksterior,
    List<String>? keteranganKakiKaki,
    List<String>? keteranganMesin,
    List<String>? deskripsiKeseluruhan,
    List<Map<String, String>>? repairEstimations,
    this.airbagSelectedIndex,
    this.airbagIsEnabled,
    this.sistemAudioSelectedIndex,
    this.sistemAudioIsEnabled,
    this.powerWindowSelectedIndex,
    this.powerWindowIsEnabled,
    this.sistemAcSelectedIndex,
    this.sistemAcIsEnabled,
    this.fiturCatatan,
    this.getaranMesinSelectedIndex,
    this.getaranMesinIsEnabled,
    this.suaraMesinSelectedIndex,
    this.suaraMesinIsEnabled,
    this.transmisiSelectedIndex,
    this.transmisiIsEnabled,
    this.pompaPowerSteeringSelectedIndex,
    this.pompaPowerSteeringIsEnabled,
    this.coverTimingChainSelectedIndex,
    this.coverTimingChainIsEnabled,
    this.oliPowerSteeringSelectedIndex,
    this.oliPowerSteeringIsEnabled,
    this.accuSelectedIndex,
    this.accuIsEnabled,
    this.kompressorAcSelectedIndex,
    this.kompressorAcIsEnabled,
    this.fanSelectedIndex,
    this.fanIsEnabled,
    this.selangSelectedIndex,
    this.selangIsEnabled,
    this.karterOliSelectedIndex,
    this.karterOliIsEnabled,
    this.oilRemSelectedIndex,
    this.oilRemIsEnabled,
    this.kabelSelectedIndex,
    this.kabelIsEnabled,
    this.kondensorSelectedIndex,
    this.kondensorIsEnabled,
    this.radiatorSelectedIndex,
    this.radiatorIsEnabled,
    this.cylinderHeadSelectedIndex,
    this.cylinderHeadIsEnabled,
    this.oliMesinSelectedIndex,
    this.oliMesinIsEnabled,
    this.airRadiatorSelectedIndex,
    this.airRadiatorIsEnabled,
    this.coverKlepSelectedIndex,
    this.coverKlepIsEnabled,
    this.alternatorSelectedIndex,
    this.alternatorIsEnabled,
    this.waterPumpSelectedIndex,
    this.waterPumpIsEnabled,
    this.beltSelectedIndex,
    this.beltIsEnabled,
    this.oliTransmisiSelectedIndex,
    this.oliTransmisiIsEnabled,
    this.cylinderBlockSelectedIndex,
    this.cylinderBlockIsEnabled,
    this.bushingBesarSelectedIndex,
    this.bushingBesarIsEnabled,
    this.bushingKecilSelectedIndex,
    this.bushingKecilIsEnabled,
    this.tutupRadiatorSelectedIndex,
    this.tutupRadiatorIsEnabled,
    this.mesinCatatan,
    this.stirSelectedIndex,
    this.stirIsEnabled,
    this.remTonganSelectedIndex,
    this.remTonganIsEnabled,
    this.pedalSelectedIndex,
    this.pedalIsEnabled,
    this.switchWiperSelectedIndex,
    this.switchWiperIsEnabled,
    this.lampuHazardSelectedIndex,
    this.lampuHazardIsEnabled,
    this.panelDashboardSelectedIndex,
    this.panelDashboardIsEnabled,
    this.pembukaKapMesinSelectedIndex,
    this.pembukaKapMesinIsEnabled,
    this.pembukaBagasiSelectedIndex,
    this.pembukaBagasiIsEnabled,
    this.jokDepanSelectedIndex,
    this.jokDepanIsEnabled,
    this.aromaInteriorSelectedIndex,
    this.aromaInteriorIsEnabled,
    this.handlePintuSelectedIndex,
    this.handlePintuIsEnabled,
    this.consoleBoxSelectedIndex,
    this.consoleBoxIsEnabled,
    this.spionTengahSelectedIndex,
    this.spionTengahIsEnabled,
    this.tuasPersnelingSelectedIndex,
    this.tuasPersnelingIsEnabled,
    this.jokBelakangSelectedIndex,
    this.jokBelakangIsEnabled,
    this.panelIndikatorSelectedIndex,
    this.panelIndikatorIsEnabled,
    this.switchLampuSelectedIndex,
    this.switchLampuIsEnabled,
    this.karpetDasarSelectedIndex,
    this.karpetDasarIsEnabled,
    this.klaksonSelectedIndex,
    this.klaksonIsEnabled,
    this.sunVisorSelectedIndex,
    this.sunVisorIsEnabled,
    this.tuasTangkiBensinSelectedIndex,
    this.tuasTangkiBensinIsEnabled,
    this.sabukPengamanSelectedIndex,
    this.sabukPengamanIsEnabled,
    this.trimInteriorSelectedIndex,
    this.trimInteriorIsEnabled,
    this.plafonSelectedIndex,
    this.plafonIsEnabled,
    this.interiorCatatan,
    this.bumperDepanSelectedIndex,
    this.bumperDepanIsEnabled,
    this.kapMesinSelectedIndex,
    this.kapMesinIsEnabled,
    this.lampuUtamaSelectedIndex,
    this.lampuUtamaIsEnabled,
    this.panelAtapSelectedIndex,
    this.panelAtapIsEnabled,
    this.grillSelectedIndex,
    this.grillIsEnabled,
    this.lampuFoglampSelectedIndex,
    this.lampuFoglampIsEnabled,
    this.kacaBeningSelectedIndex,
    this.kacaBeningIsEnabled,
    this.wiperBelakangSelectedIndex,
    this.wiperBelakangIsEnabled,
    this.bumperBelakangSelectedIndex,
    this.bumperBelakangIsEnabled,
    this.lampuBelakangSelectedIndex,
    this.lampuBelakangIsEnabled,
    this.trunklidSelectedIndex,
    this.trunklidIsEnabled,
    this.kacaDepanSelectedIndex,
    this.kacaDepanIsEnabled,
    this.fenderKananSelectedIndex,
    this.fenderKananIsEnabled,
    this.quarterPanelKananSelectedIndex,
    this.quarterPanelKananIsEnabled,
    this.pintuBelakangKananSelectedIndex,
    this.pintuBelakangKananIsEnabled,
    this.spionKananSelectedIndex,
    this.spionKananIsEnabled,
    this.lisplangKananSelectedIndex,
    this.lisplangKananIsEnabled,
    this.sideSkirtKananSelectedIndex,
    this.sideSkirtKananIsEnabled,
    this.daunWiperSelectedIndex,
    this.daunWiperIsEnabled,
    this.pintuBelakangSelectedIndex,
    this.pintuBelakangIsEnabled,
    this.fenderKiriSelectedIndex,
    this.fenderKiriIsEnabled,
    this.quarterPanelKiriSelectedIndex,
    this.quarterPanelKiriIsEnabled,
    this.pintuDepanSelectedIndex,
    this.pintuDepanIsEnabled,
    this.kacaJendelaKananSelectedIndex,
    this.kacaJendelaKananIsEnabled,
    this.pintuBelakangKiriSelectedIndex,
    this.pintuBelakangKiriIsEnabled,
    this.spionKiriSelectedIndex,
    this.spionKiriIsEnabled,
    this.pintuDepanKiriSelectedIndex,
    this.pintuDepanKiriIsEnabled,
    this.kacaJendelaKiriSelectedIndex,
    this.kacaJendelaKiriIsEnabled,
    this.lisplangKiriSelectedIndex,
    this.lisplangKiriIsEnabled,
    this.sideSkirtKiriSelectedIndex,
    this.sideSkirtKiriIsEnabled,
    this.eksteriorCatatan,

  }) : keteranganEksterior = keteranganEksterior ?? [],
       keteranganInterior = keteranganInterior ?? [],
       keteranganKakiKaki = keteranganKakiKaki ?? [],
       keteranganMesin = keteranganMesin ?? [],
       deskripsiKeseluruhan = deskripsiKeseluruhan ?? [],
       repairEstimations = repairEstimations ?? [];

  // Add methods to update data if needed, or update directly
}
