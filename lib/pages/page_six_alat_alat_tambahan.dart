import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/tambahan_image_selection.dart';
import 'package:form_app/providers/form_step_provider.dart';

class PageSixAlatAlatTambahan extends ConsumerStatefulWidget {
  final ValueNotifier<bool> formSubmitted;

  const PageSixAlatAlatTambahan({
    super.key,
    required this.formSubmitted,
  });

  @override
  ConsumerState<PageSixAlatAlatTambahan> createState() => _PageSixAlatAlatTambahanState();
}

class _PageSixAlatAlatTambahanState extends ConsumerState<PageSixAlatAlatTambahan> 
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
              PageNumber(data: '13/26'),
              const SizedBox(height: 4),
              PageTitle(data: 'Foto Alat-alat'),
              const SizedBox(height: 6.0),
              HeadingOne(text: 'Tambahan'),
              const SizedBox(height: 16.0),
              TambahanImageSelection(
                identifier: 'Alat-alat Tambahan',
                formSubmitted: widget.formSubmitted,
              ),
              const SizedBox(height: 32.0),
              NavigationButtonRow(
                onBackPressed: () => ref.read(formStepProvider.notifier).state--,
                onNextPressed: () => ref.read(formStepProvider.notifier).state++,
              ),
              const SizedBox(height: 24.0),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
