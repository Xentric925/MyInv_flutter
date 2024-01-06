import 'package:flutter/material.dart';

class ErrorConfirmPassDialog extends StatelessWidget {
  ErrorConfirmPassDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(icon: Icon(Icons.error),
      title: Text("Password Mismatch"),
      content: Text("Passwords don't match!"),
      alignment: Alignment.center,
      iconColor: Colors.redAccent,
      shape:BeveledRectangleBorder(side: BorderSide(color:Colors.white54,strokeAlign: BorderSide.strokeAlignCenter),borderRadius: BorderRadius.all(Radius.circular(10)),/*eccentricity: 1.0*/),
      actions: [
        TextButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: Text("OK"))
      ],
    );
  }
}
