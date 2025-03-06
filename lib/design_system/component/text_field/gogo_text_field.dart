import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/color.dart';
import '../../theme/icon.dart';
import '../../theme/typography.dart';

enum GogoTextFieldState {
  basic,
  search,
}

class GogoTextField extends StatefulWidget {
  final GogoTextFieldState textFieldState;
  final TextEditingController controller;
  final Function(String?)? validator;
  final Color backgroundColor;
  final Color textColor;
  final BorderRadius borderRadius;
  final TextStyle textStyle;
  final Color cursorColor;
  final Color cursorErrorColor;
  final EdgeInsetsGeometry contentPadding;
  final String hintText;
  final TextStyle hintStyle;
  final Color hintColor;
  final TextStyle errorStyle;
  final Color errorColor;
  final BorderSide errorBorderSide;
  final VoidCallback? onEditingComplete;
  final EdgeInsetsGeometry searchIconPadding;
  final Color searchIconColor;
  final EdgeInsetsGeometry passwordIconPadding;
  final double passwordIconSize;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatter;

  const GogoTextField({
    super.key,
    required this.textFieldState,
    required this.controller,
    required this.hintText,
    this.validator,
    this.onEditingComplete,
    this.keyboardType,
    this.inputFormatter,
    this.textColor = GogoColors.white,
    this.backgroundColor = GogoColors.gray700,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.textStyle = GogoTypography.body3Semibold,
    this.cursorColor = GogoColors.main600,
    this.cursorErrorColor = GogoColors.error,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 16,
    ),
    this.hintStyle = GogoTypography.body3Semibold,
    this.hintColor = GogoColors.gray500,
    this.errorStyle = GogoTypography.caption2Semibold,
    this.errorColor = GogoColors.error,
    this.errorBorderSide = const BorderSide(color: GogoColors.error, width: 1),
    this.searchIconPadding = const EdgeInsets.all(16),
    this.searchIconColor = GogoColors.gray400,
    this.passwordIconPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.passwordIconSize = 24,
  });

  @override
  State<GogoTextField> createState() => _GogoTextFieldState();
}

class _GogoTextFieldState extends State<GogoTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: (value) {
        if (widget.textFieldState == GogoTextFieldState.basic &&
            widget.validator != null) {
          return widget.validator!(value);  // 이 부분을 수정
        } else {
          return null;
        }
      },
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatter,
      style: widget.textStyle.copyWith(color: widget.textColor),
      cursorColor: widget.cursorColor,
      cursorErrorColor: widget.cursorErrorColor,
      onEditingComplete: widget.onEditingComplete,
      decoration: InputDecoration(
        suffixIcon: widget.textFieldState == GogoTextFieldState.search
            ? GestureDetector(
                onTap: widget.onEditingComplete,
                child: Padding(
                  padding: widget.searchIconPadding,
                  child: GogoIcons.search(
                    color: widget.searchIconColor,
                  ),
                ),
              )
            : null,
        filled: true,
        fillColor: widget.backgroundColor,
        contentPadding: widget.contentPadding,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle.copyWith(
          color: widget.hintColor,
        ),
        errorStyle: widget.errorStyle.copyWith(
          color: widget.errorColor,
        ),
        border: OutlineInputBorder(
          borderRadius: widget.borderRadius,
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: widget.borderRadius,
          borderSide: widget.errorBorderSide,
        ),
      ),
    );
  }
}

class GradeSuffixInputFormatter extends TextInputFormatter {
  final String suffix = "학년";

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.endsWith(suffix)) {
      return newValue;
    }
    return TextEditingValue(
      text: newValue.text + suffix,
      selection: TextSelection.fromPosition(
        TextPosition(offset: newValue.text.length),
      ),
    );
  }
}

class NumberSuffixInputFormatter extends TextInputFormatter {
  final String suffix = "번";

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.endsWith(suffix)) {
      return newValue;
    }
    return TextEditingValue(
      text: newValue.text + suffix,
      selection: TextSelection.fromPosition(
        TextPosition(offset: newValue.text.length),
      ),
    );
  }
}

class ClassSuffixInputFormatter extends TextInputFormatter {
  final String suffix = "반";

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.endsWith(suffix)) {
      return newValue;
    }
    return TextEditingValue(
      text: newValue.text + suffix,
      selection: TextSelection.fromPosition(
        TextPosition(offset: newValue.text.length),
      ),
    );
  }
}
