import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_manager_3/features/pdf_view/pdf_controller_provider.dart';
// تأكد من استيراد الـ provider الخاص بك هنا

class PdfBottomToolbar extends ConsumerWidget {
  const PdfBottomToolbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdfState = ref.watch(pdfControllerProvider);

    // إذا لم يتم تحميل صفحات بعد، لا نعرض الشريط
    if (pdfState.totalPages <= 1) return const SizedBox.shrink();

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        // التعديل هنا: استخدام withValues بدلاً من withOpacity
        // القيمة 0.9 في Opacity تعادل 0.9 في alpha
        color: Colors.blueGrey[900]?.withValues(alpha: 0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          const Icon(Icons.description, color: Colors.white70, size: 20),
          Expanded(
            child: Slider(
              value: pdfState.currentPage.toDouble(),
              min: 1,
              max: pdfState.totalPages.toDouble(),
              divisions: pdfState.totalPages > 1 ? pdfState.totalPages - 1 : 1,
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.white24,
              label: pdfState.currentPage.toString(),
              onChanged: (value) {
                // الانتقال اللحظي للصفحة عند تحريك السلايدر
                ref
                    .read(pdfControllerProvider.notifier)
                    .goToPage(value.toInt());
              },
            ),
          ),
          Text(
            '${pdfState.totalPages}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
