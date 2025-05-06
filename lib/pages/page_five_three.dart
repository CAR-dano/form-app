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
                        const SizedBox(height: 8.0),
                        PageTitle(data: 'Penilaian (3)'),
                        const SizedBox(height: 24.0),
                        const HeadingOne(text: 'Hasil Inspeksi Interior'),
                        const SizedBox(height: 16.0),

                        // ToggleableNumberedButtonList widgets
                        ToggleableNumberedButtonList(
                          label: 'Stir',
                          count: 10,
                          selectedValue: formData.stirSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateStirSelectedIndex(index);
                          },
                          initialEnabled: formData.stirIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateStirIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateStirSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Rem Tangan',
                          count: 10,
                          selectedValue: formData.remTonganSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateRemTonganSelectedIndex(index);
                          },
                          initialEnabled: formData.remTonganIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateRemTonganIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateRemTonganSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Pedal',
                          count: 10,
                          selectedValue: formData.pedalSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updatePedalSelectedIndex(index);
                          },
                          initialEnabled: formData.pedalIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePedalIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePedalSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Switch Wiper',
                          count: 10,
                          selectedValue: formData.switchWiperSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateSwitchWiperSelectedIndex(index);
                          },
                          initialEnabled: formData.switchWiperIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSwitchWiperIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSwitchWiperSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Lampu Hazard',
                          count: 10,
                          selectedValue: formData.lampuHazardSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateLampuHazardSelectedIndex(index);
                          },
                          initialEnabled: formData.lampuHazardIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateLampuHazardIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateLampuHazardSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Panel Dashboard',
                          count: 10,
                          selectedValue: formData.panelDashboardSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updatePanelDashboardSelectedIndex(index);
                          },
                          initialEnabled: formData.panelDashboardIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePanelDashboardIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePanelDashboardSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Pembuka Kap Mesin',
                          count: 10,
                          selectedValue: formData.pembukaKapMesinSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updatePembukaKapMesinSelectedIndex(index);
                          },
                          initialEnabled: formData.pembukaKapMesinIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePembukaKapMesinIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePembukaKapMesinSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Pembuka Bagasi',
                          count: 10,
                          selectedValue: formData.pembukaBagasiSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updatePembukaBagasiSelectedIndex(index);
                          },
                          initialEnabled: formData.pembukaBagasiIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePembukaBagasiIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePembukaBagasiSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Jok Depan',
                          count: 10,
                          selectedValue: formData.jokDepanSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateJokDepanSelectedIndex(index);
                          },
                          initialEnabled: formData.jokDepanIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateJokDepanIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateJokDepanSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Aroma Interior',
                          count: 10,
                          selectedValue: formData.aromaInteriorSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateAromaInteriorSelectedIndex(index);
                          },
                          initialEnabled: formData.aromaInteriorIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateAromaInteriorIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateAromaInteriorSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Handle Pintu',
                          count: 10,
                          selectedValue: formData.handlePintuSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateHandlePintuSelectedIndex(index);
                          },
                          initialEnabled: formData.handlePintuIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateHandlePintuIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateHandlePintuSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Console Box',
                          count: 10,
                          selectedValue: formData.consoleBoxSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateConsoleBoxSelectedIndex(index);
                          },
                          initialEnabled: formData.consoleBoxIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateConsoleBoxIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateConsoleBoxSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Spion Tengah',
                          count: 10,
                          selectedValue: formData.spionTengahSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateSpionTengahSelectedIndex(index);
                          },
                          initialEnabled: formData.spionTengahIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSpionTengahIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSpionTengahSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Tuas Persneling',
                          count: 10,
                          selectedValue: formData.tuasPersnelingSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateTuasPersnelingSelectedIndex(index);
                          },
                          initialEnabled: formData.tuasPersnelingIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateTuasPersnelingIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateTuasPersnelingSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Jok Belakang',
                          count: 10,
                          selectedValue: formData.jokBelakangSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateJokBelakangSelectedIndex(index);
                          },
                          initialEnabled: formData.jokBelakangIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateJokBelakangIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateJokBelakangSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Panel Indikator',
                          count: 10,
                          selectedValue: formData.panelIndikatorSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updatePanelIndikatorSelectedIndex(index);
                          },
                          initialEnabled: formData.panelIndikatorIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePanelIndikatorIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePanelIndikatorSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Switch Lampu',
                          count: 10,
                          selectedValue: formData.switchLampuSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateSwitchLampuSelectedIndex(index);
                          },
                          initialEnabled: formData.switchLampuIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSwitchLampuIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSwitchLampuSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Karpet Dasar',
                          count: 10,
                          selectedValue: formData.karpetDasarSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateKarpetDasarSelectedIndex(index);
                          },
                          initialEnabled: formData.karpetDasarIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKarpetDasarIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKarpetDasarSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Klakson',
                          count: 10,
                          selectedValue: formData.klaksonSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateKlaksonSelectedIndex(index);
                          },
                          initialEnabled: formData.klaksonIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKlaksonIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKlaksonSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Sun Visor',
                          count: 10,
                          selectedValue: formData.sunVisorSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateSunVisorSelectedIndex(index);
                          },
                          initialEnabled: formData.sunVisorIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSunVisorIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSunVisorSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Tuas Tangki Bensin',
                          count: 10,
                          selectedValue: formData.tuasTangkiBensinSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateTuasTangkiBensinSelectedIndex(index);
                          },
                          initialEnabled: formData.tuasTangkiBensinIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateTuasTangkiBensinIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateTuasTangkiBensinSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Sabuk Pengaman',
                          count: 10,
                          selectedValue: formData.sabukPengamanSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateSabukPengamanSelectedIndex(index);
                          },
                          initialEnabled: formData.sabukPengamanIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSabukPengamanIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSabukPengamanSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Trim Interior',
                          count: 10,
                          selectedValue: formData.trimInteriorSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updateTrimInteriorSelectedIndex(index);
                          },
                          initialEnabled: formData.trimInteriorIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateTrimInteriorIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateTrimInteriorSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Plafon',
                          count: 10,
                          selectedValue: formData.plafonSelectedIndex ?? -1,
                          onItemSelected: (index) {
                            formNotifier.updatePlafonSelectedIndex(index);
                          },
                          initialEnabled: formData.plafonIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePlafonIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePlafonSelectedIndex(-1);
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
