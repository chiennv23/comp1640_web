import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/user/controller/user_manage_controller.dart';
import 'package:comp1640_web/modules/user/model/manageuser_item.dart';
import 'package:comp1640_web/modules/user/view/delete_user.dart';
import 'package:comp1640_web/modules/user/view/manage_user_view.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constant/style.dart';
import '../../helpers/datetime_convert.dart';
import '../../helpers/menu_controller.dart';
import '../../helpers/reponsive_pages.dart';
import '../../widgets/custom_text.dart';
import '../../modules/posts/controlls/post_controller.dart';
import '../../modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/modules/user/DA/user_data.dart';
import 'package:comp1640_web/modules/login/controller/user_controller.dart';
import 'package:comp1640_web/modules/user/view/edit_user.dart';

class ManageUser extends StatefulWidget {
  const ManageUser({Key key}) : super(key: key);

  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  String dropdownValue = 'All roles';
  var nameSlugLogin =
      SharedPreferencesHelper.instance.getString(key: 'nameSlug');

  @override
  Widget build(BuildContext context) {
    ManageUserController manageController = Get.find();
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
                        manageController.onInit();
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
                  const Spacer(),
                  const CustomText(
                    text: 'Sort by: ',
                    size: 16,
                  ),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 8,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      width: 20,
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'All roles',
                      'staff',
                      'admin',
                      'coordinator',
                      'manager'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Obx(
                () {
                  return Container(
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
                    child: DataTable2(
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
                            text: "Email",
                            color: darkColor,
                            size: 16,
                            weight: FontWeight.bold,
                          ),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: CustomText(
                            text: "Username",
                            color: darkColor,
                            size: 16,
                            weight: FontWeight.bold,
                          ),
                          size: ColumnSize.S,
                        ),
                        DataColumn2(
                          label: CustomText(
                            text: "Role",
                            color: darkColor,
                            size: 16,
                            weight: FontWeight.bold,
                          ),
                          size: ColumnSize.S,
                        ),
                        DataColumn2(
                          label: CustomText(
                            text: "Ideas",
                            color: darkColor,
                            size: 16,
                            weight: FontWeight.bold,
                          ),
                          size: ColumnSize.S,
                        ),
                        DataColumn2(
                          label: CustomText(
                            text: "Comments",
                            color: darkColor,
                            size: 16,
                            weight: FontWeight.bold,
                          ),
                          size: ColumnSize.S,
                        ),
                        DataColumn2(
                          label: CustomText(
                            text: "Create Date",
                            color: darkColor,
                            size: 16,
                            weight: FontWeight.bold,
                          ),
                          size: ColumnSize.M,
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
                      rows: manageController.isLoadingFirst.value
                          ? [dataRowLoading()]
                          : List<DataRow>.generate(
                              manageController
                                      .sortListByRole(dropdownValue)
                                      .length ??
                                  0,
                              (index) {
                                final item = manageController
                                    .sortListByRole(dropdownValue)[index];
                                return DataRow2(
                                  cells: [
                                    DataCell(CustomText(text: '${index + 1}')),
                                    DataCell(
                                        CustomText(text: item.email ?? '')),
                                    DataCell(
                                        CustomText(text: item.username ?? '')),
                                    DataCell(CustomText(
                                      text: item.role ?? '',
                                      color: item.role == 'admin'
                                          ? active
                                          : item.role == 'staff'
                                              ? successColor
                                              : orangeColor,
                                    )),
                                    DataCell(CustomText(
                                        text: '${item.posts.length}' ?? '0')),
                                    DataCell(CustomText(
                                        text:
                                            '${item.comments.length}' ?? '0')),
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
                                          if (item.slug != nameSlugLogin)
                                            Flexible(
                                              child: Tooltip(
                                                message: 'Edit',
                                                child: IconButton(
                                                    onPressed: () =>
                                                        showEdit(item),
                                                    icon: Icon(
                                                      Icons.edit_rounded,
                                                      color: primaryColor2,
                                                    )),
                                              ),
                                            ),
                                          if (item.slug != nameSlugLogin)
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
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void showEdit(item) {
    Get.dialog(EditUserManage(
      item: item,
    ));
  }

  void showView(item) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: UserView(item, nameSlugLogin),
      ),
    );
    // Get.dialog(ThreadView());
  }

  void showDelete(item) {
    ManageUserController manageController = Get.find();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: deleteDialog(
            deleteOnTap: () {
              manageController.deleteUserofmanage(item.slug);
            },
            controller: manageController),
      ),
    );
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
