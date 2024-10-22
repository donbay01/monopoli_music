import 'package:flutter/material.dart';
import '../../theme/colors.dart';


class CustomButton extends StatelessWidget {
  final Function? function;
  final Color color;
  final Widget child;

  const CustomButton({
    super.key,
    required this.child,
    this.function,
    this.color = primaryWhite,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.055,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          function!();
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: color,
        ),
        child: child,
      ),
    );
  }
}
