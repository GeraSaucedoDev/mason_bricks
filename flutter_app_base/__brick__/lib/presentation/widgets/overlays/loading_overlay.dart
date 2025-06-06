import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/theme/extensions/opacity_extension.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;
  static bool _isShowing = false;

  static void show(BuildContext context) {
    if (_isShowing) return;

    _isShowing = true;

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Stack(
        children: [
          ModalBarrier(
            dismissible: false,
            color: Colors.black.withOpacitye(0.75),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(25.sp),
              child: const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );

    if (_overlayEntry != null) {
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  static void remove() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isShowing = false;
  }

  static bool get isShowing => _isShowing;
}
