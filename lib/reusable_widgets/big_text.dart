import 'package:flutter/material.dart';

class BigText extends StatefulWidget {
  final String text;
  final double? fontSize;
  final Color color;
  final FontWeight? fontWeight;
  const BigText({super.key, required this.text,  this.fontSize, required this.color, this.fontWeight});

  @override
  State<BigText> createState() => _BigTextState();
}

class _BigTextState extends State<BigText> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Text(widget.text,
      style: TextStyle(fontSize: height*0.05,color: widget.color,fontWeight: widget.fontWeight ));
  }
}
