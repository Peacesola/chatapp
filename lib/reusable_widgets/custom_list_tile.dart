import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  final Widget widget1;
  final Widget widget2;
  final Widget widget3;
  final void Function() onTap;
  const CustomListTile({super.key, required this.onTap, required this.widget1, required this.widget2, required this.widget3});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: widget.onTap,
      child: ListTile(
        leading: SizedBox(
            height: height*0.06,
            child: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: widget.widget1,
            )),
        title: widget.widget2,
        trailing: widget.widget3,
      ),
    );
  }
}
