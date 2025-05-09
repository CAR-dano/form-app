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
                        const SizedBox(height: 4),
                        PageTitle(data: 'Penilaian (4)'),
                        const SizedBox(height: 6.0),
                        const HeadingOne(text: 'Hasil Inspeksi Eksterior'),
                        const SizedBox(height: 16.0),

                        // ToggleableNumberedButtonList widgets
                        ToggleableNumberedButtonList(
                          label: 'Bumper Depan',
                          count: 10,
                          selectedValue: formData.bumperDepanSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateBumperDepanSelectedValue(value);
                          },
                          initialEnabled: formData.bumperDepanIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateBumperDepanIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateBumperDepanSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Kap Mesin',
                          count: 10,
                          selectedValue: formData.kapMesinSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKapMesinSelectedValue(value);
                          },
                          initialEnabled: formData.kapMesinIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKapMesinIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKapMesinSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Lampu Utama',
                          count: 10,
                          selectedValue: formData.lampuUtamaSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateLampuUtamaSelectedValue(value);
                          },
                          initialEnabled: formData.lampuUtamaIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateLampuUtamaIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateLampuUtamaSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Panel Atap',
                          count: 10,
                          selectedValue: formData.panelAtapSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePanelAtapSelectedValue(value);
                          },
                          initialEnabled: formData.panelAtapIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePanelAtapIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePanelAtapSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Grill',
                          count: 10,
                          selectedValue: formData.grillSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateGrillSelectedValue(value);
                          },
                          initialEnabled: formData.grillIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateGrillIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateGrillSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Lampu Foglamp',
                          count: 10,
                          selectedValue: formData.lampuFoglampSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateLampuFoglampSelectedValue(value);
                          },
                          initialEnabled: formData.lampuFoglampIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateLampuFoglampIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateLampuFoglampSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Kaca Bening',
                          count: 10,
                          selectedValue: formData.kacaBeningSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKacaBeningSelectedValue(value);
                          },
                          initialEnabled: formData.kacaBeningIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKacaBeningIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKacaBeningSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Wiper Belakang',
                          count: 10,
                          selectedValue: formData.wiperBelakangSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateWiperBelakangSelectedValue(value);
                          },
                          initialEnabled: formData.wiperBelakangIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateWiperBelakangIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateWiperBelakangSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Bumper Belakang',
                          count: 10,
                          selectedValue: formData.bumperBelakangSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateBumperBelakangSelectedValue(value);
                          },
                          initialEnabled: formData.bumperBelakangIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateBumperBelakangIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateBumperBelakangSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Lampu Belakang',
                          count: 10,
                          selectedValue: formData.lampuBelakangSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateLampuBelakangSelectedValue(value);
                          },
                          initialEnabled: formData.lampuBelakangIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateLampuBelakangIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateLampuBelakangSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Trunklid',
                          count: 10,
                          selectedValue: formData.trunklidSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateTrunklidSelectedValue(value);
                          },
                          initialEnabled: formData.trunklidIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateTrunklidIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateTrunklidSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Kaca Depan',
                          count: 10,
                          selectedValue: formData.kacaDepanSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKacaDepanSelectedValue(value);
                          },
                          initialEnabled: formData.kacaDepanIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKacaDepanIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKacaDepanSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Fender Kanan',
                          count: 10,
                          selectedValue: formData.fenderKananSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateFenderKananSelectedValue(value);
                          },
                          initialEnabled: formData.fenderKananIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateFenderKananIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateFenderKananSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Quarter Panel Kanan',
                          count: 10,
                          selectedValue: formData.quarterPanelKananSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateQuarterPanelKananSelectedValue(value);
                          },
                          initialEnabled: formData.quarterPanelKananIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateQuarterPanelKananIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateQuarterPanelKananSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Pintu Belakang Kanan',
                          count: 10,
                          selectedValue: formData.pintuBelakangKananSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePintuBelakangKananSelectedValue(value);
                          },
                          initialEnabled: formData.pintuBelakangKananIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePintuBelakangKananIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePintuBelakangKananSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Spion Kanan',
                          count: 10,
                          selectedValue: formData.spionKananSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateSpionKananSelectedValue(value);
                          },
                          initialEnabled: formData.spionKananIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSpionKananIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSpionKananSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Lisplang Kanan',
                          count: 10,
                          selectedValue: formData.lisplangKananSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateLisplangKananSelectedValue(value);
                          },
                          initialEnabled: formData.lisplangKananIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateLisplangKananIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateLisplangKananSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Side Skirt Kanan',
                          count: 10,
                          selectedValue: formData.sideSkirtKananSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateSideSkirtKananSelectedValue(value);
                          },
                          initialEnabled: formData.sideSkirtKananIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSideSkirtKananIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSideSkirtKananSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Daun Wiper',
                          count: 10,
                          selectedValue: formData.daunWiperSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateDaunWiperSelectedValue(value);
                          },
                          initialEnabled: formData.daunWiperIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateDaunWiperIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateDaunWiperSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Pintu Belakang',
                          count: 10,
                          selectedValue: formData.pintuBelakangSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePintuBelakangSelectedValue(value);
                          },
                          initialEnabled: formData.pintuBelakangIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePintuBelakangIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePintuBelakangSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Fender Kiri',
                          count: 10,
                          selectedValue: formData.fenderKiriSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateFenderKiriSelectedValue(value);
                          },
                          initialEnabled: formData.fenderKiriIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateFenderKiriIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateFenderKiriSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Quarter Panel Kiri',
                          count: 10,
                          selectedValue: formData.quarterPanelKiriSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateQuarterPanelKiriSelectedValue(value);
                          },
                          initialEnabled: formData.quarterPanelKiriIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateQuarterPanelKiriIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateQuarterPanelKiriSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Pintu Depan',
                          count: 10,
                          selectedValue: formData.pintuDepanSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePintuDepanSelectedValue(value);
                          },
                          initialEnabled: formData.pintuDepanIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePintuDepanIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePintuDepanSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Kaca Jendela Kanan',
                          count: 10,
                          selectedValue: formData.kacaJendelaKananSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKacaJendelaKananSelectedValue(value);
                          },
                          initialEnabled: formData.kacaJendelaKananIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKacaJendelaKananIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKacaJendelaKananSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Pintu Belakang Kiri',
                          count: 10,
                          selectedValue: formData.pintuBelakangKiriSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePintuBelakangKiriSelectedValue(value);
                          },
                          initialEnabled: formData.pintuBelakangKiriIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePintuBelakangKiriIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePintuBelakangKiriSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Spion Kiri',
                          count: 10,
                          selectedValue: formData.spionKiriSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateSpionKiriSelectedValue(value);
                          },
                          initialEnabled: formData.spionKiriIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSpionKiriIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSpionKiriSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Pintu Depan Kiri',
                          count: 10,
                          selectedValue: formData.pintuDepanKiriSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePintuDepanKiriSelectedValue(value);
                          },
                          initialEnabled: formData.pintuDepanKiriIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePintuDepanKiriIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePintuDepanKiriSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Kaca Jendela Kiri',
                          count: 10,
                          selectedValue: formData.kacaJendelaKiriSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKacaJendelaKiriSelectedValue(value);
                          },
                          initialEnabled: formData.kacaJendelaKiriIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKacaJendelaKiriIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKacaJendelaKiriSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Lisplang Kiri',
                          count: 10,
                          selectedValue: formData.lisplangKiriSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateLisplangKiriSelectedValue(value);
                          },
                          initialEnabled: formData.lisplangKiriIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateLisplangKiriIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateLisplangKiriSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Side Skirt Kiri',
                          count: 10,
                          selectedValue: formData.sideSkirtKiriSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateSideSkirtKiriSelectedValue(value);
                          },
                          initialEnabled: formData.sideSkirtKiriIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSideSkirtKiriIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSideSkirtKiriSelectedValue(-1);
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
