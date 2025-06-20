import 'package:chat_app/reusable_widgets/small_text.dart';
import 'package:flutter/material.dart';

class CustomChatBubble2 extends StatefulWidget {
  final String text;
  const CustomChatBubble2({super.key, required this.text});

  @override
  State<CustomChatBubble2> createState() => _CustomChatBubble2State();
}

class _CustomChatBubble2State extends State<CustomChatBubble2> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.004,top: height * 0.004,left: width*0.02,right: width*0.02),
      child: Container(
        padding: EdgeInsets.only(bottom: height * 0.025,top: height * 0.025,left: width*0.02,right: width*0.02),
        //height: height*0.05,
        //width: width*0.07,
        child: Center(child: SmallText(text: widget.text, color: Colors.black)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(height*0.02),topLeft:Radius.circular(height*0.02) ,bottomRight:Radius.circular(height*0.02)),
            color: Colors.grey
        ),
        constraints: BoxConstraints(maxWidth: width*0.7),
      ),
    );
  }
}
