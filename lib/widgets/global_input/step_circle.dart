import 'package:flutter/material.dart';
import 'package:morning_brief/utils/UIColors.dart';

class StepCircle extends StatelessWidget {
  StepCircle({Key? key, required this.indice}) : super(key: key);
  final int indice;

  @override
  Widget build(BuildContext context) {
    /*return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
          height: 25,
          width: 25,
          color: UIColors.black,
          child: Text(
            indice.toString(),
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )),
    );*/

    return Container(
        height: 30,
        width: 30,
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: UIColors.black, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              indice.toString(),
              style: TextStyle(color: Colors.white),
            ),
          ],
        ));
  }
}
