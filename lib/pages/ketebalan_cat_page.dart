import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/paint_thickness_input_field.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/utils/no_overscroll_behavior.dart';

class KetebalanCatPage extends ConsumerStatefulWidget {
  const KetebalanCatPage({super.key});

  @override
  ConsumerState<KetebalanCatPage> createState() => _KetebalanCatPage();
}

class _KetebalanCatPage extends ConsumerState<KetebalanCatPage>
    with AutomaticKeepAliveClientMixin {
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _focusNodes = List<FocusNode>.generate(13, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final FocusNode node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _handleFieldSubmitted(int index) {
    final bool isLastField = index == _focusNodes.length - 1;
    if (isLastField) {
      _focusNodes[index].unfocus();
      return;
    }

    _focusNodes[index + 1].requestFocus();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final formData = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);

    return ScrollConfiguration(
      behavior: NoOverscrollBehavior(),
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        key: const PageStorageKey<String>('pageEightScrollKey'),
        slivers: [
          const SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageTitle(data: 'Ketebalan Cat'),
                SizedBox(height: 6.0),
              ],
            ),
          ),
          // Section 1: Depan
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeadingOne(text: 'Depan'),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.08,
                          ),
                          PaintThicknessInputField(
                            initialValue: formData.catDepanKap,
                            focusNode: _focusNodes[0],
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => _handleFieldSubmitted(0),
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
              ],
            ),
          ),

          // Section 2: Belakang
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            focusNode: _focusNodes[1],
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => _handleFieldSubmitted(1),
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
                            focusNode: _focusNodes[2],
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => _handleFieldSubmitted(2),
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
              ],
            ),
          ),

          // Section 3: Samping Kanan
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            focusNode: _focusNodes[3],
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => _handleFieldSubmitted(3),
                            onChanged: (value) {
                              formNotifier.updateCatKananFenderBelakang(value);
                            },
                          ),
                          PaintThicknessInputField(
                            initialValue: formData.catKananPintuBelakang,
                            focusNode: _focusNodes[4],
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => _handleFieldSubmitted(4),
                            onChanged: (value) {
                              formNotifier.updateCatKananPintuBelakang(value);
                            },
                          ),
                          PaintThicknessInputField(
                            initialValue: formData.catKananPintuDepan,
                            focusNode: _focusNodes[5],
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => _handleFieldSubmitted(5),
                            onChanged: (value) {
                              formNotifier.updateCatKananPintuDepan(value);
                            },
                          ),
                          PaintThicknessInputField(
                            initialValue: formData.catKananFenderDepan,
                            focusNode: _focusNodes[6],
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => _handleFieldSubmitted(6),
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
                          focusNode: _focusNodes[7],
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => _handleFieldSubmitted(7),
                          onChanged: (value) {
                            formNotifier.updateCatKananSideSkirt(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),

          // Section 4: Samping Kiri
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                            focusNode: _focusNodes[8],
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => _handleFieldSubmitted(8),
                            onChanged: (value) {
                              formNotifier.updateCatKiriFenderDepan(value);
                            },
                          ),
                          PaintThicknessInputField(
                            initialValue: formData.catKiriPintuDepan,
                            focusNode: _focusNodes[9],
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => _handleFieldSubmitted(9),
                            onChanged: (value) {
                              formNotifier.updateCatKiriPintuDepan(value);
                            },
                          ),
                          PaintThicknessInputField(
                            initialValue: formData.catKiriPintuBelakang,
                            focusNode: _focusNodes[10],
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => _handleFieldSubmitted(10),
                            onChanged: (value) {
                              formNotifier.updateCatKiriPintuBelakang(value);
                            },
                          ),
                          PaintThicknessInputField(
                            initialValue: formData.catKiriFenderBelakang,
                            focusNode: _focusNodes[11],
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => _handleFieldSubmitted(11),
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
                          focusNode: _focusNodes[12],
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _handleFieldSubmitted(12),
                          onChanged: (value) {
                            formNotifier.updateCatKiriSideSkirt(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32.0),
                const SizedBox(height: 24.0),
                const Footer(),
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom + 90,
            ),
          ),
        ],
      ),
    );
  }
}
