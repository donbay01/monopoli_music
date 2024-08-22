import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:string_validator/string_validator.dart';
import '../../theme/colors.dart';
import '../../theme/text_style.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType keyboardType;
  final double radius;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? labelStyle;
  final bool isPassword;
  final bool isEmail;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.emailAddress,
    this.radius = 10,
    this.prefixIcon,
    this.suffixIcon,
    this.labelStyle,
    this.isEmail = false,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: const [AutofillHints.email],
      onEditingComplete: () => [
        FocusScope.of(context).unfocus(),
      ],
      style: smallText(primaryWhite),
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required';
        }

        if (widget.isEmail && !isEmail(value)) {
          return 'This is not a valid email';
        }
      },
      obscureText: _obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: widget.labelStyle ?? mediumText(primaryWhite),
        hintText: widget.hint,
        hintStyle: smallText(primaryWhite),
        filled: true,
        fillColor: Colors.transparent,
        suffixIcon: _obscureText
            ? IconButton(
                onPressed: () {
                  _toggle();
                },
                icon: _obscureText
                    ? const Icon(
                        FontAwesomeIcons.eyeSlash,
                        color: Colors.grey,
                        size: 15,
                      )
                    : const Icon(
                        Icons.remove_red_eye,
                        color: purple,
                        size: 20,
                      ),
              )
            : widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: const BorderSide(
            color: purple,
            width: 1.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.radius),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
      ),
      keyboardType: widget.keyboardType,
    );
  }
}
