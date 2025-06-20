

import 'package:flutter/cupertino.dart';

class SmallText extends StatefulWidget {
  final String text;
  final double? fontSize;
  final Color color;
  final FontWeight? fontWeight;
  const SmallText({super.key, required this.text, this.fontSize, required this.color, this.fontWeight});

  @override
  State<SmallText> createState() => _SmallTextState();
}

class _SmallTextState extends State<SmallText> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Text(widget.text,
        style: TextStyle(fontSize: height*0.02,color: widget.color ,fontWeight: widget.fontWeight));
  }
}
