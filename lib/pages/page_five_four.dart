import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/pages/page_five_five.dart'; // Import PageFiveFive
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';


class PageFiveFour extends ConsumerStatefulWidget {
  const PageFiveFour({super.key});

  @override
  ConsumerState<PageFiveFour> createState() => _PageFiveFourState();
}

class _PageFiveFourState extends ConsumerState<PageFiveFour> {
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
                        PageTitle(data: 'Penilaian (4)'),
                        const SizedBox(height: 24.0),
                        const HeadingOne(text: 'Hasil Inspeksi Eksterior'),
                        const SizedBox(height: 16.0),

                        // ToggleableNumberedButtonList widgets
                        ToggleableNumberedButtonList(
                          label: 'Bumper Depan',
                          count: 10,
                          selectedValue: formData.bumperDepanSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateBumperDepanSelectedIndex(value);
                          },
                          initialEnabled: formData.bumperDepanIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateBumperDepanIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateBumperDepanSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Kap Mesin',
                          count: 10,
                          selectedValue: formData.kapMesinSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKapMesinSelectedIndex(value);
                          },
                          initialEnabled: formData.kapMesinIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKapMesinIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKapMesinSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Lampu Utama',
                          count: 10,
                          selectedValue: formData.lampuUtamaSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateLampuUtamaSelectedIndex(value);
                          },
                          initialEnabled: formData.lampuUtamaIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateLampuUtamaIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateLampuUtamaSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Panel Atap',
                          count: 10,
                          selectedValue: formData.panelAtapSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePanelAtapSelectedIndex(value);
                          },
                          initialEnabled: formData.panelAtapIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePanelAtapIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePanelAtapSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Grill',
                          count: 10,
                          selectedValue: formData.grillSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateGrillSelectedIndex(value);
                          },
                          initialEnabled: formData.grillIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateGrillIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateGrillSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Lampu Foglamp',
                          count: 10,
                          selectedValue: formData.lampuFoglampSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateLampuFoglampSelectedIndex(value);
                          },
                          initialEnabled: formData.lampuFoglampIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateLampuFoglampIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateLampuFoglampSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Kaca Bening',
                          count: 10,
                          selectedValue: formData.kacaBeningSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKacaBeningSelectedIndex(value);
                          },
                          initialEnabled: formData.kacaBeningIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKacaBeningIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKacaBeningSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Wiper Belakang',
                          count: 10,
                          selectedValue: formData.wiperBelakangSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateWiperBelakangSelectedIndex(value);
                          },
                          initialEnabled: formData.wiperBelakangIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateWiperBelakangIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateWiperBelakangSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Bumper Belakang',
                          count: 10,
                          selectedValue: formData.bumperBelakangSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateBumperBelakangSelectedIndex(value);
                          },
                          initialEnabled: formData.bumperBelakangIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateBumperBelakangIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateBumperBelakangSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Lampu Belakang',
                          count: 10,
                          selectedValue: formData.lampuBelakangSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateLampuBelakangSelectedIndex(value);
                          },
                          initialEnabled: formData.lampuBelakangIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateLampuBelakangIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateLampuBelakangSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Trunklid',
                          count: 10,
                          selectedValue: formData.trunklidSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateTrunklidSelectedIndex(value);
                          },
                          initialEnabled: formData.trunklidIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateTrunklidIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateTrunklidSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Kaca Depan',
                          count: 10,
                          selectedValue: formData.kacaDepanSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKacaDepanSelectedIndex(value);
                          },
                          initialEnabled: formData.kacaDepanIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKacaDepanIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKacaDepanSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Fender Kanan',
                          count: 10,
                          selectedValue: formData.fenderKananSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateFenderKananSelectedIndex(value);
                          },
                          initialEnabled: formData.fenderKananIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateFenderKananIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateFenderKananSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Quarter Panel Kanan',
                          count: 10,
                          selectedValue: formData.quarterPanelKananSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateQuarterPanelKananSelectedIndex(value);
                          },
                          initialEnabled: formData.quarterPanelKananIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateQuarterPanelKananIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateQuarterPanelKananSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Pintu Belakang Kanan',
                          count: 10,
                          selectedValue: formData.pintuBelakangKananSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePintuBelakangKananSelectedIndex(value);
                          },
                          initialEnabled: formData.pintuBelakangKananIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePintuBelakangKananIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePintuBelakangKananSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Spion Kanan',
                          count: 10,
                          selectedValue: formData.spionKananSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateSpionKananSelectedIndex(value);
                          },
                          initialEnabled: formData.spionKananIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSpionKananIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSpionKananSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Lisplang Kanan',
                          count: 10,
                          selectedValue: formData.lisplangKananSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateLisplangKananSelectedIndex(value);
                          },
                          initialEnabled: formData.lisplangKananIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateLisplangKananIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateLisplangKananSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Side Skirt Kanan',
                          count: 10,
                          selectedValue: formData.sideSkirtKananSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateSideSkirtKananSelectedIndex(value);
                          },
                          initialEnabled: formData.sideSkirtKananIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSideSkirtKananIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSideSkirtKananSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Daun Wiper',
                          count: 10,
                          selectedValue: formData.daunWiperSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateDaunWiperSelectedIndex(value);
                          },
                          initialEnabled: formData.daunWiperIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateDaunWiperIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateDaunWiperSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Pintu Belakang',
                          count: 10,
                          selectedValue: formData.pintuBelakangSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePintuBelakangSelectedIndex(value);
                          },
                          initialEnabled: formData.pintuBelakangIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePintuBelakangIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePintuBelakangSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Fender Kiri',
                          count: 10,
                          selectedValue: formData.fenderKiriSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateFenderKiriSelectedIndex(value);
                          },
                          initialEnabled: formData.fenderKiriIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateFenderKiriIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateFenderKiriSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Quarter Panel Kiri',
                          count: 10,
                          selectedValue: formData.quarterPanelKiriSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateQuarterPanelKiriSelectedIndex(value);
                          },
                          initialEnabled: formData.quarterPanelKiriIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateQuarterPanelKiriIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateQuarterPanelKiriSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Pintu Depan',
                          count: 10,
                          selectedValue: formData.pintuDepanSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePintuDepanSelectedIndex(value);
                          },
                          initialEnabled: formData.pintuDepanIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePintuDepanIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePintuDepanSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Kaca Jendela Kanan',
                          count: 10,
                          selectedValue: formData.kacaJendelaKananSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKacaJendelaKananSelectedIndex(value);
                          },
                          initialEnabled: formData.kacaJendelaKananIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKacaJendelaKananIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKacaJendelaKananSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Pintu Belakang Kiri',
                          count: 10,
                          selectedValue: formData.pintuBelakangKiriSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePintuBelakangKiriSelectedIndex(value);
                          },
                          initialEnabled: formData.pintuBelakangKiriIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePintuBelakangKiriIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePintuBelakangKiriSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Spion Kiri',
                          count: 10,
                          selectedValue: formData.spionKiriSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateSpionKiriSelectedIndex(value);
                          },
                          initialEnabled: formData.spionKiriIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSpionKiriIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSpionKiriSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Pintu Depan Kiri',
                          count: 10,
                          selectedValue: formData.pintuDepanKiriSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePintuDepanKiriSelectedIndex(value);
                          },
                          initialEnabled: formData.pintuDepanKiriIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePintuDepanKiriIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePintuDepanKiriSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Kaca Jendela Kiri',
                          count: 10,
                          selectedValue: formData.kacaJendelaKiriSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKacaJendelaKiriSelectedIndex(value);
                          },
                          initialEnabled: formData.kacaJendelaKiriIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKacaJendelaKiriIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKacaJendelaKiriSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Lisplang Kiri',
                          count: 10,
                          selectedValue: formData.lisplangKiriSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateLisplangKiriSelectedIndex(value);
                          },
                          initialEnabled: formData.lisplangKiriIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateLisplangKiriIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateLisplangKiriSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Side Skirt Kiri',
                          count: 10,
                          selectedValue: formData.sideSkirtKiriSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateSideSkirtKiriSelectedIndex(value);
                          },
                          initialEnabled: formData.sideSkirtKiriIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSideSkirtKiriIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSideSkirtKiriSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),

                        // ExpandableTextField
                        ExpandableTextField(
                          label: 'Catatan',
                          hintText: 'Masukkan catatan di sini',
                          initialLines: formData.eksteriorCatatanList,
                          onChangedList: (lines) {
                            formNotifier.updateEksteriorCatatanList(lines);
                          },
                        ),
                        const SizedBox(height: 32.0),

                        NavigationButtonRow(
                          onBackPressed: () => Navigator.pop(context),
                          onNextPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PageFiveFive()),
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
