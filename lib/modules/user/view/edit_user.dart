import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/datetime_convert.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/modules/threads/model/thread_item.dart';
import 'package:comp1640_web/modules/user/controller/user_manage_controller.dart';
import 'package:comp1640_web/modules/user/model/manageuser_item.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class EditUserManage extends StatefulWidget {
  final manageuser_item item;

  const EditUserManage({Key key, this.item}) : super(key: key);

  @override
  State<EditUserManage> createState() => _EditUserManageState();
}

class _EditUserManageState extends State<EditUserManage> {
  String dropdownValue = 'staff';
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();
  bool hasAutoValidation = false;
  DateTime initDateIdea = DateTime.now();
  DateTime initDateComment = DateTime.now();
  bool checkApprovethread = false;

  @override
  void initState() {
    dropdownValue = widget.item.role;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ManageUserController manangeController = Get.find();
    final px = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Container(
          width: px.width / 2,
          decoration: BoxDecoration(
              color: spaceColor, borderRadius: BorderRadius.circular(12.0)),
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formGlobalKey,
            autovalidateMode: hasAutoValidation
                ? AutovalidateMode.onUserInteraction
                : AutovalidateMode.disabled,
            child: Column(
              children: [
                Column(
                  children: [
                    const CustomText(
                      text: 'Edit Role of User Account',
                      size: 20,
                      weight: FontWeight.bold,
                    ),
                    ListTile(
                      title: const CustomText(
                        text: "ID",
                        color: darkColor,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                      trailing: Text(
                        widget.item.sId ?? '',
                        maxLines: 2,
                      ),
                    ),
                    ListTile(
                      title: const CustomText(
                        text: "Email",
                        color: darkColor,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                      trailing: Text(widget.item.email ?? ''),
                    ),
                    ListTile(
                      title: const CustomText(
                        text: "UserName",
                        color: darkColor,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                      trailing: Text(widget.item.username ?? ''),
                    ),
                    ListTile(
                      title: const CustomText(
                        text: "Created",
                        color: darkColor,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                      trailing: Text(
                          DatetimeConvert.dMy_hm(widget.item.createdAt) ?? ''),
                    ),
                    ListTile(
                      title: const CustomText(
                        text: "Role",
                        color: darkColor,
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                      trailing: DropdownButton<String>(
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
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Material(
                        color: primaryColor2,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () async {
                              setState(() {
                                hasAutoValidation = true;
                              });
                              if (!formGlobalKey.currentState.validate()) {
                                return;
                              }
                              if (widget.item != null) {
                                manangeController.editUserManage(
                                    sid: widget.item.sId,
                                    slug: widget.item.slug,
                                    role: dropdownValue);
                                return;
                              }
                            },
                            child: Obx(
                              () => manangeController.isLoadingAction.value
                                  ? SpinKitThreeBounce(
                                      color: spaceColor,
                                      size: 25,
                                    )
                                  : Center(
                                      child: CustomText(
                                        text: 'Change',
                                        color: spaceColor,
                                      ),
                                    ),
                            )),
                      ),
                    )),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Material(
                          color: greyColor.withOpacity(.5),
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              Get.back();
                            },
                            child: const Center(
                              child: CustomText(
                                text: 'Cancel',
                                color: darkColor,
                              ),
                            ),
                          )),
                    )),
                  ],
                )
              ],
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
      ),
    );
  }
}
