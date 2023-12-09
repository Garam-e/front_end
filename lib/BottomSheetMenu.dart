import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'reset_password.dart';
import 'setting.dart';
import 'menu.dart';
import 'FAQ.dart';
import 'usageGuide.dart';

class BottomSheetMenu {
  static void show(BuildContext context, bool loginState) {
    double screenWidth = 0.0; // 적절한 초기 값으로 변경
    screenWidth = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white, // 백그라운드 컬러를 흰색으로 설정합니다.
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(30)), // 모서리를 둥글게 합니다.
          ),
          padding: EdgeInsets.all(20),
          height: 240,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset('assets/Line 34.png'),
              ),
              SizedBox(height: 45),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: screenWidth * 0.13), // 오른쪽으로 조금 이동
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    loginState ? setting() : menuPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: 62,
                            height: 62,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFEDF4FF), // 배경 색상
                            ),
                            child: Center(
                              child: Icon(
                                Icons.settings_outlined,
                                color: Color(0xFF2F5B9C),
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          context.watch<MainProvider>().language == "KOR"
                              ? '설정'
                              : "Setting",
                          style: TextStyle(
                            color: Color(0xFF2F5B9C),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          FAQ.showFAQDialog(context);
                        },
                        child: Container(
                          width: 62,
                          height: 62,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFEDF4FF), // 배경 색상
                          ),
                          child: Center(
                            child: Icon(
                              Icons.campaign,
                              color: Color(0xFF2F5B9C),
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'FAQ',
                        style: TextStyle(
                          color: Color(0xFF2F5B9C),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: screenWidth * 0.13), // 왼쪽으로 조금 이동
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showUsageGuideDialog(context);
                          },
                          child: Container(
                            width: 62,
                            height: 62,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFEDF4FF), // 배경 색상
                            ),
                            child: Center(
                              child: Icon(
                                Icons.help_outline,
                                color: Color(0xFF2F5B9C),
                                size: 35,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          context.watch<MainProvider>().language == "KOR"
                              ? '이용안내'
                              : "Guide",
                          style: TextStyle(
                            color: Color(0xFF2F5B9C),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
