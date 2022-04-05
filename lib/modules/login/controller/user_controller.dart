import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/login/controller/login_controller.dart';
import 'package:comp1640_web/modules/login/models/user_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();

  var loading = false.obs;
  var isLoadingAction = false.obs;
  var userItem = UserItem().obs;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }

  Future getProfile() async {
    try {
      loading(true);
      final data = await LoginController.postProfile();
      if (data.code == 200) {
        userItem.value = data.data;
        SharedPreferencesHelper.instance
            .setString(key: 'UserName', val: userItem.value.username);
      } else {
        snackBarMessageError(data.message);
      }
    } catch (e) {
      print('get profile $e');
    } finally {
      loading(false);
    }
  }

  Future updateProfile({
    String email,
    String userName,
    String oldPassword,
    String newPass,
    String confirmPass,
  }) async {
    try {
      isLoadingAction(true);
      final data = await LoginController.editProfile(
          email: email,
          userName: userName,
          confirmPass: confirmPass,
          newPass: newPass,
          oldPassword: oldPassword);
      if (data.code == 200) {
        userItem.value.email = email;
        userItem.value.username = userName;
        userItem.refresh();
        SharedPreferencesHelper.instance
            .setString(key: 'UserName', val: userName);
        Get.back();
        snackBarMessage(
            backGroundColor: Colors.green, title: 'User updated successfully');
      }
    } catch (e) {
      print('update profile $e');
    } finally {
      isLoadingAction(false);
    }
  }
}
