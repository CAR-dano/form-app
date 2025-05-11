import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
// import 'package:form_app/pages/page_five_six.dart'; // No longer directly navigating
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PageFiveFive extends ConsumerStatefulWidget {
  const PageFiveFive({super.key});

  @override
  ConsumerState<PageFiveFive> createState() => _PageFiveFiveState();
}

class _PageFiveFiveState extends ConsumerState<PageFiveFive> with AutomaticKeepAliveClientMixin { // Add mixin
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
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          _focusScopeNode.unfocus();
        }
      },
      child: FocusScope(
        node: _focusScopeNode,
        child: GestureDetector(
          onTap: () {
            _focusScopeNode.unfocus();
          },
          child: SingleChildScrollView(
            key: const PageStorageKey<String>('pageFiveFiveScrollKey'), // Add PageStorageKey here
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
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Velg Depan',
                  count: 10,
                  selectedValue: formData.velgDepanSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateVelgDepanSelectedValue(value);
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
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Master Rem',
                  count: 10,
                  selectedValue: formData.masterRemSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateMasterRemSelectedValue(value);
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
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Gardan',
                  count: 10,
                  selectedValue: formData.gardanSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateGardanSelectedValue(value);
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
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Velg Belakang',
                  count: 10,
                  selectedValue: formData.velgBelakangSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateVelgBelakangSelectedValue(value);
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
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Crossmember',
                  count: 10,
                  selectedValue: formData.crossmemberSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateCrossmemberSelectedValue(value);
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
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Balljoint',
                  count: 10,
                  selectedValue: formData.balljointSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateBalljointSelectedValue(value);
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
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Karet Boot',
                  count: 10,
                  selectedValue: formData.karetBootSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateKaretBootSelectedValue(value);
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
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Shock Breaker',
                  count: 10,
                  selectedValue: formData.shockBreakerSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateShockBreakerSelectedValue(value);
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
