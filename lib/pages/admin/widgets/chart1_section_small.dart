import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/modules/posts/controlls/post_controller.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/pages/admin/widgets/chart1_section_large.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bar_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Chart1SectionSmall extends StatefulWidget {
  @override
  State<Chart1SectionSmall> createState() => _Chart1SectionSmallState();
}

class _Chart1SectionSmallState extends State<Chart1SectionSmall> {
  String selectedValue = '0';
  List<ChartSelectItem> items = [
    ChartSelectItem(id: 0, title: 'Ideas & Likes'),
    ChartSelectItem(id: 1, title: 'Ideas & DisLikes'),
    ChartSelectItem(id: 2, title: 'Threads & Ideas'),
  ];

  List<DropdownMenuItem<String>> _addDividersAfterItems(
      List<ChartSelectItem> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item.id.toString(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomText(
                text: item.title,
                size: 20,
                weight: FontWeight.bold,
                color: greyColor,
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<int> _getDividersIndexes() {
    List<int> _dividersIndexes = [];
    for (var i = 0; i < (items.length * 2) - 1; i++) {
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _dividersIndexes.add(i);
      }
    }
    return _dividersIndexes;
  }

  @override
  Widget build(BuildContext context) {
    ThreadController threadController = Get.find();
    PostController postController = Get.find();

    return Obx(
      () => Container(
        padding: EdgeInsets.all(24),
        margin: EdgeInsets.symmetric(vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 6),
                color: greyColor.withOpacity(.1),
                blurRadius: 12)
          ],
          border: Border.all(color: greyColor, width: .5),
        ),
        child: Column(
          children: [
            Container(
              height: 360,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: 'Change chart: ',
                      ),
                      Container(
                        width: 150,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
                            items: _addDividersAfterItems(items),
                            customItemsIndexes: _getDividersIndexes(),
                            customItemsHeight: 4,
                            value: selectedValue,
                            onChanged: (value) {
                              postController.changeChartData(value);
                              setState(() {
                                selectedValue = value;
                              });
                            },
                            buttonHeight: 40,
                            buttonWidth: 140,
                            itemHeight: 40,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 300,
                    height: 1,
                    color: greyColor,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          color: primaryColor2,
                          borderRadius: BorderRadius.circular(8.0),
                          child: InkWell(
                            onTap: () {
                              threadController.onInit();
                            },
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: const CustomText(
                                text: "Refresh chart",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const CustomText(
                              text: 'High',
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5, right: 10),
                              decoration: BoxDecoration(
                                  color: primaryColor2, shape: BoxShape.circle),
                              width: 10,
                              height: 10,
                            ),
                            const CustomText(
                              text: 'Medium',
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5, right: 10),
                              decoration: BoxDecoration(
                                  color: orangeColor, shape: BoxShape.circle),
                              width: 10,
                              height: 10,
                            ),
                            const CustomText(
                              text: 'Low',
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5, right: 10),
                              decoration: BoxDecoration(
                                  color: redColor, shape: BoxShape.circle),
                              width: 10,
                              height: 10,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: HorizontalBarLabelChart(
                          postController.changeChartData(selectedValue))),
                ],
              ),
            ),

            // Container(
            //   height: 260,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Row(
            //         children: [
            //           RevenueInfo(
            //             title: "Toda\'s revenue",
            //             amount: "230",
            //           ),
            //           RevenueInfo(
            //             title: "Last 7 days",
            //             amount: "1,100",
            //           ),
            //         ],
            //       ),
            //       Row(
            //         children: [
            //           RevenueInfo(
            //             title: "Last 30 days",
            //             amount: "3,230",
            //           ),
            //           RevenueInfo(
            //             title: "Last 12 months",
            //             amount: "11,300",
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
