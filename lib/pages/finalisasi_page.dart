import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/form_confirmation.dart';
import 'package:form_app/widgets/loading_indicator_widget.dart';
import 'package:form_app/providers/submission_status_provider.dart'; // Import the new provider

// Placeholder for Page Nine
class FinalisasiPage extends ConsumerStatefulWidget {
  // Removed all form-related GlobalKeys and ValueNotifiers as they are now managed by MultiStepFormScreen
  // Removed pageNames, validatePage, tambahanImagePageIdentifiers, defaultTambahanLabel
  // as they are used by the submission logic now in MultiStepFormScreen

  // New parameters to receive state and callbacks from MultiStepFormScreen
  final void Function(bool newValue) onCheckedChange;
  final bool isChecked;

  const FinalisasiPage({
    super.key,
    required this.onCheckedChange,
    required this.isChecked,
  });

  @override
  ConsumerState<FinalisasiPage> createState() => _FinalisasiPageState();
}

class _FinalisasiPageState extends ConsumerState<FinalisasiPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final submissionStatus = ref.watch(submissionStatusProvider);

    return Column(
      children: [
        Expanded( // Makes the main content area scrollable
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            key: const PageStorageKey<String>('pageNineScrollKey'),
            child: Padding( // Add padding to the scrollable content
              padding: const EdgeInsets.symmetric(horizontal: 0), // Match CommonLayout padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PageTitle(data: 'Finalisasi'),
                  const SizedBox(height: 6.0),
                  Text(
                    'Pastikan data yang telah diisi telah sesuai dengan yang sebenarnya dan memenuhi SOP PT Inspeksi Mobil Jogja',
                    style: labelStyle.copyWith(fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 16.0),
                  FormConfirmation(
                    label: 'Data yang saya isi telah sesuai',
                    initialValue: widget.isChecked, // Use passed in value
                    onChanged: (bool newValue) {
                      widget.onCheckedChange(newValue); // Use passed in callback
                    },
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
        // Loading Indicator (moved from FinalisasiPage's original NavigationButtonRow section)
        if (submissionStatus.isLoading)
          LoadingIndicatorWidget(
            message: submissionStatus.message,
            progress: submissionStatus.progress,
          ),
        const SizedBox(height: 24.0), // Add space where NavigationButtonRow used to be
        const Footer(),
      ],
    );
  }
}
