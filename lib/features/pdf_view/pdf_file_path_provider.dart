import 'package:flutter_riverpod/flutter_riverpod.dart';

// تعريف الـ Provider يدوياً
// نستخدم NotifierProvider لربط الكلاس بالحالة
final pdfFilePathProvider = NotifierProvider<PdfPathNotifier, String?>(() {
  return PdfPathNotifier();
});

// الكلاس المسؤول عن إدارة الحالة
// في Riverpod 3.x، نرث من Notifier
class PdfPathNotifier extends Notifier<String?> {
  // دالة بناء الحالة الابتدائية (بديلة عن super في النسخ القديمة)
  @override
  String? build() {
    return null; // القيمة الابتدائية للمسار
  }

  // دالة لتحديث الحالة
  void setFilePath(String path) {
    state = path;
  }
}
