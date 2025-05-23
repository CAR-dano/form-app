import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import ConsumerWidget
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/paint_thickness_input_field.dart';
import 'package:form_app/providers/form_provider.dart';

// Placeholder for Page Eight
class PageEight extends ConsumerStatefulWidget {
  // Changed to ConsumerStatefulWidget
  const PageEight({super.key});

  @override
  ConsumerState<PageEight> createState() => _PageEightState();
}

class _PageEightState extends ConsumerState<PageEight>
    with AutomaticKeepAliveClientMixin {
  // Add mixin
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
    super.build(
      context,
    ); // Call super.build(context) for AutomaticKeepAliveClientMixin
    final formData = ref.watch(formProvider); // Watch the form data
    final formNotifier = ref.read(formProvider.notifier); // Read the notifier
    // ref is available directly in ConsumerStatefulWidget state classes
    // Basic structure, replace with actual content later

    return PopScope(
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          _focusScopeNode.unfocus(); // Unfocus when navigating back
        }
      },
      child: FocusScope(
        node: _focusScopeNode,
        child: SingleChildScrollView(
          key: const PageStorageKey<String>(
            'pageEightScrollKey',
          ), // This key remains important
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageNumber(data: '8/9'),
              const SizedBox(height: 4),
              PageTitle(data: 'Ketebalan Cat'), // Updated Title
              const SizedBox(height: 6.0),
              
              // Section 1: Depan
              HeadingOne(text: 'Depan'),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 34.0), // Offset to the right
                      child: PaintThicknessInputField(
                        initialValue: formData.catDepanKap,
                        onChanged: (value) {
                          formNotifier.updateCatDepanKap(value);
                        },
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300), // Limit image width
                      child: Image.asset('assets/images/depan.png'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Section 2: Belakang
              HeadingOne(text: 'Belakang'),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PaintThicknessInputField(
                          initialValue: formData.catBelakangBumper,
                          onChanged: (value) {
                            formNotifier.updateCatBelakangBumper(value);
                          },
                        ),
                        PaintThicknessInputField(
                          initialValue: formData.catBelakangTrunk,
                          onChanged: (value) {
                            formNotifier.updateCatBelakangTrunk(value);
                          },
                        ),
                      ],
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300), // Limit image width
                      child: Image.asset('assets/images/belakang.png'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Section 3: Samping Kanan
              HeadingOne(text: 'Samping Kanan'),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PaintThicknessInputField(
                          initialValue: formData.catKananFenderDepan,
                          onChanged: (value) {
                            formNotifier.updateCatKananFenderDepan(value);
                          },
                        ),
                        PaintThicknessInputField(
                          initialValue: formData.catKananPintuDepan,
                          onChanged: (value) {
                            formNotifier.updateCatKananPintuDepan(value);
                          },
                        ),
                        PaintThicknessInputField(
                          initialValue: formData.catKananPintuBelakang,
                          onChanged: (value) {
                            formNotifier.updateCatKananPintuBelakang(value);
                          },
                        ),
                        PaintThicknessInputField(
                          initialValue: formData.catKananFenderBelakang,
                          onChanged: (value) {
                            formNotifier.updateCatKananFenderBelakang(value);
                          },
                        ),
                      ],
                    ),
                    Image.asset('assets/images/kanan.png'),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Section 4: Samping Kiri
              HeadingOne(text: 'Samping Kiri'),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PaintThicknessInputField(
                          initialValue: formData.catKiriFenderDepan,
                          onChanged: (value) {
                            formNotifier.updateCatKiriFenderDepan(value);
                          },
                        ),
                        PaintThicknessInputField(
                          initialValue: formData.catKiriPintuDepan,
                          onChanged: (value) {
                            formNotifier.updateCatKiriPintuDepan(value);
                          },
                        ),
                        PaintThicknessInputField(
                          initialValue: formData.catKiriPintuBelakang,
                          onChanged: (value) {
                            formNotifier.updateCatKiriPintuBelakang(value);
                          },
                        ),
                        PaintThicknessInputField(
                          initialValue: formData.catKiriFenderBelakang,
                          onChanged: (value) {
                            formNotifier.updateCatKiriFenderBelakang(value);
                          },
                        ),
                      ],
                    ),
                    Image.asset('assets/images/kiri.png'),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),

              NavigationButtonRow(
                onBackPressed: () => ref.read(formStepProvider.notifier).state--,
                onNextPressed: () => ref.read(formStepProvider.notifier).state++,
              ),
              const SizedBox(
                height: 24.0,
              ), // Optional spacing below the content
              // Footer
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
