import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/pages/page_five_three.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PageFiveTwo extends ConsumerStatefulWidget {
  const PageFiveTwo({super.key});

  @override
  ConsumerState<PageFiveTwo> createState() => _PageFiveTwoState();
}

class _PageFiveTwoState extends ConsumerState<PageFiveTwo> {
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
      // Wrap with PopScope
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          _focusScopeNode.unfocus(); // Unfocus when navigating back
        }
      },
      child: FocusScope(
        // Wrap with FocusScope
        node: _focusScopeNode,
        child: CommonLayout(
          child: GestureDetector(
            // Wrap with GestureDetector
            onTap: () {
              _focusScopeNode.unfocus(); // Unfocus on tap outside text fields
            },
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PageNumber(data: '5/9'), // Assuming this page is still 5/9 or needs adjustment
                        const SizedBox(height: 8.0),
                        PageTitle(data: 'Penilaian (2)'),
                        const SizedBox(height: 24.0),
                        const HeadingOne(text: 'Hasil Inspeksi Mesin'),
                        const SizedBox(height: 16.0),

                        // ToggleableNumberedButtonList widgets
                        ToggleableNumberedButtonList(
                          label: 'Getaran Mesin',
                          count: 10,
                          selectedValue: formData.getaranMesinSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateGetaranMesinSelectedIndex(value);
                          },
                          initialEnabled: formData.getaranMesinIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateGetaranMesinIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateGetaranMesinSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Suara Mesin',
                          count: 10,
                          selectedValue: formData.suaraMesinSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateSuaraMesinSelectedIndex(value);
                          },
                          initialEnabled: formData.suaraMesinIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSuaraMesinIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSuaraMesinSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Transmisi',
                          count: 10,
                          selectedValue: formData.transmisiSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateTransmisiSelectedIndex(value);
                          },
                          initialEnabled: formData.transmisiIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateTransmisiIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateTransmisiSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Pompa Power Steering',
                          count: 10,
                          selectedValue: formData.pompaPowerSteeringSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePompaPowerSteeringSelectedIndex(value);
                          },
                          initialEnabled: formData.pompaPowerSteeringIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePompaPowerSteeringIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePompaPowerSteeringSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Cover Timing Chain',
                          count: 10,
                          selectedValue: formData.coverTimingChainSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateCoverTimingChainSelectedIndex(value);
                          },
                          initialEnabled: formData.coverTimingChainIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateCoverTimingChainIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateCoverTimingChainSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Oli Power Steering',
                          count: 10,
                          selectedValue: formData.oliPowerSteeringSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateOliPowerSteeringSelectedIndex(value);
                          },
                          initialEnabled: formData.oliPowerSteeringIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateOliPowerSteeringIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateOliPowerSteeringSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Accu',
                          count: 10,
                          selectedValue: formData.accuSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateAccuSelectedIndex(value);
                          },
                          initialEnabled: formData.accuIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateAccuIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateAccuSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Kompressor AC',
                          count: 10,
                          selectedValue: formData.kompressorAcSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKompressorAcSelectedIndex(value);
                          },
                          initialEnabled: formData.kompressorAcIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKompressorAcIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKompressorAcSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Fan',
                          count: 10,
                          selectedValue: formData.fanSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateFanSelectedIndex(value);
                          },
                          initialEnabled: formData.fanIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateFanIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateFanSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Selang',
                          count: 10,
                          selectedValue: formData.selangSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateSelangSelectedIndex(value);
                          },
                          initialEnabled: formData.selangIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSelangIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSelangSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Karter Oli',
                          count: 10,
                          selectedValue: formData.karterOliSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKarterOliSelectedIndex(value);
                          },
                          initialEnabled: formData.karterOliIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKarterOliIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKarterOliSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Oil Rem',
                          count: 10,
                          selectedValue: formData.oilRemSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateOilRemSelectedIndex(value);
                          },
                          initialEnabled: formData.oilRemIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateOilRemIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateOilRemSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Kabel',
                          count: 10,
                          selectedValue: formData.kabelSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKabelSelectedIndex(value);
                          },
                          initialEnabled: formData.kabelIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKabelIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKabelSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Kondensor',
                          count: 10,
                          selectedValue: formData.kondensorSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKondensorSelectedIndex(value);
                          },
                          initialEnabled: formData.kondensorIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKondensorIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKondensorSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Radiator',
                          count: 10,
                          selectedValue: formData.radiatorSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateRadiatorSelectedIndex(value);
                          },
                          initialEnabled: formData.radiatorIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateRadiatorIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateRadiatorSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Cylinder Head',
                          count: 10,
                          selectedValue: formData.cylinderHeadSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateCylinderHeadSelectedIndex(value);
                          },
                          initialEnabled: formData.cylinderHeadIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateCylinderHeadIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateCylinderHeadSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Oli Mesin',
                          count: 10,
                          selectedValue: formData.oliMesinSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateOliMesinSelectedIndex(value);
                          },
                          initialEnabled: formData.oliMesinIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateOliMesinIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateOliMesinSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Air Radiator',
                          count: 10,
                          selectedValue: formData.airRadiatorSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateAirRadiatorSelectedIndex(value);
                          },
                          initialEnabled: formData.airRadiatorIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateAirRadiatorIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateAirRadiatorSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Cover Klep',
                          count: 10,
                          selectedValue: formData.coverKlepSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateCoverKlepSelectedIndex(value);
                          },
                          initialEnabled: formData.coverKlepIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateCoverKlepIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateCoverKlepSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Alternator',
                          count: 10,
                          selectedValue: formData.alternatorSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateAlternatorSelectedIndex(value);
                          },
                          initialEnabled: formData.alternatorIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateAlternatorIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateAlternatorSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Water Pump',
                          count: 10,
                          selectedValue: formData.waterPumpSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateWaterPumpSelectedIndex(value);
                          },
                          initialEnabled: formData.waterPumpIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateWaterPumpIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateWaterPumpSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Belt',
                          count: 10,
                          selectedValue: formData.beltSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateBeltSelectedIndex(value);
                          },
                          initialEnabled: formData.beltIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateBeltIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateBeltSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Oli Transmisi',
                          count: 10,
                          selectedValue: formData.oliTransmisiSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateOliTransmisiSelectedIndex(value);
                          },
                          initialEnabled: formData.oliTransmisiIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateOliTransmisiIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateOliTransmisiSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Cylinder Block',
                          count: 10,
                          selectedValue: formData.cylinderBlockSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateCylinderBlockSelectedIndex(value);
                          },
                          initialEnabled: formData.cylinderBlockIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateCylinderBlockIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateCylinderBlockSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Bushing Besar',
                          count: 10,
                          selectedValue: formData.bushingBesarSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateBushingBesarSelectedIndex(value);
                          },
                          initialEnabled: formData.bushingBesarIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateBushingBesarIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateBushingBesarSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Bushing Kecil',
                          count: 10,
                          selectedValue: formData.bushingKecilSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateBushingKecilSelectedIndex(value);
                          },
                          initialEnabled: formData.bushingKecilIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateBushingKecilIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateBushingKecilSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Tutup Radiator',
                          count: 10,
                          selectedValue: formData.tutupRadiatorSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateTutupRadiatorSelectedIndex(value);
                          },
                          initialEnabled: formData.tutupRadiatorIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateTutupRadiatorIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateTutupRadiatorSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),

                        // ExpandableTextField
                        ExpandableTextField(
                          label: 'Catatan',
                          hintText: 'Masukkan catatan di sini',
                          initialLines: formData.mesinCatatanList,
                          onChangedList: (lines) {
                            formNotifier.updateMesinCatatanList(lines);
                          },
                        ),
                        const SizedBox(height: 32.0),

                        NavigationButtonRow(
                          onBackPressed: () => Navigator.pop(context),
                          onNextPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PageFiveThree()),
                            );
                          },
                        ),
                        const SizedBox(height: 32.0),
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
