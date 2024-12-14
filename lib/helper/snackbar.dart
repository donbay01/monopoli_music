import 'package:flutter/material.dart';
import 'package:monopoli/theme/text_style.dart';

import '../theme/colors.dart';

class SnackbarHelper {
  static displayToastMessage({
    required BuildContext context,
    required String message,
    Color? color,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: mediumBold(primaryBlack),
        ),
        backgroundColor: color ?? purple,
      ),
    );
  }
}
