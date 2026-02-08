import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

// تعريف الـ Provider يدوياً
final permissionProvider = NotifierProvider<PermissionNotifier, bool>(() {
  return PermissionNotifier();
});

class PermissionNotifier extends Notifier<bool> {
  @override
  bool build() {
    // التحقق عند تشغيل التطبيق أول مرة
    checkPermission();
    return false; // القيمة الابتدائية
  }

  Future<void> checkPermission() async {
    // صلاحية ManageExternalStorage تغطي كل شيء في أندرويد 11 فما فوق
    bool status = await Permission.manageExternalStorage.isGranted;

    // إذا كان الإصدار قديماً جداً نستخدم الصلاحية العادية كبديل
    if (!status) {
      status = await Permission.storage.isGranted;
    }

    state = status;
  }

  Future<void> requestPermission() async {
    // فتح شاشة إعدادات النظام مباشرة لمنح الصلاحية الشاملة
    if (await Permission.manageExternalStorage.request().isGranted) {
      state = true;
    } else {
      // في حال رفض المستخدم من النافذة المنبثقة، نوجهه لفتح الإعدادات يدوياً
      await openAppSettings();
      // بعد العودة من الإعدادات، نقوم بالفحص مرة أخرى
      checkPermission();
    }
  }
}
