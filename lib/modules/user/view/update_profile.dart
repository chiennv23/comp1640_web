import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/reponsive_pages.dart';
import 'package:comp1640_web/modules/login/controller/user_controller.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:comp1640_web/utils/validations.dart';

class UpdateProfile extends StatefulWidget {
  @override
  State<UpdateProfile> createState() => _PostCreateState();
}

class _PostCreateState extends State<UpdateProfile>
    with InputValidationMixin, SingleTickerProviderStateMixin {
  var emailController = TextEditingController();
  var userNameController = TextEditingController();
  var oldPassController = TextEditingController();
  var passController = TextEditingController();
  var verifyPassController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();
  bool hasAutoValidation = false;

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    UserController userController = Get.find();
    return Scaffold(
      body: Center(
        child: Container(
          width: ResponsiveWidget.isSmallScreen(context) ? wid - 100 : wid / 3,
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
                const CustomText(
                  text: 'Update my profile',
                  size: 20,
                  weight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: emailController,
                        validator: (email) {
                          if (isEmailValid(email)) {
                            return null;
                          } else {
                            return 'Error invalid email@gmail.com';
                          }
                        },
                        decoration: InputDecoration(
                            focusColor: primaryColor2.withOpacity(.4),
                            labelText: "Email",
                            hintText: "abc@gmail.com",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: userNameController,
                        validator: (username) {
                          if (username.isNotEmpty) {
                            return null;
                          } else {
                            return 'Enter a valid username';
                          }
                        },
                        decoration: InputDecoration(
                            focusColor: primaryColor2.withOpacity(.4),
                            labelText: "UserName",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  controller: oldPassController,
                  validator: (password) {
                    if (isPasswordValid(password)) {
                      return null;
                    } else {
                      return 'Enter a valid password';
                    }
                  },
                  decoration: InputDecoration(
                      focusColor: primaryColor2.withOpacity(.4),
                      labelText: "Old Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  controller: passController,
                  validator: (password) {
                    if (isPasswordValid(password)) {
                      return null;
                    } else {
                      return 'Enter a valid password';
                    }
                  },
                  decoration: InputDecoration(
                      focusColor: primaryColor2.withOpacity(.4),
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  controller: verifyPassController,
                  validator: (password) {
                    if (passController.text == password) {
                      return null;
                    } else {
                      return 'Password verification failed';
                    }
                  },
                  decoration: InputDecoration(
                      focusColor: primaryColor2.withOpacity(.4),
                      labelText: "VerifyPassword",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Obx(
                        () => Material(
                          color: primaryColor2,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: userController.isLoadingAction.value
                                ? null
                                : () async {
                                    setState(() {
                                      hasAutoValidation = true;
                                    });
                                    if (!formGlobalKey.currentState
                                        .validate()) {
                                      return;
                                    }
                                    userController.updateProfile(
                                        email: emailController.text,
                                        userName: userNameController.text,
                                        oldPassword: oldPassController.text,
                                        newPass: passController.text,
                                        confirmPass: verifyPassController.text);
                                  },
                            child: userController.isLoadingAction.value
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
                          ),
                        ),
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
