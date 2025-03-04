import 'package:flutter/material.dart';

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
  final String? validator;
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
  final double searchIconSize;
  final Color searchIconColor;
  final EdgeInsetsGeometry passwordIconPadding;
  final double passwordIconSize;

  const GogoTextField({
    super.key,
    required this.textFieldState,
    required this.controller,
    required this.hintText,
    this.validator,
    this.onEditingComplete,
    this.textColor = GogoColors.white,
    this.backgroundColor = GogoColors.black,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.textStyle = GogoTypography.body3Medium,
    this.cursorColor = GogoColors.main600,
    this.cursorErrorColor = GogoColors.error,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 16,
    ),
    this.hintStyle = GogoTypography.body3Medium,
    this.hintColor = GogoColors.gray500,
    this.errorStyle = GogoTypography.caption2Medium,
    this.errorColor = GogoColors.error,
    this.errorBorderSide = const BorderSide(color: GogoColors.error, width: 1),
    this.searchIconSize = 24,
    this.searchIconColor = GogoColors.white,
    this.passwordIconPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
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
          return widget.validator;
        } else {
          return null;
        }
      },
      style: widget.textStyle.copyWith(color: widget.textColor),
      cursorColor: widget.cursorColor,
      cursorErrorColor: widget.cursorErrorColor,
      onEditingComplete: widget.onEditingComplete,
      decoration: InputDecoration(
        suffixIcon: widget.textFieldState == GogoTextFieldState.search
            ? GestureDetector(
                onTap: widget.onEditingComplete,
                child: GogoIcons.search(
                  color: widget.searchIconColor,
                  height: widget.searchIconSize,
                  width: widget.searchIconSize,
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
