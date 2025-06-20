import 'package:flutter/material.dart';

class CustomElevatedButton extends StatefulWidget {
  final void Function() onPressed;
  final String text;
  final Color? color;
  final double height;
  final double width;
  const CustomElevatedButton({super.key, required this.onPressed, required this.text, this.color, required this.height, required this.width});

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(onPressed: widget.onPressed, child: Center(child: Text(widget.text)),
      style: ElevatedButton.styleFrom(backgroundColor: widget.color),),
    );
  }
}
