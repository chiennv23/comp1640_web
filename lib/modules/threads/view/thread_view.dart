import 'package:comp1640_web/constant/route/route_navigate.dart';
import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/helpers/datetime_convert.dart';
import 'package:comp1640_web/modules/threads/model/thread_item.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';

Widget ThreadView(ThreadItem item) => Container(
      width: 500,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: const CustomText(
              text: "Topic",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(
              item.topic ?? '',
              maxLines: 2,
            ),
          ),
          ListTile(
            title: const CustomText(
              text: "Description",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(item.description ?? ''),
          ),
          ListTile(
            title: const CustomText(
              text: "Creator",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(item.creator ?? ''),
          ),
          ListTile(
            title: const CustomText(
              text: "Slug",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(item.slug ?? ''),
          ),
          ListTile(
            title: const CustomText(
              text: "Posts",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(item.posts.length.toString()),
          ),
          ListTile(
            title: const CustomText(
              text: "Create Date",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(DatetimeConvert.dMy_hm(item.createdAt)),
          ),
          ListTile(
            title: const CustomText(
              text: "Update Date",
              color: darkColor,
              size: 16,
              weight: FontWeight.bold,
            ),
            trailing: Text(DatetimeConvert.dMy_hm(item.updatedAt)),
          ),
          Container(
            padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Tooltip(
                  message: 'Edit',
                  child: IconButton(
                      onPressed: () {
                        print('edit');
                      },
                      icon: Icon(
                        Icons.edit_rounded,
                        color: primaryColor2,
                      )),
                ),
                Tooltip(
                  message: 'Delete',
                  child: IconButton(
                      onPressed: () {
                        print('delete');
                      },
                      icon: Icon(
                        Icons.delete_rounded,
                        color: primaryColor2,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
