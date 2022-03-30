import 'package:comp1640_web/constant/style.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final Color topColor;
  final bool isActive;

  const InfoCard({Key key,@required this.title,@required this.value, this.isActive = false, this.topColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 136,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 6),
              color: greyColor.withOpacity(.1),
              blurRadius: 12
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Container(
                  color: topColor ?? primaryColor2,
                  height: 5,
                ))
              ],
            ),
            Expanded(child: Container()),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: "$title\n",
                      style: TextStyle(
                          fontSize: 16, color: isActive ? primaryColor2 : greyColor)),
                  TextSpan(
                      text: "$value",
                      style:
                          TextStyle(fontSize: 40, color: isActive ? primaryColor2 : textColor)),
                ])),
            Expanded(child: Container()),

          ],
        ),
      ),
    );
  }
}
