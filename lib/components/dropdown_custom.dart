import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/modules/posts/controlls/post_controller.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:comp1640_web/modules/posts/views/post_create.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/modules/threads/view/thread_delete.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomButtonTest extends StatefulWidget {
  final PostItem itemPost;
  final String threadSlug;

  const CustomButtonTest({
    Key key,
    this.itemPost,
    this.threadSlug,
  }) : super(key: key);

  @override
  State<CustomButtonTest> createState() => _CustomButtonTestState();
}

class _CustomButtonTestState extends State<CustomButtonTest> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Icon(
          Icons.more_vert,
          color: active,
        ),
        customItemsIndexes: const [3],
        customItemsHeight: 8,
        items: MenuItems.firstItems
            .map(
              (item) => DropdownMenuItem<MenuItem>(
                value: item,
                child: MenuItems.buildItem(item),
              ),
            )
            .toList(),
        onChanged: (value) {
          MenuItems.onChanged(
            context,
            value as MenuItem,
            widget.itemPost,
            widget.threadSlug,
          );
        },
        itemHeight: 35,
        itemPadding: const EdgeInsets.only(left: 16, right: 16),
        dropdownWidth: 160,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: primaryColor2,
        ),
        dropdownElevation: 6,
        offset: const Offset(0, 8),
      ),
    );
  }
}

class MenuItem {
  final String text;
  final IconData icon;

  const MenuItem({
    this.text,
    this.icon,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [edit, download, delete];

  static const edit = MenuItem(text: 'Edit', icon: Icons.edit_rounded);
  static const download =
      MenuItem(text: 'Attachments', icon: Icons.download_rounded);
  static const delete = MenuItem(text: 'Delete', icon: Icons.delete_rounded);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static onChanged(
    BuildContext context,
    MenuItem item,
    PostItem itemPost,
    String threadSlug,
  ) {
    PostController postController = Get.find();
    ThreadController threadController = Get.find();

    switch (item) {
      case MenuItems.edit:
        threadController.checkDeadlineCreateIdea
            ? snackBarMessageError401(
                'Idea was out of date. Can not do action in this idea')
            : Get.dialog(
                PostCreate(
                  threadSlug: threadSlug,
                  item: itemPost,
                  thread: threadController.threadSelected.value,
                ),
              );
        break;
      case MenuItems.download:
        if (itemPost.files.isNotEmpty) {
          launch(
            itemPost.files.first.url,
          );
        }
        break;
      case MenuItems.delete:
        threadController.checkDeadlineCreateIdea
            ? snackBarMessageError401(
                'Idea was out of date. Can not do action in this idea')
            : Get.dialog(
                Center(
                  child: SizedBox(
                    width: 300,
                    child: deleteDialog(
                        deleteOnTap: () {
                          postController.deleteIdea(threadSlug, itemPost.slug);
                        },
                        controller: postController),
                  ),
                ),
              );
        break;
    }
  }
}
