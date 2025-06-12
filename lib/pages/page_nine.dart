import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/form_confirmation.dart';
import 'package:form_app/widgets/loading_indicator_widget.dart';

// Placeholder for Page Nine
class PageNine extends ConsumerStatefulWidget {
  // Removed all form-related GlobalKeys and ValueNotifiers as they are now managed by MultiStepFormScreen
  // Removed pageNames, validatePage, tambahanImagePageIdentifiers, defaultTambahanLabel
  // as they are used by the submission logic now in MultiStepFormScreen

  // New parameters to receive state and callbacks from MultiStepFormScreen
  final void Function(bool newValue) onCheckedChange;
  final bool isChecked;
  final bool isLoading;
  final String loadingMessage;
  final double currentProgress;

  const PageNine({
    super.key,
    required this.onCheckedChange,
    required this.isChecked,
    required this.isLoading,
    required this.loadingMessage,
    required this.currentProgress,
  });

  @override
  ConsumerState<PageNine> createState() => _PageNineState();
}

class _PageNineState extends ConsumerState<PageNine> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  PageNumber(data: '26/26'), // Consider making this dynamic
                  const SizedBox(height: 4),
                  PageTitle(data: 'Finalisasi'),
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
        // Loading Indicator (moved from PageNine's original NavigationButtonRow section)
        if (widget.isLoading)
          LoadingIndicatorWidget(
            message: widget.loadingMessage,
            progress: widget.currentProgress,
          ),
        const SizedBox(height: 24.0), // Add space where NavigationButtonRow used to be
        const Footer(),
      ],
    );
  }
}
