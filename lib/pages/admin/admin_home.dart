import 'package:comp1640_web/helpers/menu_controller.dart';
import 'package:comp1640_web/helpers/reponsive_pages.dart';
import 'package:comp1640_web/modules/posts/controlls/post_controller.dart';
import 'package:comp1640_web/modules/threads/DA/thread_data.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/pages/admin/widgets/chart2_section_large.dart';
import 'package:comp1640_web/pages/admin/widgets/chart2_section_small.dart';
import 'package:comp1640_web/pages/admin/widgets/overview_cards_large.dart';
import 'package:comp1640_web/pages/admin/widgets/overview_cards_small.dart';
import 'package:comp1640_web/pages/admin/widgets/chart1_section_large.dart';
import 'package:comp1640_web/pages/admin/widgets/chart1_section_small.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome>
    with AutomaticKeepAliveClientMixin {
  PostController postController = Get.find();

  @override
  void initState() {
    postController.callListForChart();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 15),
                  child: CustomText(
                    text: menuController.activeItem.value == 'Log Out'
                        ? ''
                        : menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  )),
            ],
          ),
        ),
        Expanded(
            child: ListView(
          children: [
            if (ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.isMediumScreen(context))
              OverviewCardsLargeScreen()
            else
              OverviewCardsSmallScreen(),
            if (!ResponsiveWidget.isSmallScreen(context))
              Chart1SectionLarge()
            else
              Chart1SectionSmall(),
            if (!ResponsiveWidget.isSmallScreen(context))
              Chart2SectionLarger()
            else
              Chart2SectionSmall(),
          ],
        ))
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
