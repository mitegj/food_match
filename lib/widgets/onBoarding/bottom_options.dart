import 'package:flutter/material.dart';
import 'package:morning_brief/utils/UIColors.dart';


class BottomOptions extends StatelessWidget {
  BottomOptions({required this.activePage, required this.totalPages});
  final int totalPages;
  final int activePage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(100),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalPages, (index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 800),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: activePage == index ? 25 : 5,
                  height: 6,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color:
                        activePage == index ? UIColors.white : UIColors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
