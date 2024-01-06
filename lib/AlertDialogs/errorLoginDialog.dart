import 'package:flutter/material.dart';

class ErrorLoginDialog extends StatelessWidget {
  ErrorLoginDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(icon: Icon(Icons.error),
      title: Text("Couldn't Login"),
      content: Text("Wrong email or password!"),
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
