import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/theme/app_colors.dart';
import 'package:{{app_name}}/core/theme/extensions/opacity_extension.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppSnackbar {
  static void show(
    BuildContext context,
    String message, {
    bool asOverlay = false,
    SnackbarType type = SnackbarType.error,
  }) {
    Color backgroundColor;
    Color textColor;
    //IconData icon;

    final colors = Theme.of(context).colorScheme;

    switch (type) {
      case SnackbarType.success:
        backgroundColor = AppColors.emerald;
        textColor = AppColors.white;
        //icon = Icons.check_circle;
        break;
      case SnackbarType.info:
        backgroundColor = AppColors.slate;
        textColor = AppColors.white;
        //icon = Icons.info;
        break;
      case SnackbarType.error:
        backgroundColor = colors.error;
        textColor = colors.onError;
        //icon = Icons.error;
        break;
    }

    if (asOverlay) {
      final overlay = Overlay.of(context);
      OverlayEntry? entry;

      entry = OverlayEntry(
        builder: (context) => Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom + 2.h,
          left: 16,
          right: 16,
          child: GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dy > 50) {
                entry?.remove();
              }
            },
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacitye(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                        ),
                        //textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      overlay.insert(entry);

      Future.delayed(const Duration(seconds: 5), () {
        try {
          entry?.remove();
        } catch (e) {
          log('Error on remove snackbar overlay');
        }
      });
      return;
    }

    final snackbar = SnackBar(
      content: Row(
        children: [
          //Icon(icon, color: Colors.white),
          //const SizedBox(width: 8),
          Expanded(
              child: Text(
            message,
            style: TextStyle(color: textColor),
          )),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 5),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}

enum SnackbarType { success, info, error }
