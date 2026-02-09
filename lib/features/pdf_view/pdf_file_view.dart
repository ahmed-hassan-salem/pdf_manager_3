import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf_manager_3/features/document/pdf_document_provider.dart';
import 'package:pdf_manager_3/features/pdf_view/pdf_controller_provider.dart';
import 'package:pdfrx/pdfrx.dart';

class PdfFileView extends ConsumerWidget {
  const PdfFileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. مراقبة حالة المستند من الـ Provider
    final docState = ref.watch(pdfDocumentProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        foregroundColor: Colors.white,
        title: const Text("PDF Manager Pro"),
      ),

      // داخل Scaffold في PdfFileView
      drawer: Drawer(
        child: Column(
          children: [
            const DrawerHeader(child: Center(child: Text("فهرس الكتاب"))),
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final outline = ref.watch(pdfDocumentProvider).outline;

                  if (outline == null) {
                    return const Center(child: Text("لا يوجد فهرس"));
                  }

                  return ListView.builder(
                    itemCount: outline.length,
                    itemBuilder: (context, index) {
                      final node = outline[index];
                      return ListTile(
                        title: Text(node.title),
                        onTap: () {
                          // الانتقال للصفحة عند الضغط (زي المثال)
                          if (node.dest != null) {
                            ref
                                .read(pdfControllerProvider)
                                .controller
                                .goToDest(node.dest);
                            Navigator.pop(context); // قفل الدرج بعد الاختيار
                          }
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // 2. التحقق من الحالة: هل الملف جاهز؟
      body: docState.docRef == null
          ? const Center(child: Text("جاري تحميل الملف أو لم يتم الاختيار..."))
          : PdfViewer(
              // 3. نستخدم الـ Ref اللي جاي من الـ Provider (اللي إحنا ثبتناه جواه)
              docState.docRef!,
              controller: ref.watch(pdfControllerProvider).controller,
              params: PdfViewerParams(
                margin: 12,
                onViewerReady: (document, controller) async {
                  // تحديث عدد الصفحات في الـ Controller الخاص بك
                  ref
                      .read(pdfControllerProvider.notifier)
                      .setDocumentReady(document.pages.length);

                  final outline = await document.loadOutline();


                  if (outline != null && outline.isNotEmpty) {
                    ref.read(pdfDocumentProvider.notifier).setOutline(outline);
                  }
                },
              ),
            ),
    );
  }
}
