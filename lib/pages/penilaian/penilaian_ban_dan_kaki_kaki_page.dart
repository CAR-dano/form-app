import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart'; // Import FormData
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PenilaianBanDanKakiKakiPage extends ConsumerStatefulWidget {
  const PenilaianBanDanKakiKakiPage({
    super.key,
  });

  @override
  ConsumerState<PenilaianBanDanKakiKakiPage> createState() => _PenilaianBanDanKakiKakiPage();
}

class _PenilaianBanDanKakiKakiPage extends ConsumerState<PenilaianBanDanKakiKakiPage> with AutomaticKeepAliveClientMixin { // Add mixin
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
          child: CustomScrollView(
            key: const PageStorageKey<String>('pageFiveFiveScrollKey'),
            slivers: [
              const SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageTitle(data: 'Penilaian (5)'),
                    SizedBox(height: 6.0),
                    HeadingOne(text: 'Ban dan Kaki-kaki'),
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final itemData = _buildToggleableNumberedButtonLists(formData, formNotifier)[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: ToggleableNumberedButtonList(
                        label: itemData['label'],
                        count: 10,
                        selectedValue: itemData['selectedValue'] ?? -1,
                        onItemSelected: itemData['onItemSelected'],
                      ),
                    );
                  },
                  childCount: _buildToggleableNumberedButtonLists(formData, formNotifier).length,
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    ExpandableTextField(
                      label: 'Catatan',
                      hintText: 'Masukkan catatan di sini',
                      initialLines: formData.banDanKakiKakiCatatanList,
                      onChangedList: (lines) {
                        formNotifier.updateBanDanKakiKakiCatatanList(lines);
                      },
                    ),
                    const SizedBox(height: 32.0),
                    const SizedBox(height: 24.0),
                    const Footer(),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom + 90),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _buildToggleableNumberedButtonLists(FormData formData, FormNotifier formNotifier) {
    final List<Map<String, dynamic>> toggleableNumberedButtonListData = [
      {
        'label': 'Ban Depan',
        'selectedValue': formData.banDepanSelectedValue,
        'onItemSelected': (value) => formNotifier.updateBanDepanSelectedValue(value),
      },
      {
        'label': 'Velg Depan',
        'selectedValue': formData.velgDepanSelectedValue,
        'onItemSelected': (value) => formNotifier.updateVelgDepanSelectedValue(value),
      },
      {
        'label': 'Disc Brake',
        'selectedValue': formData.discBrakeSelectedValue,
        'onItemSelected': (value) => formNotifier.updateDiscBrakeSelectedValue(value),
      },
      {
        'label': 'Master Rem',
        'selectedValue': formData.masterRemSelectedValue,
        'onItemSelected': (value) => formNotifier.updateMasterRemSelectedValue(value),
      },
      {
        'label': 'Tie Rod',
        'selectedValue': formData.tieRodSelectedValue,
        'onItemSelected': (value) => formNotifier.updateTieRodSelectedValue(value),
      },
      {
        'label': 'Gardan',
        'selectedValue': formData.gardanSelectedValue,
        'onItemSelected': (value) => formNotifier.updateGardanSelectedValue(value),
      },
      {
        'label': 'Ban Belakang',
        'selectedValue': formData.banBelakangSelectedValue,
        'onItemSelected': (value) => formNotifier.updateBanBelakangSelectedValue(value),
      },
      {
        'label': 'Velg Belakang',
        'selectedValue': formData.velgBelakangSelectedValue,
        'onItemSelected': (value) => formNotifier.updateVelgBelakangSelectedValue(value),
      },
      {
        'label': 'Brake Pad',
        'selectedValue': formData.brakePadSelectedValue,
        'onItemSelected': (value) => formNotifier.updateBrakePadSelectedValue(value),
      },
      {
        'label': 'Crossmember',
        'selectedValue': formData.crossmemberSelectedValue,
        'onItemSelected': (value) => formNotifier.updateCrossmemberSelectedValue(value),
      },
      {
        'label': 'Knalpot',
        'selectedValue': formData.knalpotSelectedValue,
        'onItemSelected': (value) => formNotifier.updateKnalpotSelectedValue(value),
      },
      {
        'label': 'Balljoint',
        'selectedValue': formData.balljointSelectedValue,
        'onItemSelected': (value) => formNotifier.updateBalljointSelectedValue(value),
      },
      {
        'label': 'Racksteer',
        'selectedValue': formData.racksteerSelectedValue,
        'onItemSelected': (value) => formNotifier.updateRacksteerSelectedValue(value),
      },
      {
        'label': 'Karet Boot',
        'selectedValue': formData.karetBootSelectedValue,
        'onItemSelected': (value) => formNotifier.updateKaretBootSelectedValue(value),
      },
      {
        'label': 'Upper-Lower Arm',
        'selectedValue': formData.upperLowerArmSelectedValue,
        'onItemSelected': (value) => formNotifier.updateUpperLowerArmSelectedValue(value),
      },
      {
        'label': 'Shock Breaker',
        'selectedValue': formData.shockBreakerSelectedValue,
        'onItemSelected': (value) => formNotifier.updateShockBreakerSelectedValue(value),
      },
      {
        'label': 'Link Stabilizer',
        'selectedValue': formData.linkStabilizerSelectedValue,
        'onItemSelected': (value) => formNotifier.updateLinkStabilizerSelectedValue(value),
      },
    ];

    return toggleableNumberedButtonListData;
  }
}
