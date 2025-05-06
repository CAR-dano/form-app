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
  bool? airbagIsEnabled;
  int? sistemAudioSelectedValue;
  bool? sistemAudioIsEnabled;
  int? powerWindowSelectedValue;
  bool? powerWindowIsEnabled;
  int? sistemAcSelectedValue;
  bool? sistemAcIsEnabled;
  List<String> fiturCatatanList;

  // New fields for Page Five Two
  int? getaranMesinSelectedValue;
  bool? getaranMesinIsEnabled;
  int? suaraMesinSelectedValue;
  bool? suaraMesinIsEnabled;
  int? transmisiSelectedValue;
  bool? transmisiIsEnabled;
  int? pompaPowerSteeringSelectedValue;
  bool? pompaPowerSteeringIsEnabled;
  int? coverTimingChainSelectedValue;
  bool? coverTimingChainIsEnabled;
  int? oliPowerSteeringSelectedValue;
  bool? oliPowerSteeringIsEnabled;
  int? accuSelectedValue;
  bool? accuIsEnabled;
  int? kompressorAcSelectedValue;
  bool? kompressorAcIsEnabled;
  int? fanSelectedValue;
  bool? fanIsEnabled;
  int? selangSelectedValue;
  bool? selangIsEnabled;
  int? karterOliSelectedValue;
  bool? karterOliIsEnabled;
  int? oilRemSelectedValue;
  bool? oilRemIsEnabled;
  int? kabelSelectedValue;
  bool? kabelIsEnabled;
  int? kondensorSelectedValue;
  bool? kondensorIsEnabled;
  int? radiatorSelectedValue;
  bool? radiatorIsEnabled;
  int? cylinderHeadSelectedValue;
  bool? cylinderHeadIsEnabled;
  int? oliMesinSelectedValue;
  bool? oliMesinIsEnabled;
  int? airRadiatorSelectedValue;
  bool? airRadiatorIsEnabled;
  int? coverKlepSelectedValue;
  bool? coverKlepIsEnabled;
  int? alternatorSelectedValue;
  bool? alternatorIsEnabled;
  int? waterPumpSelectedValue;
  bool? waterPumpIsEnabled;
  int? beltSelectedValue;
  bool? beltIsEnabled;
  int? oliTransmisiSelectedValue;
  bool? oliTransmisiIsEnabled;
  int? cylinderBlockSelectedValue;
  bool? cylinderBlockIsEnabled;
  int? bushingBesarSelectedValue;
  bool? bushingBesarIsEnabled;
  int? bushingKecilSelectedValue;
  bool? bushingKecilIsEnabled;
  int? tutupRadiatorSelectedValue;
  bool? tutupRadiatorIsEnabled;
  List<String> mesinCatatanList;

  // New fields for Page Five Three
  int? stirSelectedValue;
  bool? stirIsEnabled;
  int? remTonganSelectedValue;
  bool? remTonganIsEnabled;
  int? pedalSelectedValue;
  bool? pedalIsEnabled;
  int? switchWiperSelectedValue;
  bool? switchWiperIsEnabled;
  int? lampuHazardSelectedValue;
  bool? lampuHazardIsEnabled;
  int? panelDashboardSelectedValue;
  bool? panelDashboardIsEnabled;
  int? pembukaKapMesinSelectedValue;
  bool? pembukaKapMesinIsEnabled;
  int? pembukaBagasiSelectedValue;
  bool? pembukaBagasiIsEnabled;
  int? jokDepanSelectedValue;
  bool? jokDepanIsEnabled;
  int? aromaInteriorSelectedValue;
  bool? aromaInteriorIsEnabled;
  int? handlePintuSelectedValue;
  bool? handlePintuIsEnabled;
  int? consoleBoxSelectedValue;
  bool? consoleBoxIsEnabled;
  int? spionTengahSelectedValue;
  bool? spionTengahIsEnabled;
  int? tuasPersnelingSelectedValue;
  bool? tuasPersnelingIsEnabled;
  int? jokBelakangSelectedValue;
  bool? jokBelakangIsEnabled;
  int? panelIndikatorSelectedValue;
  bool? panelIndikatorIsEnabled;
  int? switchLampuSelectedValue;
  bool? switchLampuIsEnabled;
  int? karpetDasarSelectedValue;
  bool? karpetDasarIsEnabled;
  int? klaksonSelectedValue;
  bool? klaksonIsEnabled;
  int? sunVisorSelectedValue;
  bool? sunVisorIsEnabled;
  int? tuasTangkiBensinSelectedValue;
  bool? tuasTangkiBensinIsEnabled;
  int? sabukPengamanSelectedValue;
  bool? sabukPengamanIsEnabled;
  int? trimInteriorSelectedValue;
  bool? trimInteriorIsEnabled;
  int? plafonSelectedValue;
  bool? plafonIsEnabled;
  List<String> interiorCatatanList;

  // New fields for Page Five Four
  int? bumperDepanSelectedValue;
  bool? bumperDepanIsEnabled;
  int? kapMesinSelectedValue;
  bool? kapMesinIsEnabled;
  int? lampuUtamaSelectedValue;
  bool? lampuUtamaIsEnabled;
  int? panelAtapSelectedValue;
  bool? panelAtapIsEnabled;
  int? grillSelectedValue;
  bool? grillIsEnabled;
  int? lampuFoglampSelectedValue;
  bool? lampuFoglampIsEnabled;
  int? kacaBeningSelectedValue;
  bool? kacaBeningIsEnabled;
  int? wiperBelakangSelectedValue;
  bool? wiperBelakangIsEnabled;
  int? bumperBelakangSelectedValue;
  bool? bumperBelakangIsEnabled;
  int? lampuBelakangSelectedValue;
  bool? lampuBelakangIsEnabled;
  int? trunklidSelectedValue;
  bool? trunklidIsEnabled;
  int? kacaDepanSelectedValue;
  bool? kacaDepanIsEnabled;
  int? fenderKananSelectedValue;
  bool? fenderKananIsEnabled;
  int? quarterPanelKananSelectedValue;
  bool? quarterPanelKananIsEnabled;
  int? pintuBelakangKananSelectedValue;
  bool? pintuBelakangKananIsEnabled;
  int? spionKananSelectedValue;
  bool? spionKananIsEnabled;
  int? lisplangKananSelectedValue;
  bool? lisplangKananIsEnabled;
  int? sideSkirtKananSelectedValue;
  bool? sideSkirtKananIsEnabled;
  int? daunWiperSelectedValue;
  bool? daunWiperIsEnabled;
  int? pintuBelakangSelectedValue;
  bool? pintuBelakangIsEnabled;
  int? fenderKiriSelectedValue;
  bool? fenderKiriIsEnabled;
  int? quarterPanelKiriSelectedValue;
  bool? quarterPanelKiriIsEnabled;
  int? pintuDepanSelectedValue;
  bool? pintuDepanIsEnabled;
  int? kacaJendelaKananSelectedValue;
  bool? kacaJendelaKananIsEnabled;
  int? pintuBelakangKiriSelectedValue;
  bool? pintuBelakangKiriIsEnabled;
  int? spionKiriSelectedValue;
  bool? spionKiriIsEnabled;
  int? pintuDepanKiriSelectedValue;
  bool? pintuDepanKiriIsEnabled;
  int? kacaJendelaKiriSelectedValue;
  bool? kacaJendelaKiriIsEnabled;
  int? lisplangKiriSelectedValue;
  bool? lisplangKiriIsEnabled;
  int? sideSkirtKiriSelectedValue;
  bool? sideSkirtKiriIsEnabled;
  List<String> eksteriorCatatanList;

  // New fields for Page Five Five
  int? banDepanSelectedValue;
  bool? banDepanIsEnabled;
  int? velgDepanSelectedValue;
  bool? velgDepanIsEnabled;
  int? discBrakeSelectedValue;
  bool? discBrakeIsEnabled;
  int? masterRemSelectedValue;
  bool? masterRemIsEnabled;
  int? tieRodSelectedValue;
  bool? tieRodIsEnabled;
  int? gardanSelectedValue;
  bool? gardanIsEnabled;
  int? banBelakangSelectedValue;
  bool? banBelakangIsEnabled;
  int? velgBelakangSelectedValue;
  bool? velgBelakangIsEnabled;
  int? brakePadSelectedValue;
  bool? brakePadIsEnabled;
  int? crossmemberSelectedValue;
  bool? crossmemberIsEnabled;
  int? knalpotSelectedValue;
  bool? knalpotIsEnabled;
  int? balljointSelectedValue;
  bool? balljointIsEnabled;
  int? rocksteerSelectedValue;
  bool? rocksteerIsEnabled;
  int? karetBootSelectedValue;
  bool? karetBootIsEnabled;
  int? upperLowerArmSelectedValue;
  bool? upperLowerArmIsEnabled;
  int? shockBreakerSelectedValue;
  bool? shockBreakerIsEnabled;
  int? linkStabilizerSelectedValue;
  bool? linkStabilizerIsEnabled;
  List<String> banDanKakiKakiCatatanList;

  // New fields for Page Five Six (Test Drive)
  int? bunyiGetaranSelectedValue;
  bool? bunyiGetaranIsEnabled;
  int? performaStirSelectedValue;
  bool? performaStirIsEnabled;
  int? perpindahanTransmisiSelectedValue;
  bool? perpindahanTransmisiIsEnabled;
  int? stirBalanceSelectedValue;
  bool? stirBalanceIsEnabled;
  int? performaSuspensiSelectedValue;
  bool? performaSuspensiIsEnabled;
  int? performaKoplingSelectedValue;
  bool? performaKoplingIsEnabled;
  int? rpmSelectedValue;
  bool? rpmIsEnabled;
  List<String> testDriveCatatanList;


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
    this.interiorSelectedValue,
    this.eksteriorSelectedValue,
    this.kakiKakiSelectedValue,
    this.mesinSelectedValue,
    this.penilaianKeseluruhanSelectedValue,
    List<String>? keteranganInterior,
    List<String>? keteranganEksterior,
    List<String>? keteranganKakiKaki,
    List<String>? keteranganMesin,
    List<String>? deskripsiKeseluruhan,
    List<Map<String, String>>? repairEstimations,
    this.airbagSelectedValue,
    this.airbagIsEnabled,
    this.sistemAudioSelectedValue,
    this.sistemAudioIsEnabled,
    this.powerWindowSelectedValue,
    this.powerWindowIsEnabled,
    this.sistemAcSelectedValue,
    this.sistemAcIsEnabled,
    this.getaranMesinSelectedValue,
    this.fiturCatatanList = const [],
    this.getaranMesinIsEnabled,
    this.suaraMesinSelectedValue,
    this.suaraMesinIsEnabled,
    this.transmisiSelectedValue,
    this.transmisiIsEnabled,
    this.pompaPowerSteeringSelectedValue,
    this.pompaPowerSteeringIsEnabled,
    this.coverTimingChainSelectedValue,
    this.coverTimingChainIsEnabled,
    this.oliPowerSteeringSelectedValue,
    this.oliPowerSteeringIsEnabled,
    this.accuSelectedValue,
    this.accuIsEnabled,
    this.kompressorAcSelectedValue,
    this.kompressorAcIsEnabled,
    this.fanSelectedValue,
    this.fanIsEnabled,
    this.selangSelectedValue,
    this.selangIsEnabled,
    this.karterOliSelectedValue,
    this.karterOliIsEnabled,
    this.oilRemSelectedValue,
    this.oilRemIsEnabled,
    this.kabelSelectedValue,
    this.kabelIsEnabled,
    this.kondensorSelectedValue,
    this.kondensorIsEnabled,
    this.radiatorSelectedValue,
    this.radiatorIsEnabled,
    this.cylinderHeadSelectedValue,
    this.cylinderHeadIsEnabled,
    this.oliMesinSelectedValue,
    this.oliMesinIsEnabled,
    this.airRadiatorSelectedValue,
    this.airRadiatorIsEnabled,
    this.coverKlepSelectedValue,
    this.coverKlepIsEnabled,
    this.alternatorSelectedValue,
    this.alternatorIsEnabled,
    this.waterPumpSelectedValue,
    this.waterPumpIsEnabled,
    this.beltSelectedValue,
    this.beltIsEnabled,
    this.oliTransmisiSelectedValue,
    this.oliTransmisiIsEnabled,
    this.cylinderBlockSelectedValue,
    this.cylinderBlockIsEnabled,
    this.bushingBesarSelectedValue,
    this.bushingBesarIsEnabled,
    this.bushingKecilSelectedValue,
    this.bushingKecilIsEnabled,
    this.tutupRadiatorSelectedValue,
    this.tutupRadiatorIsEnabled,
    List<String>? mesinCatatanList,
    this.stirSelectedValue,
    this.stirIsEnabled,
    this.remTonganSelectedValue,
    this.remTonganIsEnabled,
    this.pedalSelectedValue,
    this.pedalIsEnabled,
    this.switchWiperSelectedValue,
    this.switchWiperIsEnabled,
    this.lampuHazardSelectedValue,
    this.lampuHazardIsEnabled,
    this.panelDashboardSelectedValue,
    this.panelDashboardIsEnabled,
    this.pembukaKapMesinSelectedValue,
    this.pembukaKapMesinIsEnabled,
    this.pembukaBagasiSelectedValue,
    this.pembukaBagasiIsEnabled,
    this.jokDepanSelectedValue,
    this.jokDepanIsEnabled,
    this.aromaInteriorSelectedValue,
    this.aromaInteriorIsEnabled,
    this.handlePintuSelectedValue,
    this.handlePintuIsEnabled,
    this.consoleBoxSelectedValue,
    this.consoleBoxIsEnabled,
    this.spionTengahSelectedValue,
    this.spionTengahIsEnabled,
    this.tuasPersnelingSelectedValue,
    this.tuasPersnelingIsEnabled,
    this.jokBelakangSelectedValue,
    this.jokBelakangIsEnabled,
    this.panelIndikatorSelectedValue,
    this.panelIndikatorIsEnabled,
    this.switchLampuSelectedValue,
    this.switchLampuIsEnabled,
    this.karpetDasarSelectedValue,
    this.karpetDasarIsEnabled,
    this.klaksonSelectedValue,
    this.klaksonIsEnabled,
    this.sunVisorSelectedValue,
    this.sunVisorIsEnabled,
    this.tuasTangkiBensinSelectedValue,
    this.tuasTangkiBensinIsEnabled,
    this.sabukPengamanSelectedValue,
    this.sabukPengamanIsEnabled,
    this.trimInteriorSelectedValue,
    this.trimInteriorIsEnabled,
    this.plafonSelectedValue,
    this.plafonIsEnabled,
    List<String>? interiorCatatanList,
    this.bumperDepanSelectedValue,
    this.bumperDepanIsEnabled,
    this.kapMesinSelectedValue,
    this.kapMesinIsEnabled,
    this.lampuUtamaSelectedValue,
    this.lampuUtamaIsEnabled,
    this.panelAtapSelectedValue,
    this.panelAtapIsEnabled,
    this.grillSelectedValue,
    this.grillIsEnabled,
    this.lampuFoglampSelectedValue,
    this.lampuFoglampIsEnabled,
    this.kacaBeningSelectedValue,
    this.kacaBeningIsEnabled,
    this.wiperBelakangSelectedValue,
    this.wiperBelakangIsEnabled,
    this.bumperBelakangSelectedValue,
    this.bumperBelakangIsEnabled,
    this.lampuBelakangSelectedValue,
    this.lampuBelakangIsEnabled,
    this.trunklidSelectedValue,
    this.trunklidIsEnabled,
    this.kacaDepanSelectedValue,
    this.kacaDepanIsEnabled,
    this.fenderKananSelectedValue,
    this.fenderKananIsEnabled,
    this.quarterPanelKananSelectedValue,
    this.quarterPanelKananIsEnabled,
    this.pintuBelakangKananSelectedValue,
    this.pintuBelakangKananIsEnabled,
    this.spionKananSelectedValue,
    this.spionKananIsEnabled,
    this.lisplangKananSelectedValue,
    this.lisplangKananIsEnabled,
    this.sideSkirtKananSelectedValue,
    this.sideSkirtKananIsEnabled,
    this.daunWiperSelectedValue,
    this.daunWiperIsEnabled,
    this.pintuBelakangSelectedValue,
    this.pintuBelakangIsEnabled,
    this.fenderKiriSelectedValue,
    this.fenderKiriIsEnabled,
    this.quarterPanelKiriSelectedValue,
    this.quarterPanelKiriIsEnabled,
    this.pintuDepanSelectedValue,
    this.pintuDepanIsEnabled,
    this.kacaJendelaKananSelectedValue,
    this.kacaJendelaKananIsEnabled,
    this.pintuBelakangKiriSelectedValue,
    this.pintuBelakangKiriIsEnabled,
    this.spionKiriSelectedValue,
    this.spionKiriIsEnabled,
    this.pintuDepanKiriSelectedValue,
    this.pintuDepanKiriIsEnabled,
    this.kacaJendelaKiriSelectedValue,
    this.kacaJendelaKiriIsEnabled,
    this.lisplangKiriSelectedValue,
    this.lisplangKiriIsEnabled,
    this.sideSkirtKiriSelectedValue,
    this.sideSkirtKiriIsEnabled,
    List<String>? eksteriorCatatanList,
    this.banDepanSelectedValue,
    this.banDepanIsEnabled,
    this.velgDepanSelectedValue,
    this.velgDepanIsEnabled,
    this.discBrakeSelectedValue,
    this.discBrakeIsEnabled,
    this.masterRemSelectedValue,
    this.masterRemIsEnabled,
    this.tieRodSelectedValue,
    this.tieRodIsEnabled,
    this.gardanSelectedValue,
    this.gardanIsEnabled,
    this.banBelakangSelectedValue,
    this.banBelakangIsEnabled,
    this.velgBelakangSelectedValue,
    this.velgBelakangIsEnabled,
    this.brakePadSelectedValue,
    this.brakePadIsEnabled,
    this.crossmemberSelectedValue,
    this.crossmemberIsEnabled,
    this.knalpotSelectedValue,
    this.knalpotIsEnabled,
    this.balljointSelectedValue,
    this.balljointIsEnabled,
    this.rocksteerSelectedValue,
    this.rocksteerIsEnabled,
    this.karetBootSelectedValue,
    this.karetBootIsEnabled,
    this.upperLowerArmSelectedValue,
    this.upperLowerArmIsEnabled,
    this.shockBreakerSelectedValue,
    this.shockBreakerIsEnabled,
    this.linkStabilizerSelectedValue,
    this.linkStabilizerIsEnabled,
    List<String>? banDanKakiKakiCatatanList,
    this.bunyiGetaranSelectedValue,
    this.bunyiGetaranIsEnabled,
    this.performaStirSelectedValue,
    this.performaStirIsEnabled,
    this.perpindahanTransmisiSelectedValue,
    this.perpindahanTransmisiIsEnabled,
    this.stirBalanceSelectedValue,
    this.stirBalanceIsEnabled,
    this.performaSuspensiSelectedValue,
    this.performaSuspensiIsEnabled,
    this.performaKoplingSelectedValue,
    this.performaKoplingIsEnabled,
    this.rpmSelectedValue,
    this.rpmIsEnabled,
    List<String>? testDriveCatatanList,

  }) : keteranganEksterior = eksteriorCatatanList ?? [],
       keteranganInterior = keteranganInterior ?? [],
       keteranganKakiKaki = keteranganKakiKaki ?? [],
       keteranganMesin = keteranganMesin ?? [],
       deskripsiKeseluruhan = deskripsiKeseluruhan ?? [],
       repairEstimations = repairEstimations ?? [],
       mesinCatatanList = mesinCatatanList ?? [],
       interiorCatatanList = interiorCatatanList ?? [],
       eksteriorCatatanList = eksteriorCatatanList ?? [],
       banDanKakiKakiCatatanList = banDanKakiKakiCatatanList ?? [],
       testDriveCatatanList = testDriveCatatanList ?? [];

  // Add methods to update data if needed, or update directly
}
