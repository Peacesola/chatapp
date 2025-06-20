import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final String? hintText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final Color? fillColor;
  final bool? filled;
  final int? maxLines;
  final int? minLines;
  const CustomTextField({super.key, required this.controller,  this.label, this.hintText,  this.obscureText=false,  this.keyboardType, this.prefixIcon, this.suffixIcon, this.validator, this.textInputAction, this.onChanged, this.focusNode, this.fillColor, this.filled, this.maxLines, this.minLines});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return TextField(
      controller: widget.controller,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        filled: true,
        fillColor: widget.fillColor,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(height*0.01),borderSide: BorderSide.none
        )
      ),
    );
  }
}
