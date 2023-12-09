import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';

void showUsageGuideDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return UsageGuide();
    },
  );
}

class UsageGuide extends StatefulWidget {
  static const double dialogWidthFactor = 0.9;
  static const double dialogHeightFactor = 1.5;
  static const double imageSizeFactor = 1.0;
  static const double paddingSize = 15.0;
  static const double iconSize = 25.0;
  static const double fontSize = 12.0;

  static final List<Map<String, String>> guideList = [
    {
      'image': 'assets/guide1.jpg',
      'description':
          '메인화면입니다. 이 화면에서는 챗봇과 실시간으로 채팅을 할 수 있으며, 가장 많이 묻는 질문들을 확인하거나 자신의 정보를 다른 사용자와 공유하는 기능을 사용할 수 있습니다.'
    },
    {
      'image': 'assets/guide2.jpg',
      'description':
          '메뉴 화면입니다. 여기서 사용자는 설정을 변경하거나, 자주 묻는 질문(FAQ)을 확인하고, 이용안내를 볼 수 있습니다.'
    },
    {
      'image': 'assets/guide3.jpg',
      'description': '로그인 전의 설정창입니다. 로그인을 하면 여러 추가 기능을 설정할 수 있게 됩니다.'
    },
    {
      'image': 'assets/guide4.jpg',
      'description':
          '로그인한 사용자를 위한 설정창입니다. 이 화면에서는 개인정보 변경, 그리팅 메세지 설정, 문의하기, 로그아웃 등의 기능을 사용할 수 있습니다.'
    },
  ];

  @override
  _UsageGuideState createState() => _UsageGuideState();
}

class _UsageGuideState extends State<UsageGuide> {
  final _controller = PageController();
  double _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = screenWidth * 0.1;

    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        color: Colors.white,
        width: screenWidth * UsageGuide.dialogWidthFactor,
        height: screenWidth * UsageGuide.dialogHeightFactor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: buttonWidth * 0.33),
                Icon(
                  Icons.help_outline,
                  color: Color(0xFF2F5B9C),
                  size: UsageGuide.iconSize,
                ),
                SizedBox(width: buttonWidth * 0.33),
                Expanded(
                  child: Text(
                    "FAQ",
                    style: TextStyle(
                      color: Color(0xFF2F5B9C),
                      fontSize: UsageGuide.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                  color: Colors.grey,
                ),
              ],
            ),
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
                  height: screenWidth * 1.3,
                  width: screenWidth * 0.73,
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: UsageGuide.guideList.length,
                    itemBuilder: (context, index) {
                      return Column(children: <Widget>[
                        Container(
                          width: screenWidth * UsageGuide.imageSizeFactor,
                          height: screenWidth * UsageGuide.imageSizeFactor,
                          child: Image.asset(UsageGuide.guideList[index]
                                  ['image'] ??
                              'assets/guide1.jpg'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(UsageGuide.paddingSize),
                          child: Text(
                            UsageGuide.guideList[index]['description'] ??
                                '설명이 없습니다.',
                            style: TextStyle(fontSize: UsageGuide.fontSize),
                          ),
                        ),
                      ]);
                    },
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page.toDouble();
                      });
                    },
                  ),
                ),
              ),
            ),
            Center(
              child: DotsIndicator(
                dotsCount: UsageGuide.guideList.length,
                position: _currentPage.toInt(),
                decorator: DotsDecorator(
                  color: Colors.grey, // Inactive color
                  activeColor: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
