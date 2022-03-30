import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/login/controller/login_controller.dart';
import 'package:comp1640_web/modules/login/models/user_items.dart';
import 'package:get/get.dart';

UserController userController = UserController.instance;

class UserController extends GetxController {
  static UserController instance = Get.find();

  var loading = false.obs;
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
}
