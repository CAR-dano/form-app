import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/tambahan_image_selection.dart';

class FotoGeneralTambahanPage extends ConsumerStatefulWidget {
  final ValueNotifier<bool> formSubmitted;

  const FotoGeneralTambahanPage({
    super.key,
    required this.formSubmitted,
  });

  @override
  ConsumerState<FotoGeneralTambahanPage> createState() => _FotoGeneralTambahanPageState();
}

class _FotoGeneralTambahanPageState extends ConsumerState<FotoGeneralTambahanPage>
    with AutomaticKeepAliveClientMixin {
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
  bool get wantKeepAlive => true; // Override wantKeepAlive

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const String pageIdentifier = 'General Tambahan'; // Define identifier

    return PopScope(
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          _focusScopeNode.unfocus();
        }
      },
      child: FocusScope(
        node: _focusScopeNode,
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          key: const PageStorageKey<String>('pageSixGeneralTambahanScrollKey'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              const PageTitle(data: 'Foto General'),
              const SizedBox(height: 6.0),
              const HeadingOne(text: 'Tambahan'),
              const SizedBox(height: 16.0),
              TambahanImageSelection(
                identifier: pageIdentifier, // Use the defined identifier
                formSubmitted: widget.formSubmitted,
              ),
              const SizedBox(height: 32.0),
              const SizedBox(height: 24.0),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
