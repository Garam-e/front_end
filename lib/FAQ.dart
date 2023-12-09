import 'package:flutter/material.dart';
import 'main.dart';
import 'reset_password.dart';
import 'setting.dart';
import 'menu.dart';
import 'BottomSheetMenu.dart';
import 'package:provider/provider.dart';

class FAQ {
  static void showFAQDialog(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.83;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            var selectionProvider = context.read<SelectionProvider>();
            var selectedItems = List.generate(
              10,
              (index) => selectionProvider.isSelected(index),
            );

            return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Container(
                color: Colors.white,
                width: screenWidth * 0.9,
                height: screenWidth * 1.1,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 15),
                        Icon(
                          Icons.campaign,
                          color: Color(0xFF2F5B9C),
                          size: 25,
                        ),
                        SizedBox(width: buttonWidth * 0.33),
                        Expanded(
                          child: Text(
                            "FAQ",
                            style: TextStyle(
                              color: Color(0xFF2F5B9C),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close),
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFEDF4FF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 0,
                        ),
                        child: SizedBox(
                          height: 380,
                          width: screenWidth * 0.73,
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              String itemName = '';
                              switch (index) {
                                case 0:
                                  itemName = 'Q.가천대생만 이용가능한가요?';
                                  break;
                                case 1:
                                  itemName =
                                      'Q.좀 더 정확한 답변을 얻을 수 있는 질문 규칙이 존재하나요?';
                                  break;
                                case 2:
                                  itemName = 'Q.어떤 플랫폼에서 사용할 수 있나요?';
                                  break;
                                case 3:
                                  itemName = 'Q.회원가입 시 어떤 요소가 필요한가요?';
                                  break;
                                case 4:
                                  itemName = 'Q.문서를 읽히고 질문 하는 것 외에 추가할 수 있나요?';
                                  break;
                                case 5:
                                  itemName = 'Q.학습 시킬 수 있는 문서 형식은 어떠한 종류가 있나요?';
                                  break;
                                case 6:
                                  itemName =
                                      'Q.제가 질문했던 내용을 따로 저장할 수 있는 기능이 있나요?';
                                  break;
                                default:
                                  itemName = '~~~~~~~~~~~';
                                  break;
                              }

                              return Theme(
                                data: Theme.of(context).copyWith(
                                    splashFactory:
                                        NoSplash.splashFactory), // 잉크 스플래시 제거
                                child: ExpansionTile(
                                  title: Row(
                                    children: [
                                      Container(
                                        width: screenWidth * 0.5,
                                        child: Text(
                                          itemName,
                                          softWrap: true,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (index == 0)
                                            Text(
                                                "기본적인 채팅 기능은 모두가 사용가능합니다만 그리팅 메시지와 문의 같은 기능을 사용하기 위해선 가천대 이메일을 통한 로그인을 해야합니다.")
                                          else if (index == 1)
                                            Text(
                                                "질문은 ~~~ 방식으로 해야 가장 정확한 답변을 얻을 수 있습니다.")
                                          else if (index == 2)
                                            Text("~~~ 플랫폼에서 사용할 수 있습니다.")
                                          // 이와 같이 각 질문에 해당하는 답변을 추가하세요.
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
