import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_manager_3/features/permissions/persmission_provider.dart';

class PermissionRequestScreen extends ConsumerWidget {
  const PermissionRequestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.storage, size: 100, color: Colors.blueGrey),
            const SizedBox(height: 20),
            const Text("يحتاج التطبيق لصلاحية الوصول للملفات لعرض الـ PDF"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () =>
                  ref.read(permissionProvider.notifier).requestPermission(),
              child: const Text("منح الصلاحية"),
            ),
          ],
        ),
      ),
    );
  }
}
