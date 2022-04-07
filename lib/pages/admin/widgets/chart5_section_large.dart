import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/modules/posts/controlls/post_controller.dart';
import 'package:comp1640_web/pages/admin/widgets/line_chart.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'col_chart.dart';

class Chart5SectionLarger extends StatelessWidget {
  const Chart5SectionLarger({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 6),
              color: greyColor.withOpacity(.1),
              blurRadius: 12)
        ],
        border: Border.all(color: greyColor, width: .5),
      ),
      child: Column(
        children: [
          const CustomText(
            text: 'Ideas Created (7 days ago)',
            weight: FontWeight.bold,
          ),
          Container(
              height: 350,
              child: Row(
                children: [
                  Obx(
                        () => Flexible(
                        child: postController.isLoadingManage.value
                            ? StackedAreaLineChart.withSampleData()
                            : StackedAreaLineChart(
                            postController.lineIdeasCreates())),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
