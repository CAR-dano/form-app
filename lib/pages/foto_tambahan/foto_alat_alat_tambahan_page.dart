import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/tambahan_image_selection.dart';

class FotoAlatAlatTambahanPage extends ConsumerStatefulWidget {
  final ValueNotifier<bool> formSubmitted;

  const FotoAlatAlatTambahanPage({
    super.key,
    required this.formSubmitted,
  });

  @override
  ConsumerState<FotoAlatAlatTambahanPage> createState() => _FotoAlatAlatTambahanPageState();
}

class _FotoAlatAlatTambahanPageState extends ConsumerState<FotoAlatAlatTambahanPage> 
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
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const String pageIdentifier = 'Alat-alat Tambahan'; // Define identifier

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
          key: const PageStorageKey<String>('pageSixAlatAlatTambahanScrollKey'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              const PageTitle(data: 'Foto Alat-alat'),
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
