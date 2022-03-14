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
  @override
  void initState() {
    Get.put(ThreadController());
    Get.put(PostController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();
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
                                    await Get.dialog(showChangeThread())
                                        .whenComplete(() {
                                  setState(() {
                                    postController.postList.forEach((element) {
                                      element.checkComment = false;
                                    });
                                  });
                                });
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
                                  itemBuilder: (context, i) {
                                    final item = postController.postList[i];
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
                        Material(
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
      shape: RoundedRectangleBorder(
        side: BorderSide(color: primaryColor2.withOpacity(.4), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
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
                      )),
                  const SizedBox(
                    width: 24,
                  ),
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
                      child: CustomText(text: '${item.downvotes.length}')),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Divider(
                color: darkColor.withOpacity(.2),
                height: 0.0,
              ),
            ),
            AnimatedCrossFade(
              duration: const Duration(microseconds: 1000),
              secondChild: item.comments.isEmpty
                  ? Container(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: CustomText(
                              text: 'Comments:',
                              weight: FontWeight.bold,
                              size: 16,
                            ),
                          ),
                          commentWidget(),
                        ],
                      ))
                  : Container(
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: CustomText(
                              text: 'Comments:',
                              weight: FontWeight.bold,
                              size: 16,
                            ),
                          ),
                          ...showCommentWidget(item),
                          Container(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: commentWidget())
                        ],
                      ),
                    ),
              crossFadeState: item.checkComment
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CustomText(
                            text: item.comments.isEmpty
                                ? 'No comments yet.'
                                : 'There are ${item.comments.length} comments.'),
                        item.checkComment
                            ? Container()
                            : TextButton(
                                onPressed: () => showComment(item),
                                child: CustomText(
                                  text: item.comments.isEmpty
                                      ? 'Comment now!'
                                      : 'Show all comment?',
                                  weight: FontWeight.bold,
                                ),
                              )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future showComment(item) {
    print('show comments');
    setState(() {
      item.checkComment = true;
    });
  }

  Widget commentWidget() {
    return Container(
      height: 56,
      child: TextFormField(
        decoration: InputDecoration(
            labelText: "Comment",
            hintText: "Typing something",
            suffixIcon: IconButton(
              iconSize: 14,
              icon: Icon(
                Icons.send_rounded,
                color: active,
                size: 20,
              ),
              tooltip: 'Sent comment',
              onPressed: () {},
            ),
            focusColor: primaryColor2.withOpacity(.4),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor2, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            )),
      ),
    );
  }

  List<Widget> showCommentWidget(PostItem postItem) {
    PostController postController = Get.find();

    return List.generate(postItem.comments.length, (index) {
      var item = postItem.comments[index];
      return Container(
        margin: const EdgeInsets.only(
          bottom: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.account_circle,
                color: greyColor,
                size: 35,
              ),
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                  color: primaryColor.withOpacity(.1),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: item.author.username,
                    weight: FontWeight.w600,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                    child: CustomText(
                      text: item.content ?? '',
                      size: 14,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        iconSize: 14,
                        icon: const Icon(
                          Icons.thumb_up,
                          size: 16,
                        ),
                        tooltip: 'Like comment',
                        onPressed: item.oneClickActionCmt
                            ? () {
                                postController.chooseLikeCmt(
                                    title: postItem.title,
                                    content: item.content);
                                setState(() {
                                  item.oneClickActionCmt = false;
                                });
                              }
                            : null,
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 8),
                          child: CustomText(
                            text: '${item.upvotes.length}',
                          )),
                      const SizedBox(
                        width: 24,
                      ),
                      IconButton(
                        iconSize: 14,
                        icon: const Icon(
                          Icons.thumb_down,
                          size: 16,
                        ),
                        tooltip: 'Dislike comment',
                        onPressed: item.oneClickActionCmt
                            ? () {
                                postController.chooseDisLikeCmt(
                                    title: postItem.title,
                                    content: item.content);
                                setState(() {
                                  item.oneClickActionCmt = false;
                                });
                              }
                            : null,
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 8),
                          child: CustomText(text: '${item.downvotes.length}')),
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
      );
    });
  }
}
