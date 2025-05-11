import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PageFiveTwo extends ConsumerStatefulWidget {
  const PageFiveTwo({super.key});

  @override
  ConsumerState<PageFiveTwo> createState() => _PageFiveTwoState();
}

class _PageFiveTwoState extends ConsumerState<PageFiveTwo> with AutomaticKeepAliveClientMixin { // Add mixin
  late FocusScopeNode _focusScopeNode;

  @override
  bool get wantKeepAlive => true; // Override wantKeepAlive

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
    super.build(context); // Call super.build(context) for AutomaticKeepAliveClientMixin
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
        child: GestureDetector(
          // Wrap with GestureDetector
          onTap: () {
            _focusScopeNode.unfocus(); // Unfocus on tap outside text fields
          },
          child: SingleChildScrollView(
            key: const PageStorageKey<String>('pageFiveTwoScrollKey'), // Add PageStorageKey here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageNumber(data: '5/9'),
                const SizedBox(height: 4),
                PageTitle(data: 'Penilaian (2)'),
                const SizedBox(height: 6.0),
                const HeadingOne(text: 'Hasil Inspeksi Mesin'),
                const SizedBox(height: 16.0),
                
                // ToggleableNumberedButtonList widgets
                ToggleableNumberedButtonList(
                  label: 'Getaran Mesin',
                  count: 10,
                  selectedValue: formData.getaranMesinSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateGetaranMesinSelectedValue(value);
                  },
                  initialEnabled: formData.getaranMesinIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateGetaranMesinIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateGetaranMesinSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Suara Mesin',
                  count: 10,
                  selectedValue: formData.suaraMesinSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateSuaraMesinSelectedValue(value);
                  },
                  initialEnabled: formData.suaraMesinIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateSuaraMesinIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateSuaraMesinSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Transmisi',
                  count: 10,
                  selectedValue: formData.transmisiSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateTransmisiSelectedValue(value);
                  },
                  initialEnabled: formData.transmisiIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateTransmisiIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateTransmisiSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Pompa Power Steering',
                  count: 10,
                  selectedValue: formData.pompaPowerSteeringSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePompaPowerSteeringSelectedValue(value);
                  },
                  initialEnabled: formData.pompaPowerSteeringIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updatePompaPowerSteeringIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updatePompaPowerSteeringSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Cover Timing Chain',
                  count: 10,
                  selectedValue: formData.coverTimingChainSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateCoverTimingChainSelectedValue(value);
                  },
                  initialEnabled: formData.coverTimingChainIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateCoverTimingChainIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateCoverTimingChainSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Oli Power Steering',
                  count: 10,
                  selectedValue: formData.oliPowerSteeringSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateOliPowerSteeringSelectedValue(value);
                  },
                  initialEnabled: formData.oliPowerSteeringIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateOliPowerSteeringIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateOliPowerSteeringSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Accu',
                  count: 10,
                  selectedValue: formData.accuSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateAccuSelectedValue(value);
                  },
                  initialEnabled: formData.accuIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateAccuIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateAccuSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Kompressor AC',
                  count: 10,
                  selectedValue: formData.kompressorAcSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateKompressorAcSelectedValue(value);
                  },
                  initialEnabled: formData.kompressorAcIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateKompressorAcIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateKompressorAcSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Fan',
                  count: 10,
                  selectedValue: formData.fanSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateFanSelectedValue(value);
                  },
                  initialEnabled: formData.fanIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateFanIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateFanSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Selang',
                  count: 10,
                  selectedValue: formData.selangSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateSelangSelectedValue(value);
                  },
                  initialEnabled: formData.selangIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateSelangIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateSelangSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Karter Oli',
                  count: 10,
                  selectedValue: formData.karterOliSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateKarterOliSelectedValue(value);
                  },
                  initialEnabled: formData.karterOliIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateKarterOliIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateKarterOliSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Oil Rem',
                  count: 10,
                  selectedValue: formData.oilRemSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateOilRemSelectedValue(value);
                  },
                  initialEnabled: formData.oilRemIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateOilRemIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateOilRemSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Kabel',
                  count: 10,
                  selectedValue: formData.kabelSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateKabelSelectedValue(value);
                  },
                  initialEnabled: formData.kabelIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateKabelIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateKabelSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Kondensor',
                  count: 10,
                  selectedValue: formData.kondensorSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateKondensorSelectedValue(value);
                  },
                  initialEnabled: formData.kondensorIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateKondensorIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateKondensorSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Radiator',
                  count: 10,
                  selectedValue: formData.radiatorSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateRadiatorSelectedValue(value);
                  },
                  initialEnabled: formData.radiatorIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateRadiatorIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateRadiatorSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Cylinder Head',
                  count: 10,
                  selectedValue: formData.cylinderHeadSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateCylinderHeadSelectedValue(value);
                  },
                  initialEnabled: formData.cylinderHeadIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateCylinderHeadIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateCylinderHeadSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Oli Mesin',
                  count: 10,
                  selectedValue: formData.oliMesinSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateOliMesinSelectedValue(value);
                  },
                  initialEnabled: formData.oliMesinIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateOliMesinIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateOliMesinSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Air Radiator',
                  count: 10,
                  selectedValue: formData.airRadiatorSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateAirRadiatorSelectedValue(value);
                  },
                  initialEnabled: formData.airRadiatorIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateAirRadiatorIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateAirRadiatorSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Cover Klep',
                  count: 10,
                  selectedValue: formData.coverKlepSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateCoverKlepSelectedValue(value);
                  },
                  initialEnabled: formData.coverKlepIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateCoverKlepIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateCoverKlepSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Alternator',
                  count: 10,
                  selectedValue: formData.alternatorSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateAlternatorSelectedValue(value);
                  },
                  initialEnabled: formData.alternatorIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateAlternatorIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateAlternatorSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Water Pump',
                  count: 10,
                  selectedValue: formData.waterPumpSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateWaterPumpSelectedValue(value);
                  },
                  initialEnabled: formData.waterPumpIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateWaterPumpIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateWaterPumpSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Belt',
                  count: 10,
                  selectedValue: formData.beltSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateBeltSelectedValue(value);
                  },
                  initialEnabled: formData.beltIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateBeltIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateBeltSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Oli Transmisi',
                  count: 10,
                  selectedValue: formData.oliTransmisiSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateOliTransmisiSelectedValue(value);
                  },
                  initialEnabled: formData.oliTransmisiIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateOliTransmisiIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateOliTransmisiSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Cylinder Block',
                  count: 10,
                  selectedValue: formData.cylinderBlockSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateCylinderBlockSelectedValue(value);
                  },
                  initialEnabled: formData.cylinderBlockIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateCylinderBlockIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateCylinderBlockSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Bushing Besar',
                  count: 10,
                  selectedValue: formData.bushingBesarSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateBushingBesarSelectedValue(value);
                  },
                  initialEnabled: formData.bushingBesarIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateBushingBesarIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateBushingBesarSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Bushing Kecil',
                  count: 10,
                  selectedValue: formData.bushingKecilSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateBushingKecilSelectedValue(value);
                  },
                  initialEnabled: formData.bushingKecilIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateBushingKecilIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateBushingKecilSelectedValue(-1);
                    }
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Tutup Radiator',
                  count: 10,
                  selectedValue: formData.tutupRadiatorSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateTutupRadiatorSelectedValue(value);
                  },
                  initialEnabled: formData.tutupRadiatorIsEnabled ?? true,
                  onEnabledChanged: (enabled) {
                    formNotifier.updateTutupRadiatorIsEnabled(enabled);
                    if (!enabled) {
                      formNotifier.updateTutupRadiatorSelectedValue(-1);
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
                  onBackPressed: () {
                    _focusScopeNode.unfocus();
                    ref.read(formStepProvider.notifier).state--;
                  },
                  onNextPressed: () {
                    _focusScopeNode.unfocus();
                    ref.read(formStepProvider.notifier).state++;
                  },
                ),
                const SizedBox(height: 32.0),
                Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
