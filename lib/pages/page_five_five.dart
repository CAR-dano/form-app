import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/pages/page_five_six.dart'; // Import PageFiveSix
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PageFiveFive extends ConsumerStatefulWidget {
  const PageFiveFive({super.key});

  @override
  ConsumerState<PageFiveFive> createState() => _PageFiveFiveState();
}

class _PageFiveFiveState extends ConsumerState<PageFiveFive> {
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
                        PageTitle(data: 'Penilaian (5)'),
                        const SizedBox(height: 6.0),
                        const HeadingOne(text: 'Ban dan Kaki-kaki'),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Ban Depan',
                          count: 10,
                          selectedValue: formData.banDepanSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateBanDepanSelectedValue(value);
                          },
                          initialEnabled: formData.banDepanIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateBanDepanIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateBanDepanSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Velg Depan',
                          count: 10,
                          selectedValue: formData.velgDepanSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateVelgDepanSelectedValue(value);
                          },
                          initialEnabled: formData.velgDepanIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateVelgDepanIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateVelgDepanSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Disc Brake',
                          count: 10,
                          selectedValue: formData.discBrakeSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateDiscBrakeSelectedValue(value);
                          },
                          initialEnabled: formData.discBrakeIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateDiscBrakeIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateDiscBrakeSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Master Rem',
                          count: 10,
                          selectedValue: formData.masterRemSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateMasterRemSelectedValue(value);
                          },
                          initialEnabled: formData.masterRemIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateMasterRemIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateMasterRemSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Tie Rod',
                          count: 10,
                          selectedValue: formData.tieRodSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateTieRodSelectedValue(value);
                          },
                          initialEnabled: formData.tieRodIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateTieRodIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateTieRodSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Gardan',
                          count: 10,
                          selectedValue: formData.gardanSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateGardanSelectedValue(value);
                          },
                          initialEnabled: formData.gardanIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateGardanIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateGardanSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Ban Belakang',
                          count: 10,
                          selectedValue: formData.banBelakangSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateBanBelakangSelectedValue(value);
                          },
                          initialEnabled: formData.banBelakangIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateBanBelakangIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateBanBelakangSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Velg Belakang',
                          count: 10,
                          selectedValue: formData.velgBelakangSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateVelgBelakangSelectedValue(value);
                          },
                          initialEnabled: formData.velgBelakangIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateVelgBelakangIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateVelgBelakangSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Brake Pad',
                          count: 10,
                          selectedValue: formData.brakePadSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateBrakePadSelectedValue(value);
                          },
                          initialEnabled: formData.brakePadIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateBrakePadIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateBrakePadSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Crossmember',
                          count: 10,
                          selectedValue: formData.crossmemberSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateCrossmemberSelectedValue(value);
                          },
                          initialEnabled: formData.crossmemberIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateCrossmemberIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateCrossmemberSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Knalpot',
                          count: 10,
                          selectedValue: formData.knalpotSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKnalpotSelectedValue(value);
                          },
                          initialEnabled: formData.knalpotIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKnalpotIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKnalpotSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Balljoint',
                          count: 10,
                          selectedValue: formData.balljointSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateBalljointSelectedValue(value);
                          },
                          initialEnabled: formData.balljointIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateBalljointIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateBalljointSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Rocksteer',
                          count: 10,
                          selectedValue: formData.rocksteerSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateRocksteerSelectedValue(value);
                          },
                          initialEnabled: formData.rocksteerIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateRocksteerIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateRocksteerSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Karet Boot',
                          count: 10,
                          selectedValue: formData.karetBootSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateKaretBootSelectedValue(value);
                          },
                          initialEnabled: formData.karetBootIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateKaretBootIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateKaretBootSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Upper-Lower Arm',
                          count: 10,
                          selectedValue: formData.upperLowerArmSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateUpperLowerArmSelectedValue(value);
                          },
                          initialEnabled: formData.upperLowerArmIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateUpperLowerArmIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateUpperLowerArmSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Shock Breaker',
                          count: 10,
                          selectedValue: formData.shockBreakerSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateShockBreakerSelectedValue(value);
                          },
                          initialEnabled: formData.shockBreakerIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateShockBreakerIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateShockBreakerSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Link Stabilizer',
                          count: 10,
                          selectedValue: formData.linkStabilizerSelectedValue ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateLinkStabilizerSelectedValue(value);
                          },
                          initialEnabled: formData.linkStabilizerIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateLinkStabilizerIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateLinkStabilizerSelectedValue(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ExpandableTextField(
                          label: 'Catatan',
                          hintText: 'Masukkan catatan di sini',
                          initialLines: formData.banDanKakiKakiCatatanList,
                          onChangedList: (lines) {
                            formNotifier.updateBanDanKakiKakiCatatanList(lines);
                          },
                        ),
                        const SizedBox(height: 32.0),
                        NavigationButtonRow(
                          onBackPressed: () => Navigator.pop(context),
                          onNextPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PageFiveSix()),
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
