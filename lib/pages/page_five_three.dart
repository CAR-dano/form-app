import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/pages/page_five_four.dart'; // Import PageFiveFour
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';


class PageFiveThree extends ConsumerStatefulWidget {
  const PageFiveThree({super.key});

  @override
  ConsumerState<PageFiveThree> createState() => _PageFiveThreeState();
}

class _PageFiveThreeState extends ConsumerState<PageFiveThree> {
  late FocusScopeNode _focusScopeNode;

  @override
  void initState() {
    super.initState();
    _focusScopeNode = FocusScopeNode();
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formData = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);

    return PopScope(
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          _focusScopeNode.unfocus();
        }
      },
      child: FocusScope(
        node: _focusScopeNode,
        child: CommonLayout(
          child: GestureDetector(
            onTap: () {
              _focusScopeNode.unfocus();
            },
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PageNumber(data: '5/9'),
                        const SizedBox(height: 4),
                        PageTitle(data: 'Penilaian (3)'),
                        const SizedBox(height: 6.0),
                        const HeadingOne(text: 'Hasil Inspeksi Interior'),
                        const SizedBox(height: 16.0),

                        // ToggleableNumberedButtonList widgets
                        ToggleableNumberedButtonList(
                          label: 'Stir',
                          count: 10,
                          selectedValue: formData.stirSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateStirSelectedValue(value);
                          },
                          initialEnabled: formData.stirIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateStirIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateStirSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Rem Tangan',
                          count: 10,
                          selectedValue: formData.remTanganSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateRemTanganSelectedValue(value);
                          },
                          initialEnabled: formData.remTanganIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateRemTanganIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateRemTanganSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Pedal',
                          count: 10,
                          selectedValue: formData.pedalSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePedalSelectedValue(value);
                          },
                          initialEnabled: formData.pedalIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePedalIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePedalSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Switch Wiper',
                          count: 10,
                          selectedValue: formData.switchWiperSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateSwitchWiperSelectedValue(value);
                          },
                          initialEnabled: formData.switchWiperIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSwitchWiperIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSwitchWiperSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Lampu Hazard',
                          count: 10,
                          selectedValue: formData.lampuHazardSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateLampuHazardSelectedValue(value);
                          },
                          initialEnabled: formData.lampuHazardIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateLampuHazardIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateLampuHazardSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Panel Dashboard',
                          count: 10,
                          selectedValue: formData.panelDashboardSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePanelDashboardSelectedValue(value);
                          },
                          initialEnabled: formData.panelDashboardIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePanelDashboardIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePanelDashboardSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Pembuka Kap Mesin',
                          count: 10,
                          selectedValue: formData.pembukaKapMesinSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePembukaKapMesinSelectedValue(value);
                          },
                          initialEnabled: formData.pembukaKapMesinIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePembukaKapMesinIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePembukaKapMesinSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Pembuka Bagasi',
                          count: 10,
                          selectedValue: formData.pembukaBagasiSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePembukaBagasiSelectedValue(value);
                          },
                          initialEnabled: formData.pembukaBagasiIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePembukaBagasiIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePembukaBagasiSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Jok Depan',
                          count: 10,
                          selectedValue: formData.jokDepanSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateJokDepanSelectedValue(value);
                          },
                          initialEnabled: formData.jokDepanIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateJokDepanIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateJokDepanSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Aroma Interior',
                          count: 10,
                          selectedValue: formData.aromaInteriorSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateAromaInteriorSelectedValue(value);
                          },
                          initialEnabled: formData.aromaInteriorIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateAromaInteriorIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateAromaInteriorSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Handle Pintu',
                          count: 10,
                          selectedValue: formData.handlePintuSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateHandlePintuSelectedValue(value);
                          },
                          initialEnabled: formData.handlePintuIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateHandlePintuIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateHandlePintuSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Console Box',
                          count: 10,
                          selectedValue: formData.consoleBoxSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateConsoleBoxSelectedValue(value);
                          },
                          initialEnabled: formData.consoleBoxIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateConsoleBoxIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateConsoleBoxSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Spion Tengah',
                          count: 10,
                          selectedValue: formData.spionTengahSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateSpionTengahSelectedValue(value);
                          },
                          initialEnabled: formData.spionTengahIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSpionTengahIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSpionTengahSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Tuas Persneling',
                          count: 10,
                          selectedValue: formData.tuasPersnelingSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateTuasPersnelingSelectedValue(value);
                          },
                          initialEnabled: formData.tuasPersnelingIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateTuasPersnelingIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateTuasPersnelingSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Jok Belakang',
                          count: 10,
                          selectedValue: formData.jokBelakangSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateJokBelakangSelectedValue(value);
                          },
                          initialEnabled: formData.jokBelakangIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateJokBelakangIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateJokBelakangSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Panel Indikator',
                          count: 10,
                          selectedValue: formData.panelIndikatorSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePanelIndikatorSelectedValue(value);
                          },
                          initialEnabled: formData.panelIndikatorIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePanelIndikatorIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePanelIndikatorSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Switch Lampu',
                          count: 10,
                          selectedValue: formData.switchLampuSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateSwitchLampuSelectedValue(value);
                          },
                          initialEnabled: formData.switchLampuIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSwitchLampuIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSwitchLampuSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Karpet Dasar',
                          count: 10,
                          selectedValue: formData.karpetDasarSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKarpetDasarSelectedValue(value);
                          },
                          initialEnabled: formData.karpetDasarIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKarpetDasarIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKarpetDasarSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Klakson',
                          count: 10,
                          selectedValue: formData.klaksonSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKlaksonSelectedValue(value);
                          },
                          initialEnabled: formData.klaksonIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKlaksonIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKlaksonSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Sun Visor',
                          count: 10,
                          selectedValue: formData.sunVisorSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateSunVisorSelectedValue(value);
                          },
                          initialEnabled: formData.sunVisorIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSunVisorIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSunVisorSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Tuas Tangki Bensin',
                          count: 10,
                          selectedValue: formData.tuasTangkiBensinSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateTuasTangkiBensinSelectedValue(value);
                          },
                          initialEnabled: formData.tuasTangkiBensinIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateTuasTangkiBensinIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateTuasTangkiBensinSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Sabuk Pengaman',
                          count: 10,
                          selectedValue: formData.sabukPengamanSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateSabukPengamanSelectedValue(value);
                          },
                          initialEnabled: formData.sabukPengamanIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSabukPengamanIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSabukPengamanSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Trim Interior',
                          count: 10,
                          selectedValue: formData.trimInteriorSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateTrimInteriorSelectedValue(value);
                          },
                          initialEnabled: formData.trimInteriorIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateTrimInteriorIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateTrimInteriorSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Plafon',
                          count: 10,
                          selectedValue: formData.plafonSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePlafonSelectedValue(value);
                          },
                          initialEnabled: formData.plafonIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePlafonIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePlafonSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),

                        // ExpandableTextField
                        ExpandableTextField(
                          label: 'Catatan',
                          hintText: 'Masukkan catatan di sini',
                          initialLines: formData.interiorCatatanList,
                          onChangedList: (lines) {
                            formNotifier.updateInteriorCatatanList(lines);
                          },
                        ),
                        const SizedBox(height: 32.0),

                        NavigationButtonRow(
                          onBackPressed: () => Navigator.pop(context),
                          onNextPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PageFiveFour()),
                            );
                          },
                        ),
                        const SizedBox(height: 32.0), // Optional spacing below the content
                        // Footer
                        Footer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
