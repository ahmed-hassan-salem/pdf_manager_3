import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_manager_3/features/pdf_view/pdf_file_view.dart';
import 'package:pdf_manager_3/features/permissions/persmission_provider.dart';
import 'package:pdfrx/pdfrx.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await pdfrxFlutterInitialize(dismissPdfiumWasmWarnings: true);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // مراقبة حالة الصلاحية
    final bool isGranted = ref.watch(permissionProvider);

    return MaterialApp(
      home: isGranted
          ? const PdfFileView()
          : _PermissionGateScreen(), // شاشة وسيطة تفتح الإعدادات
    );
  }
}

// شاشة وسيطة بسيطة تظهر قبل الدخول للتطبيق
class _PermissionGateScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () =>
              ref.read(permissionProvider.notifier).requestPermission(),
          child: const Text("منح صلاحية الوصول للملفات من الإعدادات"),
        ),
      ),
    );
  }
}
