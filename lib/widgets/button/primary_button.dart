import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import '../../theme/colors.dart';
import '../../theme/text_style.dart';

class PrimaryButton extends StatelessWidget {
  final Function()? function;
  final Widget icon;
  final String text;

  const PrimaryButton({
    super.key,
    this.function,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: const GradientBoxBorder(
            gradient: LinearGradient(colors: [purple, primaryWhite]),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: mediumText(primaryWhite),
            )
          ],
        ),
      ),
    );
  }
}
