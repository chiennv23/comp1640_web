import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/datetime_convert.dart';
import 'package:comp1640_web/helpers/menu_controller.dart';
import 'package:comp1640_web/helpers/reponsive_pages.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/modules/threads/view/thread_create.dart';
import 'package:comp1640_web/modules/threads/view/thread_delete.dart';
import 'package:comp1640_web/modules/threads/view/thread_view.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThreadManage extends StatefulWidget {
  const ThreadManage({Key key}) : super(key: key);

  @override
  State<ThreadManage> createState() => _ThreadManageState();
}

class _ThreadManageState extends State<ThreadManage> {
  @override
  Widget build(BuildContext context) {
    ThreadController threadController = Get.find();

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
        Flexible(
          child: ListView(
            children: [
              Row(
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
                          text: "Refresh table",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Material(
                    color: active,
                    borderRadius: BorderRadius.circular(8.0),
                    child: InkWell(
                      onTap: showCreate,
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: const CustomText(
                          text: "Add New",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: active.withOpacity(.4), width: .5),
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
                child: Obx(
                  () => DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 600,
                    columns: const [
                      DataColumn2(
                        label: CustomText(
                          text: "Topic",
                          color: darkColor,
                          size: 16,
                          weight: FontWeight.bold,
                        ),
                        size: ColumnSize.L,
                      ),
                      DataColumn(
                        label: CustomText(
                          text: "Description",
                          color: darkColor,
                          size: 16,
                          weight: FontWeight.bold,
                        ),
                      ),
                      DataColumn(
                        label: CustomText(
                          text: "Creator",
                          color: darkColor,
                          size: 16,
                          weight: FontWeight.bold,
                        ),
                      ),
                      DataColumn(
                        label: CustomText(
                          text: "Slug",
                          color: darkColor,
                          size: 16,
                          weight: FontWeight.bold,
                        ),
                      ),
                      DataColumn2(
                        size: ColumnSize.S,
                        label: CustomText(
                          text: "Posts",
                          color: darkColor,
                          size: 16,
                          weight: FontWeight.bold,
                        ),
                      ),
                      DataColumn(
                        label: CustomText(
                          text: "Create date",
                          color: darkColor,
                          size: 16,
                          weight: FontWeight.bold,
                        ),
                      ),
                      DataColumn(
                        label: CustomText(
                          text: "Expiration date",
                          color: darkColor,
                          size: 16,
                          weight: FontWeight.bold,
                        ),
                      ),
                      DataColumn(
                        label: CustomText(
                          text: "Action",
                          color: darkColor,
                          size: 16,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ],
                    rows: threadController.isLoadingFirst.value
                        ? [dataRowLoading()]
                        : List<DataRow>.generate(
                            threadController.ThreadList.length ?? 0,
                            (index) {
                              final item = threadController.ThreadList.reversed.toList()[index];
                              return DataRow2(
                                cells: [
                                  DataCell(CustomText(text: item.topic ?? '')),
                                  DataCell(
                                      CustomText(text: item.description ?? '')),
                                  DataCell(CustomText(
                                      text: item.creator.email ?? '')),
                                  DataCell(CustomText(text: item.slug ?? '')),
                                  DataCell(CustomText(
                                      text: item.posts.length.toString())),
                                  DataCell(CustomText(
                                      text: DatetimeConvert.dMy_hm(
                                          item.createdAt))),
                                  DataCell(CustomText(
                                      text: DatetimeConvert.dMy_hm(
                                          item.deadline))),
                                  DataCell(
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Tooltip(
                                            message: 'View',
                                            child: IconButton(
                                                onPressed: () => showView(item),
                                                icon: Icon(
                                                  Icons.visibility,
                                                  color: primaryColor2,
                                                )),
                                          ),
                                        ),
                                        Flexible(
                                          child: Tooltip(
                                            message: 'Edit',
                                            child: IconButton(
                                                onPressed: () => showEdit(item),
                                                icon: Icon(
                                                  Icons.edit_rounded,
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
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  void showView(item) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: ThreadView(item),
      ),
    );
    // Get.dialog(ThreadView());
  }

  void showDelete(item) {
    ThreadController threadController = Get.find();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: deleteDialog(
            deleteOnTap: () {
              threadController.deleteThread(item.slug);
            },
            controller: threadController),
      ),
    );
  }

  void showCreate() {
    Get.dialog(ThreadCreate());
  }

  void showEdit(item) {
    Get.dialog(ThreadCreate(
      item: item,
    ));
  }

  DataRow dataRowLoading() => DataRow(cells: [
        ...List<DataCell>.generate(
          7,
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
                  message: 'Edit',
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_rounded,
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
            ],
          ),
        ),
      ]);
}
