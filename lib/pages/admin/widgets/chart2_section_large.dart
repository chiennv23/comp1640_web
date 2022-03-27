import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/reponsive_pages.dart';
import 'package:comp1640_web/modules/posts/controlls/post_controller.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/pages/admin/widgets/circle_chart.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class Chart2SectionLarger extends StatefulWidget {
  const Chart2SectionLarger({Key key}) : super(key: key);

  @override
  State<Chart2SectionLarger> createState() => _Chart2SectionLargerState();
}

class _Chart2SectionLargerState extends State<Chart2SectionLarger> {
  ThreadController threadController = Get.find();
  PostController postController = Get.find();

  Widget showChangeThread() {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.all(20.0),
          width: ResponsiveWidget.isSmallScreen(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width / 3,
          height: 130.0 * threadController.ThreadList.length,
          decoration: BoxDecoration(
              color: spaceColor, borderRadius: BorderRadius.circular(12.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Change thread',
                size: 20,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: threadController.ThreadList.length,
                  itemBuilder: (context, i) {
                    final item = threadController.ThreadList[i];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        threadController.threadChartChoose(
                          thread: item.topic,
                          slug: item.slug,
                        );
                        postController.callListForChart(threadSlug: item.slug);
                        Get.back(result: item.topic);
                      },
                      title: CustomText(
                        text: item.topic,
                      ),
                      trailing:
                          threadController.threadSelected.value == item.topic
                              ? Icon(
                                  Icons.check_rounded,
                                  color: primaryColor2,
                                )
                              : const SizedBox(
                                  width: 1,
                                  height: 1,
                                ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 1.0,
                      thickness: 1.0,
                      color: primaryColor,
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Material(
                      color: active,
                      borderRadius: BorderRadius.circular(8.0),
                      child: InkWell(
                        onTap: () {
                          Get.back(
                              result: threadController.threadSelected.value);
                        },
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: const CustomText(
                            text: "Cancel",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 30),
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
              height: 300,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (threadController.ThreadList.isNotEmpty)
                        Obx(
                          () => Row(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              CustomText(
                                text: "Choose Thread: ",
                                size: ResponsiveWidget.isSmallScreen(context)
                                    ? 14
                                    : 20,
                                weight: FontWeight.normal,
                                color: greyColor,
                              ),
                              Tooltip(
                                message: 'Choose Thread',
                                child: InkWell(
                                  onTap: () async {
                                    threadController.threadSelected.value =
                                        await Get.dialog(showChangeThread());
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color: spaceColor,
                                      borderRadius: BorderRadius.circular(8.0),
                                      border: Border.all(color: primaryColor2),
                                    ),
                                    child: CustomText(
                                      text: threadController
                                                  .threadSelected.value ==
                                              ''
                                          ? threadController
                                              .ThreadList?.first?.topic
                                          : threadController
                                              .threadSelected.value,
                                      size: ResponsiveWidget.isSmallScreen(
                                              context)
                                          ? 16
                                          : 20,
                                      weight: FontWeight.bold,
                                      color: greyColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const Spacer(),
                      const CustomText(
                        text: 'Many comments',
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 5, top: 5, right: 10),
                        decoration: BoxDecoration(
                            color: primaryColor2, shape: BoxShape.circle),
                        width: 25,
                        height: 25,
                      ),
                      const CustomText(
                        text: 'Normal comments',
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 5, top: 5, right: 10),
                        decoration: BoxDecoration(
                            color: orangeColor, shape: BoxShape.circle),
                        width: 25,
                        height: 25,
                      ),
                      const CustomText(
                        text: 'Few comments',
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 5, top: 5, right: 10, bottom: 55),
                        decoration: BoxDecoration(
                            color: redColor, shape: BoxShape.circle),
                        width: 25,
                        height: 25,
                      ),
                    ],
                  ),
                  Obx(
                    () => Flexible(
                        child: postController.isLoadingChart.value
                            ? Stack(
                                alignment: AlignmentDirectional.center,
                                fit: StackFit.loose,
                                children: [
                                  PieOutsideLabelChart.withSampleData(),
                                  SpinKitFadingCircle(
                                    color: spaceColor,
                                  )
                                ],
                              )
                            : postController.postListChartController.isEmpty
                                ? Stack(
                                    alignment: AlignmentDirectional.center,
                                    fit: StackFit.loose,
                                    children: [
                                      PieOutsideLabelChart.withSampleData(),
                                      CustomText(
                                        text: 'No ideas in thread',
                                      )
                                    ],
                                  )
                                : PieOutsideLabelChart(
                                    postController.commentsAndPostsChart)),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
