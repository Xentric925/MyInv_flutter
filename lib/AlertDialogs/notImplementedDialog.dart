import 'package:flutter/material.dart';

class NotImplementedDialog extends StatelessWidget {
  NotImplementedDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(icon: Icon(Icons.info),
      title: Text("Sorry"),
      content: Text("Not Implemented yet!"),
      alignment: Alignment.center,
      iconColor: Colors.blueAccent,
      shape:BeveledRectangleBorder(side: BorderSide(color:Colors.white54,strokeAlign: BorderSide.strokeAlignCenter),borderRadius: BorderRadius.all(Radius.circular(10)),/*eccentricity: 1.0*/),
      actions: [
        TextButton(onPressed: () {
          Navigator.of(context).pop();
        }, child: Text("OK"))
      ],
    );
  }
}
