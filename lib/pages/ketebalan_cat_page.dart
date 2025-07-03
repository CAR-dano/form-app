import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/paint_thickness_input_field.dart';
import 'package:form_app/providers/form_provider.dart';

class KetebalanCatPage extends ConsumerStatefulWidget {
  const KetebalanCatPage({
    super.key,
  });

  @override
  ConsumerState<KetebalanCatPage> createState() => _KetebalanCatPage();
}

class _KetebalanCatPage extends ConsumerState<KetebalanCatPage>
    with AutomaticKeepAliveClientMixin {
  late FocusScopeNode _focusScopeNode;

  @override
  bool get wantKeepAlive => true;

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
    );
    final formData = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);

    return PopScope(
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          _focusScopeNode.unfocus(); // Unfocus when navigating back
        }
      },
      child: FocusScope(
        node: _focusScopeNode,
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          key: const PageStorageKey<String>(
            'pageEightScrollKey',
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PageTitle(data: 'Ketebalan Cat'),
              const SizedBox(height: 6.0),
              
              // Section 1: Depan
              const HeadingOne(text: 'Depan'),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width * 0.08),
                        PaintThicknessInputField(
                          initialValue: formData.catDepanKap,
                          onChanged: (value) {
                            formNotifier.updateCatDepanKap(value);
                          },
                        ),
                      ],
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 300),
                      child: Image.asset('assets/images/depan.png'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Section 2: Belakang
              const HeadingOne(text: 'Belakang'),
              Center(
                child: SizedBox(
                  width: 300,
                  height: 200,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        top: 30.0,
                        left: 0,
                        right: 0,
                        child: Align(
                          alignment: Alignment.center,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: Image.asset('assets/images/belakang.png'),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 125.0,
                        child: PaintThicknessInputField(
                          initialValue: formData.catBelakangBumper,
                          onChanged: (value) {
                            formNotifier.updateCatBelakangBumper(value);
                          },
                        ),
                      ),
                      Positioned(
                        top: 22.0,
                        left: 226.0,
                        child: PaintThicknessInputField(
                          initialValue: formData.catBelakangTrunk,
                          onChanged: (value) {
                            formNotifier.updateCatBelakangTrunk(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 46.0),

              // Section 3: Samping Kanan
              const HeadingOne(text: 'Samping Kanan'),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PaintThicknessInputField(
                          initialValue: formData.catKananFenderBelakang,
                          onChanged: (value) {
                            formNotifier.updateCatKananFenderBelakang(value);
                          },
                        ),
                        PaintThicknessInputField(
                          initialValue: formData.catKananPintuBelakang,
                          onChanged: (value) {
                            formNotifier.updateCatKananPintuBelakang(value);
                          },
                        ),
                        PaintThicknessInputField(
                          initialValue: formData.catKananPintuDepan,
                          onChanged: (value) {
                            formNotifier.updateCatKananPintuDepan(value);
                          },
                        ),
                        PaintThicknessInputField(
                          initialValue: formData.catKananFenderDepan,
                          onChanged: (value) {
                            formNotifier.updateCatKananFenderDepan(value);
                          },
                        ),
                      ],
                    ),
                    Image.asset('assets/images/kanan_baru.png'),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: PaintThicknessInputField(
                        initialValue: formData.catKananSideSkirt,
                        onChanged: (value) {
                          formNotifier.updateCatKananSideSkirt(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),

              // Section 4: Samping Kiri
              const HeadingOne(text: 'Samping Kiri'),
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
                    Image.asset('assets/images/kiri_baru.png'),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: PaintThicknessInputField(
                        initialValue: formData.catKiriSideSkirt,
                        onChanged: (value) {
                          formNotifier.updateCatKiriSideSkirt(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              const SizedBox(
                height: 24.0,
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
