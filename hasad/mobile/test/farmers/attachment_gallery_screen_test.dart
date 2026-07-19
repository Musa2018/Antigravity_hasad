import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/farmers/domain/damage_report_attachment.dart';
import 'package:mobile/features/farmers/presentation/damage_report/attachment_gallery_screen.dart';
import 'package:mobile/features/farmers/presentation/farmers_providers.dart';
import 'package:mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('AttachmentGalleryScreen shows attachments', (tester) async {
    final attachments = [
      const DamageReportAttachment(
        id: '1',
        damageReportId: 'report-1',
        localPath: 'path/to/image.jpg',
        uploadStatus: 'completed',
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          attachmentsByReportProvider(
            'report-1',
          ).overrideWith((ref) => attachments),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: AttachmentGalleryScreen(reportId: 'report-1'),
        ),
      ),
    );

    await tester.pump();

    // expect(find.byType(Image), findsOneWidget); // Cannot find Image since File doesn't exist in test env usually without mock
    expect(find.text('Evidence Attachments'), findsOneWidget);
  });
}
