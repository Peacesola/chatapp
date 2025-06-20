import 'package:chat_app/reusable_widgets/medium_texts.dart';
import 'package:chat_app/reusable_widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomChatTile extends StatefulWidget {
  final Widget widget1;
  final Widget widget2;
  final Widget widget3;
  final String? url;
  final void Function() onTap;
  const CustomChatTile({super.key, required this.widget1, required this.widget2, required this.widget3, required this.onTap, this.url});

  @override
  State<CustomChatTile> createState() => _CustomChatTileState();
}

class _CustomChatTileState extends State<CustomChatTile> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: width*0.02,right: width*0.02,top: height*0.01),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                      height: height*0.06,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        backgroundImage:  widget.url != null?NetworkImage(widget.url!):null,
                        child: widget.url ==null? widget.widget1:null,
                      )
                  /*Container(
                    height: height*0.06,
                    width: width*0.1,
                    child: widget.widget1,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      //image: DecorationImage(image: NetworkImage(widget.url),fit: BoxFit.cover)
                    ),
                  ),*/
                  ),
                  SizedBox(
                    width: width*0.03,
                  ),
                  widget.widget2
                ],
              ),
              widget.widget3
            ],
          ),
        ),
      ),
    );
  }
}
