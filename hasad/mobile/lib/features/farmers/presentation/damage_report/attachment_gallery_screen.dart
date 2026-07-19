import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/features/farmers/domain/damage_report_attachment.dart';
import 'package:mobile/features/farmers/presentation/farmers_providers.dart';

class AttachmentGalleryScreen extends ConsumerWidget {
  final String reportId;

  const AttachmentGalleryScreen({super.key, required this.reportId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attachmentsAsync = ref.watch(attachmentsByReportProvider(reportId));

    return Scaffold(
      appBar: AppBar(title: const Text('Evidence Attachments')),
      body: attachmentsAsync.when(
        data: (attachments) {
          if (attachments.isEmpty) {
            return const Center(child: Text('No attachments yet.'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: attachments.length,
            itemBuilder: (context, index) {
              final attachment = attachments[index];
              return _AttachmentTile(attachment: attachment);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addAttachment(context, ref),
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  Future<void> _addAttachment(BuildContext context, WidgetRef ref) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );

    if (image != null) {
      final attachment = DamageReportAttachment(
        id: '',
        damageReportId: reportId,
        localPath: image.path,
      );
      await ref.read(attachmentRepositoryProvider).uploadAttachment(attachment);
      ref.invalidate(attachmentsByReportProvider(reportId));
    }
  }
}

class _AttachmentTile extends ConsumerWidget {
  final DamageReportAttachment attachment;

  const _AttachmentTile({required this.attachment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.file(File(attachment.localPath), fit: BoxFit.cover),
        ),
        if (attachment.uploadStatus == 'pending')
          Container(
            color: Colors.black26,
            child: const Center(child: CircularProgressIndicator()),
          ),
        Positioned(
          right: 0,
          top: 0,
          child: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async {
              await ref
                  .read(attachmentRepositoryProvider)
                  .deleteAttachment(attachment.id);
              ref.invalidate(
                attachmentsByReportProvider(attachment.damageReportId),
              );
            },
          ),
        ),
      ],
    );
  }
}
