import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSingleTextFieldInputDialog({
  required BuildContext context,
  required String title,
  String positiveButton="Ok",
  String negativeButton="Close",
  required Function (String) onSubmit,
}){
  final txtController=TextEditingController();
  showDialog(context: context, builder: (context)=>AlertDialog(
    title: Text(title),
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: txtController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: "Enter $title"
        ),
      ),
    ),
    actions: [
      TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text(negativeButton)
      ),
      TextButton(
          onPressed: (){
            if(txtController.text.isEmpty){
              return ;
            }

            onSubmit(txtController.text);
            Navigator.pop(context);
          },
          child: Text(positiveButton)
      ),
    ],
  ));
}