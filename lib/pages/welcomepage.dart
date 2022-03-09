import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/datetime_convert.dart';
import 'package:comp1640_web/modules/posts/controlls/post_controller.dart';
import 'package:comp1640_web/modules/posts/models/post_item.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PostItem> listPost = [];
  int like = 10;
  int disLike = 2;

  @override
  void initState() {
    // getListPost();
    super.initState();
  }

  getListPost() async {
    // var data = await PostController.getAllPost();
    // setState(() {
    //   listPost = data.data.first.posts;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text('lalala')),
    );
    // return Scaffold(
    //   backgroundColor: lightColor,
    //   body: SafeArea(
    //     child: Center(
    //       child: listPost.isEmpty
    //           ? CircularProgressIndicator()
    //           : ListView.builder(
    //           padding: EdgeInsets.all(24),
    //           itemCount: listPost.length,
    //           itemBuilder: (context, index) {
    //             final item = listPost[index];
    //             return postCard(
    //                 title: item.title,
    //                 author:
    //                 '${item.author.username} (${item.author.email})',
    //                 content: item.content,
    //                 createDate: DatetimeConvert.dMy_hm(item.updatedAt));
    //             return Text(item.title);
    //           }),
    //     ),
    //   ),
    // );
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
