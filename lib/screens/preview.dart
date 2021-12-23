import 'package:flutter/material.dart';
import 'package:morning_brief/widgets/onBoarding/bottom_options.dart';
import 'package:morning_brief/widgets/onBoarding/preview/previewPageA.dart';
import 'package:morning_brief/widgets/onBoarding/preview/previewPageB.dart';
import 'package:morning_brief/widgets/onBoarding/preview/previewPageC.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key}) : super(key: key);

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  late List<Widget> _pages;
  int _activepage = 0;
  @override
  Widget build(BuildContext context) {
    _pages = [PreviewPageA(), PreviewPageB(), PreviewPageC()];
    var theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                top: 0,
                left: 0,
                right: 0,
                child: PageView(
                    onPageChanged: (value) {
                      setState(() {
                        _activepage = value;
                        // print('Active Page: ' + _activepage.toString());
                      });
                    },
                    children: _pages),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BottomOptions(
                  totalPages: _pages.length,
                  activePage: _activepage,
                ),
              )
            ],
          ),
        ));
  }
}
