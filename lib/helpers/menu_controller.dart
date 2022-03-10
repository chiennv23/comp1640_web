import 'package:comp1640_web/constant/route/route_navigate.dart';
import 'package:comp1640_web/constant/route/routes.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/login/controlls/login_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

MenuController menuController = MenuController.instance;
NavigationController navigationController = NavigationController.instance;

class MenuController extends GetxController {
  static MenuController instance = Get.find();

  var activeItem =
      checkRoleShowCategory(LoginController.name)[0].name.obs;

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

 get changeFirstItem{
    activeItem.value = checkRoleShowCategory(LoginController.name)[0].name;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isHovering(String itemName) => hoverItem.value == itemName;

  isActive(String itemName) => activeItem.value == itemName;
}
