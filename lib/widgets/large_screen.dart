import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/local_navigator.dart';
import 'package:comp1640_web/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: SideMenu()),
        Expanded(
            flex: 5,
            child: Column(
              children: [
                Container(
                  height: 65,
                  decoration: BoxDecoration(
                      color: lightColor,
                      border: Border(bottom: BorderSide(color: greyColor.withOpacity(0.1)))),
                ),
                Expanded(child: localNavigator()),
              ],
            ))
      ],
    );
  }
}
