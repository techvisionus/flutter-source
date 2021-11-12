import 'package:flutter/material.dart';
import 'package:flutter_my_page/app/resource/dimens.dart';
import 'package:marquee/marquee.dart';

class RunningTextWidget extends StatelessWidget {
  final String text;

  const RunningTextWidget({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Marquee(
      text: text,
      style: TextStyle(
        fontSize: DimenFont.sp12,
        fontFamily: "NotoSansJPRegular",
      ),
      blankSpace: 30.0,
      velocity: 15.0,
      pauseAfterRound: Duration(milliseconds: 500),
      numberOfRounds: 1,
    );
  }
}
