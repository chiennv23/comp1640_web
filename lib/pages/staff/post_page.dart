import 'package:cached_network_image/cached_network_image.dart';
import 'package:comp1640_web/components/dropdown_custom.dart';
import 'package:comp1640_web/components/snackbar_messenger.dart';
import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/datetime_convert.dart';
import 'package:comp1640_web/helpers/menu_controller.dart';
import 'package:comp1640_web/helpers/reponsive_pages.dart';
import 'package:comp1640_web/helpers/storageKeys_helper.dart';
import 'package:comp1640_web/modules/comments/controller/comment_controller.dart';
import 'package:comp1640_web/modules/comments/views/create_comment.dart';
import 'package:comp1640_web/modules/comments/views/show_comments.dart';
import 'package:comp1640_web/modules/posts/controlls/post_controller.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:comp1640_web/modules/posts/views/post_create.dart';
import 'package:comp1640_web/modules/threads/controller/thread_controller.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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
    Get.put(CommentController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PostController postController = Get.find();
    ThreadController threadController = Get.find();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: lightColor,
        body: Obx(
          () => Column(
            children: [
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top: ResponsiveWidget.isSmallScreen(context)
                              ? 56
                              : 15),
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
                              text: "Ideas in Thread: ",
                              size: ResponsiveWidget.isSmallScreen(context)
                                  ? 14
                                  : 20,
                              weight: FontWeight.normal,
                              color: greyColor,
                            ),
                            Tooltip(
                              message: 'Change Thread',
                              child: InkWell(
                                onTap: () async {
                                  threadController.threadSelected.value =
                                      await Get.dialog(showChangeThread())
                                          .whenComplete(() {
                                    setState(() {
                                      for (var element
                                          in postController.postList) {
                                        element.checkComment = false;
                                      }
                                    });
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: spaceColor,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: primaryColor2),
                                  ),
                                  child: CustomText(
                                    text: threadController
                                                .threadSelected.value ==
                                            ''
                                        ? threadController
                                            .ThreadList?.first?.topic
                                        : threadController.threadSelected.value,
                                    size:
                                        ResponsiveWidget.isSmallScreen(context)
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
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Material(
                          color: threadController.checkDeadlineCreateIdea
                              ? greyColor
                              : active,
                          borderRadius: BorderRadius.circular(8.0),
                          child: InkWell(
                            onTap: threadController.checkDeadlineCreateIdea
                                ? () => snackBarMessage(
                                    backGroundColor: redColor,
                                    title:
                                        'Could not create more ideas. Because ideas in ${threadController.threadSelected.value} thread were out of date.')
                                : () => showCreateIdea(
                                      thread:
                                          threadController.threadSelected.value,
                                      threadSlug:
                                          threadController.slugSelected.value,
                                    ),
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 5.0),
                                    child: Icon(
                                      Icons.create,
                                      color: spaceColor,
                                    ),
                                  ),
                                  const CustomText(
                                    text: "Create your idea",
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Flexible(
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: postController.isLoadingFirst.value
                              ? const CircularProgressIndicator(
                                  key: ValueKey(0),
                                )
                              : postController.postList.isEmpty
                                  ? const CustomText(
                                      key: ValueKey(1),
                                      text: 'No Idea to view. Try again !',
                                    )
                                  : ListView.builder(
                                      padding: const EdgeInsets.only(
                                          top: 16, right: 24),
                                      itemCount: postController.postList.length,
                                      itemBuilder: (context, i) {
                                        final item = postController.postList[i];
                                        return postCard(item,
                                            threadSlug: threadController
                                                .slugSelected.value);
                                      }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
          padding: const EdgeInsets.all(20.0),
          margin: const EdgeInsets.all(20.0),
          width: ResponsiveWidget.isSmallScreen(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width / 3,
          height: 130.0 * threadController.ThreadList.length,
          decoration: BoxDecoration(
              color: spaceColor, borderRadius: BorderRadius.circular(12.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: 'Change thread',
                size: 20,
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: threadController.ThreadList.length,
                  itemBuilder: (context, i) {
                    final item = threadController.ThreadList[i];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      onTap: () {
                        threadController.threadChangeChoose(
                            thread: item.topic,
                            slug: item.slug,
                            deadlineIdea: item.deadlineIdea,
                            deadlineComment: item.deadlineComment);
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
              Container(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Material(
                      color: active,
                      borderRadius: BorderRadius.circular(8.0),
                      child: InkWell(
                        onTap: () {
                          Get.back(
                              result: threadController.threadSelected.value);
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCreateIdea({String thread, String threadSlug, PostItem itemPost}) {
    Get.dialog(PostCreate(
      thread: thread,
      threadSlug: threadSlug,
      item: itemPost,
    ));
  }

  Widget postCard(PostItem item, {String threadSlug}) {
    PostController postController = Get.find();
    ThreadController threadController = Get.find();
    var nameSlugLogin =
        SharedPreferencesHelper.instance.getString(key: 'nameSlug');
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
                text: (item.author.slug == nameSlugLogin)
                    ? '${item.author.username} (You)'
                    : item.author.username,
                weight: FontWeight.w600,
              ),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Created: ${DatetimeConvert.dMy_hm(item.createdAt)}',
                    size: 14,
                  ),
                ],
              ),
              trailing: (item.author.slug == nameSlugLogin)
                  ? CustomButtonTest(
                      itemPost: item,
                      threadSlug: threadSlug,
                    )
                  : const SizedBox(
                      height: 1,
                      width: 1,
                    ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
              child: CustomText(
                text: 'Title: ${item.title}',
                size: 14,
                weight: FontWeight.w600,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 5, 16, 16),
              child: Text(
                item.content ?? '',
                maxLines: 100,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (item.files.isNotEmpty)
              (item.files.first.url.split('.').last == 'png' ||
                      item.files.first.url.split('.').last == 'jpg' ||
                      item.files.first.url.split('.').last == 'jpeg')
                  ? Hero(
                      tag: 'imageView',
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 5, 16, 16),
                        height: 100,
                        child: InkWell(
                          onTap: () => showViewImage(item.files.first.url),
                          child: Image.network(
                            item.files.first.url,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace stackTrace) {
                              return const Text('Error show image 😢');
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.fromLTRB(16, 5, 16, 16),
                      child: Row(
                        children: [
                          CustomText(
                            text: 'Attachment: ',
                            maxLine: 1,
                            color: primaryColor2,
                          ),
                          Tooltip(
                            message: 'Click to download',
                            child: TextButton(
                              child: CustomText(
                                text: item.files.first.url.split('/').last,
                                maxLine: 2,
                                color: primaryColor2,
                              ),
                              onPressed: () async {
                                await launch(
                                  item.files.first.url,
                                );
                              },
                            ),
                          ),
                        ],
                      )),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.thumb_up,
                    ),
                    tooltip: 'Like',
                    onPressed: threadController.checkDeadlineCreateIdea
                        ? null
                        : item.oneClickAction
                            ? () {
                                postController.chooseLike(
                                    item.title, item.oneClickAction,
                                    threadSlug: threadSlug,
                                    postSlug: item.slug);
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
                    onPressed: threadController.checkDeadlineCreateIdea
                        ? null
                        : item.oneClickAction
                            ? () {
                                postController.chooseDisLike(
                                    item.title, item.oneClickAction,
                                    threadSlug: threadSlug,
                                    postSlug: item.slug);
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
                  ? threadController.checkDeadlineComment
                      ? Container(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 14),
                          child: const CustomText(
                            text:
                                'Comment was out of date. Could not comment in here.',
                            weight: FontWeight.bold,
                            size: 16,
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: const CustomText(
                                  text: 'Comments:',
                                  weight: FontWeight.bold,
                                  size: 16,
                                ),
                              ),
                              CreateComment(
                                postItem: item,
                              ),
                            ],
                          ))
                  : Container(
                      padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: const CustomText(
                              text: 'Comments:',
                              weight: FontWeight.bold,
                              size: 16,
                            ),
                          ),
                          ShowComment(
                            postItem: item,
                            threadSlug: threadSlug,
                          ),
                          TextButton(
                            onPressed: () => hideComment(item),
                            child: const CustomText(
                              text: 'Hide all comment?',
                              weight: FontWeight.bold,
                            ),
                          ),
                          threadController.checkDeadlineComment
                              ? Container(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 10),
                                )
                              : Container(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 10),
                                  child: CreateComment(
                                    postItem: item,
                                  ))
                        ],
                      ),
                    ),
              crossFadeState: item.checkComment
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: CustomText(
                              text: item.comments.isEmpty
                                  ? 'No comments yet.'
                                  : 'There are ${item.comments.length} comments.'),
                        ),
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

  void showViewImage(String url) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        child: viewImage(url),
      ),
    );
    // Get.dialog(ThreadView());
  }

  Widget viewImage(String url) {
    return Hero(
        tag: 'imageView',
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width / 3,
          child: CachedNetworkImage(
            imageUrl: url,
            useOldImageOnUrlChange: true,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ));
  }

  void showComment(item) {
    print('show comments');
    setState(() {
      item.checkComment = true;
    });
  }

  void hideComment(item) {
    print('hide comments');
    setState(() {
      item.checkComment = false;
    });
  }
}
