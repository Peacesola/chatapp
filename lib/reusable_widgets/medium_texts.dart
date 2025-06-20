import 'package:flutter/cupertino.dart';

class MediumText extends StatefulWidget {
  final String text;
  final double? fontSize;
  final Color color;
  final FontWeight? fontWeight;
  const MediumText({super.key, required this.text, this.fontSize, required this.color, this.fontWeight});

  @override
  State<MediumText> createState() => _MediumTextState();
}

class _MediumTextState extends State<MediumText> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Text(widget.text,
        style: TextStyle(fontSize: height*0.025,color: widget.color ,fontWeight: widget.fontWeight));
  }
}
