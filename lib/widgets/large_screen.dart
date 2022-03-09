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
            child: Container(
                padding: const EdgeInsets.only(left: 35, right: 35.0),
                child: localNavigator()))
      ],
    );
  }
}
