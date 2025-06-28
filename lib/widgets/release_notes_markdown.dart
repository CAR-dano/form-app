import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:form_app/statics/app_styles.dart';

class ReleaseNotesMarkdown extends StatelessWidget {
  final String releaseNotes;

  const ReleaseNotesMarkdown({super.key, required this.releaseNotes});

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: releaseNotes.isNotEmpty
          ? releaseNotes.split('\n\n---\n\n')[0] // Extract only the PR description
          : 'Catatan rilis tidak tersedia.',
      styleSheet: MarkdownStyleSheet(
        p: labelStyle.copyWith(fontSize: 14, color: darkTextColor),
        listBullet: labelStyle.copyWith(fontSize: 14, color: darkTextColor),
      ),
    );
  }
}
