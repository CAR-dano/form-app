import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/tambahan_image_selection.dart';

// Foto Dokumen Page (formerly Page Seven)
class FotoDokumenPage extends ConsumerStatefulWidget { 
  final ValueNotifier<bool> formSubmitted;
  final String defaultLabel;

  const FotoDokumenPage({
    super.key,
    required this.formSubmitted,
    required this.defaultLabel,
  });

  @override
  ConsumerState<FotoDokumenPage> createState() => _FotoDokumenPageState();
}

class _FotoDokumenPageState extends ConsumerState<FotoDokumenPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const String pageIdentifier = 'Foto Dokumen'; // Define identifier

    return SingleChildScrollView(
      clipBehavior: Clip.none,
      key: const PageStorageKey<String>('pageSevenScrollKey'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          const PageTitle(data: 'Foto Dokumen'),
          const SizedBox(height: 6.0),
          TambahanImageSelection(
            identifier: pageIdentifier, // Use the defined identifier
            showNeedAttention: false,
            isMandatory: true, // Set isMandatory to true for Page Seven
            formSubmitted: widget.formSubmitted,
            defaultLabel: widget.defaultLabel, // Pass the defaultLabel
          ),
      
          const SizedBox(height: 32.0),
          const SizedBox(height: 24.0),
          const Footer(),
        ],
      ),
    );
  }
}
