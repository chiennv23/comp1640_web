import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/datetime_convert.dart';
import 'package:comp1640_web/helpers/menu_controller.dart';
import 'package:comp1640_web/helpers/reponsive_pages.dart';
import 'package:comp1640_web/modules/posts/controlls/post_controller.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int like = 10;
  int disLike = 2;

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.put(PostController());
    ThreadController threadController = Get.find();

    return Scaffold(
      backgroundColor: lightColor,
      body: Obx(
        () => Column(
          children: [
            Row(
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
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (threadController.ThreadList.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.only(top: 24, right: 24),
                      child: Row(
                        children: [
                          CustomText(
                            text: "Posts in Thread: ",
                            size: ResponsiveWidget.isSmallScreen(context)
                                ? 14
                                : 20,
                            weight: FontWeight.normal,
                            color: greyColor,
                          ),
                          Tooltip(
                            message: 'change Thread',
                            child: InkWell(
                              onTap: () async {
                                return threadController.threadSelected.value =
                                    await Get.dialog(showChangeThread());
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: spaceColor,
                                  border: Border.all(color: primaryColor2),
                                ),
                                child: CustomText(
                                  text: threadController.threadSelected.value ==
                                          ''
                                      ? threadController
                                          .ThreadList?.first?.topic
                                      : threadController.threadSelected.value,
                                  size: ResponsiveWidget.isSmallScreen(context)
                                      ? 16
                                      : 20,
                                  weight: FontWeight.bold,
                                  color: greyColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Flexible(
                    child: Center(
                      child: postController.isLoading.value
                          ? const CircularProgressIndicator()
                          : postController.postList.isEmpty
                              ? const Center(
                                  child: CustomText(
                                    text: 'No Post to view. Try again !',
                                  ),
                                )
                              : ListView.builder(
                                  padding:
                                      const EdgeInsets.only(top: 16, right: 24),
                                  itemCount: postController.postList.length,
                                  itemBuilder: (context, index) {
                                    final item = postController.postList[index];
                                    return postCard(item);
                                  }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget showChangeThread() {
    ThreadController threadController = Get.find();
    PostController postController = Get.find();
    var threadTemp = threadController.ThreadList?.first?.topic;
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          width: ResponsiveWidget.isSmallScreen(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width / 3,
          height: 56.0 * threadController.ThreadList.length,
          color: spaceColor,
          child: ListView.separated(
            itemCount: threadController.ThreadList.length,
            itemBuilder: (context, i) {
              final item = threadController.ThreadList[i];
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      threadController.threadChangeChoose(
                          thread: item.topic, slug: item.slug);
                      postController.onInit();
                      Get.back(result: item.topic);
                    },
                    title: CustomText(
                      text: item.topic,
                    ),
                    trailing:
                        threadController.threadSelected.value == item.topic
                            ? Icon(
                                Icons.check_rounded,
                                color: primaryColor2,
                              )
                            : const SizedBox(
                                width: 1,
                                height: 1,
                              ),
                  ),
                  if (i == threadController.ThreadList.length - 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Material(
                            color: active,
                            borderRadius: BorderRadius.circular(8.0),
                            child: InkWell(
                              onTap: () {
                                Get.back(
                                    result:
                                        threadController.threadSelected.value);
                              },
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0)),
                                child: const CustomText(
                                  text: "Cancel",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                height: 1.0,
                thickness: 1.0,
                color: primaryColor,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget postCard(PostItem item) {
    PostController postController = Get.find();

    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 24),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: lightColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Container(
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.account_circle,
                  size: 40,
                ),
              ),
              title: CustomText(
                text: item.author.username,
                weight: FontWeight.w600,
              ),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text:
                        '${item.title} (create date: ${DatetimeConvert.dMy_hm(item.updatedAt)})' ??
                            '',
                    size: 14,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                item.content ?? '',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Row(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.thumb_up,
                        ),
                        tooltip: 'Like',
                        onPressed: item.oneClickAction
                            ? () {
                                postController.chooseLike(item.title);
                                setState(() {
                                  item.oneClickAction = false;
                                });
                              }
                            : null,
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 8),
                          child: CustomText(
                            text: '${item.upvotes.length}',
                          ))
                    ],
                  ),
                  const SizedBox(
                    width: 24,
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.thumb_down,
                        ),
                        tooltip: 'Dislike',
                        onPressed: item.oneClickAction
                            ? () {
                                postController.chooseDisLike(item.title);
                                setState(() {
                                  item.oneClickAction = false;
                                });
                              }
                            : null,
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 8),
                          child: CustomText(text: '${item.downvotes.length}'))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
