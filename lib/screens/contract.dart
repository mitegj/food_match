import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:morning_brief/screens/allergies.dart';

class ContractScreen extends StatelessWidget {
  const ContractScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("contratto"),
          TextButton(
              onPressed: () {
                Get.offAll(AllergiesScreen());
              },
              child: Text("Accetto i termini e le condizioni"))
        ],
      ),
    );
  }
}
