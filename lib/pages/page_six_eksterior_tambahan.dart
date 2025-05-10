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
// import 'package:form_app/pages/page_six_interior_wajib.dart'; // No longer directly navigating
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider

class PageSixEksteriorTambahan extends ConsumerWidget {
  const PageSixEksteriorTambahan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageNumber(data: '6/9'),
          const SizedBox(height: 4),
          PageTitle(data: 'Foto Eksterior'),
          const SizedBox(height: 6.0),
          HeadingOne(text: 'Tambahan'),
          const SizedBox(height: 16.0),
      
          // Tambahan image inputs will go here later
      
          const SizedBox(height: 32.0),
          NavigationButtonRow(
            onBackPressed: () => ref.read(formStepProvider.notifier).state--,
            onNextPressed: () => ref.read(formStepProvider.notifier).state++,
          ),
          const SizedBox(height: 32.0),
          Footer(),
        ],
      ),
    );
  }
}
