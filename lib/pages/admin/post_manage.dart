import 'package:comp1640_web/modules/posts/DA/post_data.dart';
import 'package:comp1640_web/modules/posts/controlls/post_controller.dart';
import 'package:comp1640_web/modules/threads/view/create_success.dart';
import 'package:comp1640_web/modules/threads/view/thread_delete.dart';
import 'package:comp1640_web/utils/export_csv.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/style.dart';
import '../../helpers/datetime_convert.dart';
import '../../helpers/menu_controller.dart';
import '../../helpers/reponsive_pages.dart';
import 'package:comp1640_web/modules/posts/views/post_view.dart';

class PostManage extends StatefulWidget {
  const PostManage({Key key}) : super(key: key);

  @override
  State<PostManage> createState() => _PostManageState();
}

class _PostManageState extends State<PostManage> {
  PostController postController = Get.find();
  bool isLoadingAtt = false;
  bool isLoadingCSV = false;
  int indexPage = 1;

  @override
  void initState() {
    postController.callListForManage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
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
        Flexible(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    color: primaryColor2,
                    borderRadius: BorderRadius.circular(8.0),
                    child: InkWell(
                      onTap: () {
                        postController.callListForManage();
                        setState(() {
                          indexPage = 1;
                        });
                      },
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: const CustomText(
                          text: "Refresh table",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => Row(
                      children: [
                        Material(
                          color: primaryColor2,
                          borderRadius: BorderRadius.circular(8.0),
                          child: InkWell(
                            onTap: postController.isLoadingAction.value
                                ? null
                                : isLoadingAtt
                                    ? null
                                    : () async {
                                        setState(() {
                                          isLoadingAtt = true;
                                        });
                                        await PostData.exportDataAttachments()
                                            .whenComplete(() {
                                          setState(() {
                                            isLoadingAtt = false;
                                          });
                                        });
                                      },
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: isLoadingAtt
                                  ? SpinKitThreeBounce(
                                      color: spaceColor,
                                      size: 25,
                                    )
                                  : const CustomText(
                                      text: "Export attachments",
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Material(
                          color: primaryColor2,
                          borderRadius: BorderRadius.circular(8.0),
                          child: InkWell(
                            onTap: postController.isLoadingManage.value
                                ? null
                                : isLoadingCSV
                                    ? null
                                    : () async {
                                        setState(() {
                                          isLoadingCSV = true;
                                        });
                                        await PostData.exportCSV()
                                            .whenComplete(() {
                                          setState(() {
                                            isLoadingCSV = false;
                                          });
                                        });
                                      },
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: isLoadingCSV
                                  ? SpinKitThreeBounce(
                                      color: spaceColor,
                                      size: 25,
                                    )
                                  : const CustomText(
                                      text: "Export data CSV",
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
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: active.withOpacity(.4), width: .5),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 6),
                          color: greyColor.withOpacity(.1),
                          blurRadius: 12)
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 30, top: 15.0),
                  child: Column(
                    children: [
                      DataTable2(
                        columnSpacing: 12,
                        horizontalMargin: 12,
                        minWidth: 600,
                        columns: const [
                          DataColumn2(
                            label: CustomText(
                              text: "STT",
                              color: darkColor,
                              size: 16,
                              weight: FontWeight.bold,
                            ),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: CustomText(
                              text: "UserName",
                              color: darkColor,
                              size: 16,
                              weight: FontWeight.bold,
                            ),
                            size: ColumnSize.L,
                          ),
                          DataColumn(
                            label: CustomText(
                              text: "Title of Idea",
                              color: darkColor,
                              size: 16,
                              weight: FontWeight.bold,
                            ),
                          ),
                          DataColumn(
                            label: CustomText(
                              text: "Thread",
                              color: darkColor,
                              size: 16,
                              weight: FontWeight.bold,
                            ),
                          ),
                          DataColumn2(
                            label: CustomText(
                              text: "Attachment",
                              color: darkColor,
                              size: 16,
                              weight: FontWeight.bold,
                            ),
                            size: ColumnSize.L,
                          ),
                          DataColumn(
                            label: CustomText(
                              text: "Create Date",
                              color: darkColor,
                              size: 16,
                              weight: FontWeight.bold,
                            ),
                          ),
                          DataColumn2(
                            label: CustomText(
                              text: "Action",
                              color: darkColor,
                              size: 16,
                              weight: FontWeight.bold,
                            ),
                            size: ColumnSize.S,
                          ),
                        ],
                        rows: postController.isLoadingManage.value
                            ? [dataRowLoading()]
                            : List<DataRow>.generate(
                                postController.postListManageController
                                        .skip((indexPage - 1) * 10)
                                        .take(10)
                                        .toList()
                                        .length ??
                                    0,
                                (index) {
                                  final item = postController
                                      .postListManageController
                                      .skip((indexPage - 1) * 10)
                                      .take(10)
                                      .toList()[index];
                                  return DataRow2(
                                    cells: [
                                      DataCell(CustomText(
                                          text:
                                              '${index + 1 + (indexPage - 1) * 10}' ??
                                                  '')),
                                      DataCell(CustomText(
                                          text: item.author.username ?? '')),
                                      DataCell(
                                          CustomText(text: item.title ?? '')),
                                      DataCell(CustomText(
                                          text: item.thread.topic ?? '')),
                                      DataCell(
                                        Tooltip(
                                          message: item.files.isEmpty
                                              ? ''
                                              : item.files.first.url
                                                  .split('/')
                                                  .last,
                                          child: CustomText(
                                            text: item.files.isEmpty
                                                ? ''
                                                : item.files.first.url
                                                    .split('/')
                                                    .last,
                                            maxLine: 2,
                                            color: primaryColor2,
                                          ),
                                        ),
                                        onTap: () async {
                                          await launch(
                                            item.files.first.url,
                                          );
                                        },
                                      ),
                                      DataCell(CustomText(
                                          text: DatetimeConvert.dMy_hm(
                                              item.createdAt))),
                                      DataCell(
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Flexible(
                                              child: Tooltip(
                                                message: 'View',
                                                child: IconButton(
                                                    onPressed: () =>
                                                        showView(item),
                                                    icon: Icon(
                                                      Icons.visibility,
                                                      color: primaryColor2,
                                                    )),
                                              ),
                                            ),
                                            Flexible(
                                              child: Tooltip(
                                                message: 'Delete',
                                                child: IconButton(
                                                    onPressed: () =>
                                                        showDelete(item),
                                                    icon: Icon(
                                                      Icons.delete_rounded,
                                                      color: primaryColor2,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                      ),
                      if (postController.isLoadingManage.value == false)
                        Container(
                          padding: const EdgeInsets.only(bottom: 15, top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (indexPage > 2)
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        indexPage = 1;
                                      });
                                    },
                                    child: CustomText(
                                        weight: FontWeight.bold,
                                        color: active,
                                        text: 'Previous page 1')),
                              const SizedBox(
                                width: 5,
                              ),
                              if (indexPage != 1)
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        indexPage -= 1;
                                      });
                                    },
                                    child: CustomText(
                                        weight: FontWeight.bold,
                                        color: active,
                                        text:
                                            'Previous page ${indexPage - 1}')),
                              const SizedBox(
                                width: 5,
                              ),
                              CustomText(
                                text: 'Page $indexPage',
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      indexPage += 1;
                                    });
                                  },
                                  child: CustomText(
                                      weight: FontWeight.bold,
                                      color: active,
                                      text: 'Next page ${indexPage + 1}')),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  void showView(item) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: PostView(item),
      ),
    );
  }

  void showDelete(item) {
    PostController postController = Get.find();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: deleteDialog(
            deleteOnTap: () {
              postController.deletePostofmanage(item.slug);
            },
            controller: postController),
      ),
    );
  }

  DataRow dataRowLoading() => DataRow(cells: [
        ...List<DataCell>.generate(
          6,
          (index) => const DataCell(CustomText(text: 'loading')),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Tooltip(
                  message: 'View',
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.visibility,
                        color: primaryColor2,
                      )),
                ),
              ),
              Flexible(
                child: Tooltip(
                  message: 'Delete',
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete_rounded,
                        color: primaryColor2,
                      )),
                ),
              ),
              // Flexible(
              //   child: Tooltip(
              //     message: 'Download',
              //     child: IconButton(
              //         onPressed: () {},
              //         icon: Icon(
              //           Icons.edit_rounded,
              //           color: primaryColor2,
              //         )),
              //   ),
              // ),
            ],
          ),
        ),
      ]);
}
