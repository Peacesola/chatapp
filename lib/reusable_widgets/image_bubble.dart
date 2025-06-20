import 'package:flutter/cupertino.dart';

class CustomImageBubble extends StatefulWidget {
 final String src;
  const CustomImageBubble({super.key, required this.src});

  @override
  State<CustomImageBubble> createState() => _CustomImageBubbleState();
}

class _CustomImageBubbleState extends State<CustomImageBubble> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Image.network(widget.src,fit: BoxFit.cover,);
  }
}
