import 'package:comp1640_web/constant/route/routes.dart';
import 'package:comp1640_web/constant/style.dart';
import 'package:comp1640_web/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/error.png",
            width: 350,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CustomText(
                text: "Page not found",
                size: 24,
                weight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              Get.offAllNamed(loginPageRoute);
              // snackBarMessage('Hãy nhập User hoặc Password còn thiếu');
            },
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                  color: active, borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: const CustomText(
                text: "Back to login page.",
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
