import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:morning_brief/utils/UIColors.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitSquareCircle(
      color: UIColors.violet,
    );
  }
}

class LoadingWidgetSquareCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      color: UIColors.violet,
    );
  }
}
