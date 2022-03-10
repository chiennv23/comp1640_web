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
                  Container(
                    padding:
                    const EdgeInsets.only(top: 24, right: 24),
                    child: CustomText(
                      text:
                          "Posts in Thread: ${threadController.ThreadList.first.topic}",
                      size: 20,
                      weight: FontWeight.bold,
                      color: greyColor,
                    ),
                  ),
                  Flexible(
                    child: Center(
                      child: postController.isLoading.value
                          ? const CircularProgressIndicator()
                          : ListView.builder(
                              padding:
                                  const EdgeInsets.only(top: 16, right: 24),
                              itemCount: postController.postList.length,
                              itemBuilder: (context, index) {
                                final item = postController.postList[index];
                                return postCard(
                                    title: item.title,
                                    author: item.author.username,
                                    content: item.content,
                                    createDate:
                                        DatetimeConvert.dMy_hm(item.updatedAt));
                                return Text(item.title);
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

  Widget postCard(
      {String title, String author, String content, String createDate}) {
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
                text: author,
                weight: FontWeight.w600,
              ),
              subtitle: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: '$title (create date: $createDate)' ?? '',
                    size: 14,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                content ?? '',
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
                        onPressed: () {
                          setState(() {
                            like++;
                            like = like;
                          });
                        },
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 8),
                          child: CustomText(
                            text: '$like',
                          ))
                    ],
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.thumb_down,
                        ),
                        tooltip: 'Dislike',
                        onPressed: () {
                          if (disLike > 0) {
                            setState(() {
                              disLike--;
                              disLike = disLike;
                            });
                          }
                        },
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 8),
                          child: CustomText(
                            text: '$disLike',
                          ))
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
