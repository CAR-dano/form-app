import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/tambahan_image_selection.dart';

class FotoKakiKakiTambahanPage extends ConsumerStatefulWidget {
  final ValueNotifier<bool> formSubmitted;

  const FotoKakiKakiTambahanPage({
    super.key,
    required this.formSubmitted,
  });

  @override
  ConsumerState<FotoKakiKakiTambahanPage> createState() => _FotoKakiKakiTambahanPageState();
}

class _FotoKakiKakiTambahanPageState extends ConsumerState<FotoKakiKakiTambahanPage> 
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const String pageIdentifier = 'Kaki-kaki Tambahan'; // Define identifier

    return SingleChildScrollView(
      clipBehavior: Clip.none,
      key: const PageStorageKey<String>('pageSixKakiKakiTambahanScrollKey'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageTitle(data: 'Foto Kaki-kaki'),
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
    );
  }
}
