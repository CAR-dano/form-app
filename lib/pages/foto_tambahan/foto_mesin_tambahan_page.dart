import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/tambahan_image_selection.dart';

class FotoMesinTambahanPage extends ConsumerStatefulWidget {
  final ValueNotifier<bool> formSubmitted;

  const FotoMesinTambahanPage({
    super.key,
    required this.formSubmitted,
  });

  @override
  ConsumerState<FotoMesinTambahanPage> createState() => _FotoMesinTambahanPageState();
}

class _FotoMesinTambahanPageState extends ConsumerState<FotoMesinTambahanPage> 
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
    const String pageIdentifier = 'Mesin Tambahan'; // Define identifier

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
          key: const PageStorageKey<String>('pageSixMesinTambahanScrollKey'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              const PageTitle(data: 'Foto Mesin'),
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
