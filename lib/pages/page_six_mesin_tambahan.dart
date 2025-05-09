import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/image_input_widget.dart'; // Keep import in case needed later
import 'dart:io'; // Keep import in case needed later
import 'package:form_app/models/image_data.dart'; // Keep import in case needed later
import 'package:form_app/providers/image_data_provider.dart'; // Keep import in case needed later
import 'package:form_app/pages/page_six_kaki_kaki_wajib.dart'; // Import the next page

class PageSixMesinTambahan extends ConsumerWidget {
  const PageSixMesinTambahan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonLayout(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageNumber(data: '6.8/x'), // Placeholder page number
                  const SizedBox(height: 8.0),
                  PageTitle(data: 'Foto Mesin'),
                  const SizedBox(height: 24.0),
                  HeadingOne(text: 'Tambahan'),
                  const SizedBox(height: 16.0),

                  // Tambahan image inputs will go here later

                  const SizedBox(height: 32.0),
                  NavigationButtonRow(
                    onBackPressed: () => Navigator.pop(context),
                    onNextPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PageSixKakiKakiWajib()),
                      );
                    },
                  ),
                  const SizedBox(height: 32.0),
                  Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
