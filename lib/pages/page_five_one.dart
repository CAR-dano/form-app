import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/pages/page_five_two.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PageFiveOne extends ConsumerStatefulWidget {
  const PageFiveOne({super.key});

  @override
  ConsumerState<PageFiveOne> createState() => _PageFiveOneState();
}

class _PageFiveOneState extends ConsumerState<PageFiveOne> {
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
                        PageNumber(data: '5/9'),
                        const SizedBox(height: 8.0),
                        PageTitle(data: 'Penilaian (1)'),
                        const SizedBox(height: 24.0),
                        HeadingOne(text: 'Fitur'),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Airbag',
                          count: 10,
                          selectedValue: formData.airbagSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateAirbagSelectedIndex(value);
                          },
                          initialEnabled: formData.airbagIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateAirbagIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateAirbagSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Sistem Audio',
                          count: 10,
                          selectedValue: formData.sistemAudioSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateSistemAudioSelectedIndex(value);
                          },
                          initialEnabled: formData.sistemAudioIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSistemAudioIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSistemAudioSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Power Window',
                          count: 10,
                          selectedValue: formData.powerWindowSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updatePowerWindowSelectedIndex(value);
                          },
                          initialEnabled: formData.powerWindowIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updatePowerWindowIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updatePowerWindowSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ToggleableNumberedButtonList(
                          label: 'Sistem AC',
                          count: 10,
                          selectedValue: formData.sistemAcSelectedIndex ?? -1,
                          onItemSelected: (value) {
                            formNotifier.updateSistemAcSelectedIndex(value);
                          },
                          initialEnabled: formData.sistemAcIsEnabled ?? true,
                          onEnabledChanged: (enabled) {
                            formNotifier.updateSistemAcIsEnabled(enabled);
                            if (!enabled) {
                              formNotifier.updateSistemAcSelectedIndex(-1);
                            }
                          },
                        ),
                        const SizedBox(height: 16.0),
                        ExpandableTextField(
                          label: 'Catatan',
                          hintText: 'Masukkan catatan di sini',
                          initialLines: formData.fiturCatatanList,
                          onChangedList: (lines) {
                            formNotifier.updateFiturCatatanList(lines);
                          },
                        ),
                        const SizedBox(height: 32.0),
                        NavigationButtonRow(
                          onBackPressed: () => Navigator.pop(context),
                          onNextPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const PageFiveTwo()),
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
