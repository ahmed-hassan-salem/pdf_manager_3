import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfrx/pdfrx.dart';
import 'pdf_controller_provider.dart';

final pdfSearchProvider = NotifierProvider<PdfSearchNotifier, PdfTextSearcher?>(
  () {
    return PdfSearchNotifier();
  },
);

class PdfSearchNotifier extends Notifier<PdfTextSearcher?> {
  @override
  PdfTextSearcher? build() {
    // نربط البحث بالـ controller الحالي
    final controller = ref.read(pdfControllerProvider).controller;
    return PdfTextSearcher(controller);
  }

  /// الميثود الصحيحة لبدء البحث في 2.2.24
  void search(String text) {
    if (state == null) return;
    state!.startTextSearch(text, caseInsensitive: true);
  }

  /// التنقل بين النتائج (تأكد من كتابتها هكذا)
  void next() => state?.goToNextMatch();
  void previous() => state?.goToPrevMatch();

  void clear() => state?.startTextSearch('');
}
