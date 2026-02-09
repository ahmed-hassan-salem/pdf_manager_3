import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfrx/pdfrx.dart';

class PdfDocumentState {
  final PdfDocumentRef? docRef;
  final List<PdfOutlineNode>? outline; // add outline
  final bool isLoading;

  PdfDocumentState({this.docRef, this.outline, this.isLoading = false});
}

class PdfDocumentNotifier extends Notifier<PdfDocumentState> {
  @override
  PdfDocumentState build() {
    // التعديل هنا: نضع المسار الذي تريده كقيمة ابتدائية
    final initialFile = PdfDocumentRefFile(
      '/storage/emulated/0/Download/test1.pdf',
    );

    // استخدام الرابط المباشر للكتاب للاختبار
    /*final testUrlRef = PdfDocumentRefUri(
      Uri.parse('https://dart.dev/guides/language/spec/dartLangSpec.pdf'),
    );*/

    // نرجع الحالة وهي تحتوي على الملف بدلاً من null
    return PdfDocumentState(docRef: initialFile, isLoading: false);
  }

  //the outline method
  void setOutline(List<PdfOutlineNode> outline) {
    state = PdfDocumentState(
      docRef: state.docRef,
      outline: outline,
      isLoading: false,
    );
  }

  // هذه الدالة سنستخدمها لاحقاً لتغيير الملف من الـ List
  void loadFile(String path) {
    state = PdfDocumentState(
      docRef: PdfDocumentRefFile(path),
      isLoading: false,
    );
  }
}

final pdfDocumentProvider =
    NotifierProvider<PdfDocumentNotifier, PdfDocumentState>(() {
      return PdfDocumentNotifier();
    });
