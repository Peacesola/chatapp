import 'package:chat_app/reusable_widgets/small_text.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatefulWidget {
  final String text;
   const CustomDialog({super.key,required this.text});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: SmallText(text: 'An error ocured', color: Colors.white),
      content: Text(widget.text),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: SmallText(text: 'Ok', color: Colors.white))
      ],
    );
  }
}
Future<void> showErrorDialog(BuildContext context, String text) {
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: const Text('An error occured'),
      content: Text(text),
      actions: [
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('OK'))
      ],
    );
  });
}

Future<void> showLogout(BuildContext context,VoidCallback onTap) {
  return showDialog(context: context, builder: (context){
    return AlertDialog(
      title: const Text('Are you sure you want to log out, my nigga?'),
      actions: [
        TextButton(onPressed: (){
          onTap;
        }, child: Text('Hell yea..')),
        TextButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text('Nuh uh'))
      ],
    );
  });
}

Future<void> showImageDialog(BuildContext context,String imageUrl){
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog.fullscreen(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: InteractiveViewer(
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ),
      );
    }
  );
}

