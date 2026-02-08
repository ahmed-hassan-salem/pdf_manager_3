import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdfrx/pdfrx.dart';

class PdfState {
  final PdfViewerController controller;
  final int currentPage;
  final int totalPages;

  PdfState({
    required this.controller,
    this.currentPage = 1,
    this.totalPages = 0,
  });

  PdfState copyWith({
    PdfViewerController? controller,
    int? currentPage,
    int? totalPages,
  }) {
    return PdfState(
      controller: controller ?? this.controller,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }
}

final pdfControllerProvider = NotifierProvider<PdfControllerNotifier, PdfState>(
  () {
    return PdfControllerNotifier();
  },
);

class PdfControllerNotifier extends Notifier<PdfState> {
  @override
  PdfState build() {
    return PdfState(controller: PdfViewerController());
  }

  void goToPage(int page) {
    state.controller.goToPage(pageNumber: page);
    updatePage(page);
  }

  void setDocumentReady(int count) {
    state = state.copyWith(totalPages: count);
  }

  void updatePage(int page) {
    if (state.currentPage != page) {
      state = state.copyWith(currentPage: page);
    }
  }

  void zoomIn() => state.controller.zoomUp();
  void zoomOut() => state.controller.zoomDown();
  void resetZoom() => state.controller.setZoom(Offset.zero, 1.0);
}
