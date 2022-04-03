import 'dart:js';
import 'dart:math';

import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/modules/threads/view/create_success.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:comp1640_web/modules/user/DA/user_data.dart';
import 'package:comp1640_web/modules/user/model/manageuser_item.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../../components/snackbar_messenger.dart';
import '../../../constant/style.dart';
import '../../../helpers/storageKeys_helper.dart';

class ManageUserController extends GetxController {
  ThreadController threadController = Get.find();
  RxBool isLoadingFirst = true.obs;
  RxBool isLoadingAction = false.obs;
  final _userList = <manageuser_item>[].obs;
  var userSelected = ''.obs;
  var slugSelected = ''.obs;
  var userChartSelected = ''.obs;
  var slugChartSelected = ''.obs;

  @override
  void onInit() {
    callListIntoDA();
    super.onInit();
  }

  Future callListIntoDA() async {
    // try {
    isLoadingFirst(true);
    final data = await UserData.getAllUsers();
    if (data.code == 200) {
      isLoadingFirst(false);
      _userList.assignAll(data?.data);
    } else {
      isLoadingFirst(false);
      _userList;
    }
    // } catch (e) {
    //   print('manage error $e');
    // } finally {
    //   isLoadingFirst(false);
    // }
  }

  int get listUserLength => _userList.length;
  int get allItemsLength => _userList.length + threadController.ThreadList.length + threadController.AllPostInThread ;

  List<manageuser_item> sortListByRole(String role) {
    if (role == 'All roles') {
      return [..._userList];
    } else {
      return _userList.where((element) => element.role == role).toList();
    }
  }

  loadingAction(bool checkLoading) => isLoadingAction.value = checkLoading;

  List<charts.Series<manageuser_item, String>> get threadAndPostChart {
    var list = [..._userList]
      ..sort((b, a) => a.posts.length.compareTo(b.posts.length));
    return [
      charts.Series<manageuser_item, String>(
        id: 'Threads',
        colorFn: (manageuser_item user, count) {
          var post = user.posts.length;
          var postMax = _userList.map((m) => m.posts.length).reduce(max);
          if (post == postMax) {
            // max
            return charts.ColorUtil.fromDartColor(primaryColor2);
          } else if (post <= postMax / (1 / 4) && post >= postMax / 2) {
            // medium
            return charts.ColorUtil.fromDartColor(orangeColor);
          } else if (post < postMax / 2) {
            return charts.ColorUtil.fromDartColor(redColor);
          } else {
            return charts.ColorUtil.fromDartColor(redColor);
          }
        },
        domainFn: (manageuser_item user, _) => user.email,
        measureFn: (manageuser_item user, _) => user.posts.length,
        labelAccessorFn: (manageuser_item user, _) =>
            '${user.email}: ${user.posts.length.toString()} ideas',
        data: list,
      ),
    ];
  }

  deleteUserofmanage(String userSLug) async {
    try {
      loadingAction(true);
      final data = await UserData.deleteUser(userSLug);
      if (data.code == 200) {
        _userList.removeWhere((element) => element.slug == userSLug);
        _userList.refresh();
        if (_userList.any((element) => element.slug == userSLug)) {
          _userList.removeWhere((element) => element.slug == userSLug);
        }
        snackBarMessage(
            title: 'Delete successful!', backGroundColor: successColor);
        Get.back();
        update();
      }
    } catch (r) {
      print('delete thread error $r');
    } finally {
      loadingAction(false);
    }
  }

  editUserManage({
    String sid,
    String slug,
    String role,
  }) async {
    try {
      loadingAction(true);
      final data = await UserData.editUserManage(userSlug: slug, role: role);
      if (data.code == 200) {
        _userList[_userList.indexWhere((element) => element.sId == sid)].role =
            role;
        _userList.refresh();
        await Get.dialog(
          Center(
            child: SizedBox(
              width: 300,
              child: successDialog(
                  title: 'Congratulation!',
                  subTitle:
                      'You edited new role for ${_userList.firstWhere((element) => element.sId == sid).email}'),
            ),
          ),
        );
        snackBarMessage(
            title: 'Edit successful!', backGroundColor: successColor);
        Get.back();
        update();
      }
    } catch (e) {
      print('edit thread manage error $e');
    } finally {
      loadingAction(false);
    }
  }
}
