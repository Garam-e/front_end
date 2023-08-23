import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class setting extends StatelessWidget {
  const setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double buttonWidth = screenWidth * 0.83;
    bool isButtonClicked = false; // 버튼 클릭 여부를 나타내는 변수

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 140, // 원하는 위치 조정
            child: Text(
              "가람이 (Garam-e)",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                fontFamily: 'Inter',
              ),
            ),
          ),
          Positioned(
            top: 190, // 원하는 위치 조정
            child: Image.asset(
              'assets/logo_gachon.png', // 이미지 파일 경로
              width: 99, // 이미지 너비 조정
              height: 98, // 이미지 높이 조정
            ),
          ),
          Positioned(
            top: 333, // 원하는 위치 조정
            child: Text.rich(
              TextSpan(
                text: '김밤비 ',
                style: TextStyle(
                  color: Color(0xFF2F5B9C),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '님',
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 500,
            child: ElevatedButton(
              onPressed: () {
                TextEditingController _passwordController =
                    TextEditingController(); // 비밀번호 입력 컨트롤러 선언

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.zero,
                      content: Container(
                        width: screenWidth * 0.8,
                        height: screenWidth * 0.5,
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // 세로 중앙 정렬
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // 가로 중앙 정렬
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 15),
                                Container(
                                  alignment:
                                      Alignment.centerLeft, // 이미지를 왼쪽에 정렬
                                  child: Image.asset(
                                    'assets/edit.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center, // 텍스트를 중앙에 정렬
                                    child: Text(
                                      "비밀번호 입력",
                                      style: TextStyle(
                                        color: Color(0xFF2F5B9C),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Container(
                                  alignment:
                                      Alignment.centerRight, // 아이콘을 오른쪽에 정렬
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close),
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5), // 제목과 내용 사이 간격
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 15),
                                Expanded(
                                  child: Container(
                                    alignment:
                                        Alignment.centerLeft, // 텍스트를 중앙에 정렬
                                    child: Text(
                                      "비밀번호",
                                      style: TextStyle(
                                        color: Color(0xFF2F5B9C),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5), // 내용과 입력 필드 사이 간격

                            Container(
                              width: buttonWidth * 0.88,
                              height: 30,
                              child: TextField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),

                            // 확인 버튼
                            ElevatedButton(
                              onPressed: () {
                                String enteredPassword =
                                    _passwordController.text;

                                // 입력한 비밀번호가 올바른지 확인
                                if (enteredPassword == "1234") {
                                  Navigator.pop(context); // 비밀번호 다이얼로그 닫기
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      TextEditingController
                                          _nicknameController =
                                          TextEditingController();
                                      TextEditingController
                                          _passwordController =
                                          TextEditingController();
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.zero,
                                        content: Container(
                                          width: screenWidth * 0.8,
                                          height: screenWidth * 0.6,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(width: 15),
                                                  Container(
                                                    alignment: Alignment
                                                        .centerLeft, // 이미지를 왼쪽에 정렬
                                                    child: Image.asset(
                                                      'assets/edit.png',
                                                      width: 20,
                                                      height: 20,
                                                    ),
                                                  ),
                                                  SizedBox(width: 15),
                                                  Expanded(
                                                    child: Container(
                                                      alignment: Alignment
                                                          .center, // 텍스트를 중앙에 정렬
                                                      child: Text(
                                                        "정보 변경",
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF2F5B9C),
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 15),
                                                  Container(
                                                    alignment: Alignment
                                                        .centerRight, // 아이콘을 오른쪽에 정렬
                                                    child: IconButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icon(Icons.close),
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15),
                                                    child: Text(
                                                      "닉네임",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF2F5B9C),
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                width: screenWidth * 0.73,
                                                height: 30,
                                                child: TextField(
                                                  controller:
                                                      _nicknameController,
                                                  decoration: InputDecoration(
                                                    hintText: "김밤비",
                                                    hintStyle: TextStyle(
                                                        color:
                                                            Color(0xFFACACBC)),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8,
                                                            horizontal: 12),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 15),
                                                    child: Text(
                                                      "비밀번호",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF2F5B9C),
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                width: screenWidth * 0.73,
                                                height: 30,
                                                child: TextField(
                                                  controller:
                                                      _passwordController,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 8,
                                                            horizontal: 12),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 15),
                                              ElevatedButton(
                                                onPressed: () {
                                                  String newNickname =
                                                      _nicknameController.text;
                                                  // TODO: 새 닉네임을 처리하는 로직 추가
                                                  Navigator.pop(context);
                                                },
                                                child: Text("확인"),
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 50),
                                                  primary: Color(0xFF2F5B9C),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  // 비밀번호가 틀렸을 경우, 사용자에게 에러 메시지 표시
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("비밀번호가 올바르지 않습니다.")),
                                  );
                                }
                              },
                              child: Text("확인"),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                primary: Color(0xFF2F5B9C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(width: 1, color: Color(0xFF505050)),
                ),
                elevation: 0,
                minimumSize: Size(buttonWidth, 35),
              ),
              child: Container(
                width: buttonWidth,
                height: 40,
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/edit.png',
                      width: 18,
                      height: 18,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '정보 변경',
                          style:
                              TextStyle(color: Color(0xFF2F5B9C), fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 570,
            child: Stack(
              children: [
                ElevatedButton(
                  onPressed: () {
                    int selectedCount = 0;

                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        var selectionProvider =
                            context.read<SelectionProvider>();
                        var selectedItems = List.generate(
                          10,
                          (index) => selectionProvider.isSelected(index),
                        );

                        return StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            return AlertDialog(
                              contentPadding: EdgeInsets.zero,
                              content: Container(
                                width: buttonWidth,
                                height: 450,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 15),
                                        Image.asset(
                                          'assets/speaker_notes.png',
                                          width: 20,
                                          height: 20,
                                        ),
                                        SizedBox(width: buttonWidth * 0.145),
                                        Expanded(
                                          child: Text(
                                            "그리팅 메시지 설정 ($selectedCount/5)",
                                            style: TextStyle(
                                              color: Color(0xFF505050),
                                              fontSize: 16,
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
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 0,
                                          vertical: 0,
                                        ),
                                        child: SizedBox(
                                          height: 380, // 리스트뷰 높이 조절
                                          width: screenWidth * 0.75,
                                          child: ListView.separated(
                                            itemCount: 10,
                                            separatorBuilder:
                                                (context, index) => Divider(
                                              color:
                                                  Color(0xFFBEBEBE), // 구분선 색상
                                            ),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              String itemName = '';
                                              switch (index) {
                                                case 0:
                                                  itemName = '공지사항';
                                                  break;
                                                case 1:
                                                  itemName = '학사일정';
                                                  break;
                                                case 2:
                                                  itemName = '오늘의 날씨';
                                                  break;
                                                case 3:
                                                  itemName = '학식 메뉴';
                                                  break;
                                                default:
                                                  itemName = '~~~~~~~~~~~';
                                                  break;
                                              }

                                              return Container(
                                                height: 50,
                                                child: ListTile(
                                                  trailing: Checkbox(
                                                    value: selectedItems[index],
                                                    onChanged: (value) {
                                                      if (selectedCount < 5 ||
                                                          selectedItems[
                                                              index]) {
                                                        selectionProvider
                                                            .toggleSelection(
                                                                index);
                                                        setState(() {
                                                          selectedItems =
                                                              List.generate(
                                                            10,
                                                            (index) =>
                                                                selectionProvider
                                                                    .isSelected(
                                                                        index),
                                                          );
                                                          selectedCount =
                                                              selectedItems
                                                                  .where((selected) =>
                                                                      selected)
                                                                  .length;
                                                        });
                                                      } else {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                            title: Text("경고"),
                                                            content: Text(
                                                                "최대 5개까지만 선택할 수 있습니다."),
                                                            actions: [
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Text("확인"),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  title: GestureDetector(
                                                    onTap: () {
                                                      if (!isButtonClicked) {
                                                        selectionProvider
                                                            .toggleSelection(
                                                                index);
                                                        setState(() {
                                                          selectedItems =
                                                              List.generate(
                                                            10,
                                                            (index) =>
                                                                selectionProvider
                                                                    .isSelected(
                                                                        index),
                                                          );
                                                          selectedCount =
                                                              selectedItems
                                                                  .where((selected) =>
                                                                      selected)
                                                                  .length;
                                                        });
                                                      }
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SizedBox(width: 8),
                                                        Text(itemName),
                                                      ],
                                                    ),
                                                  ),
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
                  },
                  style: ElevatedButton.styleFrom(
                    primary: isButtonClicked ? Color(0xFF000000) : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                        width: 1,
                        color: Color(0xFF505050),
                      ),
                    ),
                    elevation: 0,
                    minimumSize: Size(buttonWidth, 35),
                  ),
                  child: Container(
                    width: buttonWidth,
                    height: 40,
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/speaker_notes.png',
                          width: 18,
                          height: 18,
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '그리팅 메세지 설정',
                              style: TextStyle(
                                color: isButtonClicked
                                    ? Color(0xFF000000)
                                    : Color(0xFF2F5B9C),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 640,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    TextEditingController _inquiryTitleEditingController =
                        TextEditingController();

                    TextEditingController _inquiryDetailEditingController =
                        TextEditingController();

                    return AlertDialog(
                      contentPadding: EdgeInsets.zero, // 내용 영역 패딩 제거
                      content: Container(
                        width: 400, // 원하는 가로 크기 설정
                        height: 480, // 원하는 세로 크기 설정
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 15),
                                Container(
                                  alignment:
                                      Alignment.centerLeft, // 이미지를 왼쪽에 정렬
                                  child: Image.asset(
                                    'assets/headset_mic.png', // 이미지 파일 경로
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center, // 텍스트를 중앙에 정렬
                                    child: Text(
                                      "문의",
                                      style: TextStyle(
                                          color: Color(0xFF2F5B9C),
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Container(
                                  alignment:
                                      Alignment.centerRight, // 아이콘을 오른쪽에 정렬
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close),
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10), // 제목과 내용 사이 간격
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15), // 왼쪽 여백 설정
                                  child: Text(
                                    "문의 제목",
                                    style: TextStyle(
                                      color: Color(0xFF2F5B9C),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 300, // 원하는 가로 크기 설정
                              height: 35,
                              child: TextField(
                                controller: _inquiryTitleEditingController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 12),
                                ),
                              ),
                            ),
                            SizedBox(height: 20), // 위 아래 간격 조절
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 15), // 왼쪽 여백 설정
                                  child: Text(
                                    "문의 내용",
                                    style: TextStyle(
                                      color: Color(0xFF2F5B9C),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 300, // 원하는 가로 크기 설정
                              height: 250, // 원하는 세로 크기 설정
                              child: TextField(
                                controller: _inquiryDetailEditingController,
                                maxLines: 250,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 12,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                String newNickname =
                                    _inquiryDetailEditingController.text;
                                // TODO: 새 닉네임을 처리하는 로직 추가
                                Navigator.pop(context);
                              },
                              child: Text("확인"),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50), // 좌우 여백 조절
                                primary: Color(0xFF2F5B9C), // 색상 변경
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(width: 1, color: Color(0xFF505050)),
                ),
                elevation: 0,
                minimumSize: Size(buttonWidth, 35), // 버튼의 최소 크기 지정
              ),
              child: Container(
                width: buttonWidth,
                height: 40,
                padding: EdgeInsets.symmetric(vertical: 5), // 높이 조정
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/headset_mic.png',
                      width: 18,
                      height: 18,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '문의',
                          style:
                              TextStyle(color: Color(0xFF2F5B9C), fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 700,
            right: screenWidth * 0.04,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 0,
              ),
              child: Container(
                width: buttonWidth - 250,
                height: 20,
                padding: EdgeInsets.symmetric(vertical: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/logout.png',
                      width: 18,
                      height: 18,
                    ),
                    SizedBox(width: 10),
                    Padding(
                      padding: EdgeInsets.only(right: buttonWidth * 0.008),
                      child: Text(
                        '로그아웃',
                        style:
                            TextStyle(color: Color(0xFFF66767), fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Provider 클래스 생성
class SelectionProvider with ChangeNotifier {
  List<bool> _selections =
      List.generate(10, (index) => false); // 초기 상태: 선택되지 않음

  // 해당 인덱스의 선택 상태 반환
  bool isSelected(int index) => _selections[index];

  // 해당 인덱스의 선택 상태 토글
  void toggleSelection(int index) {
    _selections[index] = !_selections[index];
    notifyListeners();
  }
}
