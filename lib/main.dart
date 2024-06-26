import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'menu.dart' as menu;
import 'setting.dart';
import 'reset_password.dart';
import './ExpandableListExample.dart';
import './classExample.dart';
import 'package:http/http.dart' as http;
import 'lists.dart';
import 'package:share/share.dart';
import 'package:flutter/services.dart';
import './BottomSheetMenu.dart';
import 'papago.dart' as papago;
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'provider/searchList.dart';
import 'googleAPI.dart';
import 'serverFunction.dart';

//번역 api 적용시켜야 하는 부분 3가지
//입력창 영어일 경우
//
//영어 -> 한국어 // 서버요청 // 한국어 ->영어

//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
Future<String> translateEnglishToKorean(String text) async {
  try {
    String translatedText = await translateText(text, 'ko');
    print("한국어 번역 $translatedText");
    return translatedText;
  } catch (e) {
    return 'error';
  }
}

Future<String> translateKoreanToEnglish(String text) async {
  print('영어 번역');
  try {
    String translatedText = await translateText(text, 'en');
    return translatedText;
  } catch (e) {
    return 'error';
  }
}

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<SelectionProvider>(
        create: (_) => SelectionProvider(),
      ),
      ChangeNotifierProvider<MainProvider>(
        create: (_) => MainProvider(),
      ),
      ChangeNotifierProvider<ListProvider>(
        create: (_) => ListProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _MyApp(),
    );
  }
}

class _MyApp extends StatelessWidget {
  FocusNode textFocus = FocusNode();
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent, // 맨 밑으로 이동
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  Widget _buildMessageItem(BuildContext context, Message message) {
    Color _unselectedTextColor = Colors.black;
    Color _selectedTextColor = Colors.white;
    void openURL(String url) async {
      print('주소형식 : $url');
      if (url.startsWith('http')) {
        await launchUrlString(url);
      } else {
        print('올바른 주소 형식이 아닙니다: $url');
      }
    }

    String selectedLag = context.read<MainProvider>().language;
    List<String> stringList = message.boxString.split('|');
    List<String> stringListName = message.BoxStringName.split('|');
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            message.isLeft ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (message.isLeft && message.showUserNameAndPhoto ?? false)
            Padding(
              padding: message.text == "안녕하세요! 채팅에 오신 것을 환영합니다."
                  ? const EdgeInsets.only(right: 8.0, top: 12)
                  : const EdgeInsets.only(
                      right: 8.0,
                    ),
              child: Container(
                margin: EdgeInsets.only(left: 8.0),
                width: 38,
                height: 38,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/garam-E.png"),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 0.25, color: Color(0xFF979797)),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            )
          else if (message.isLeft)
            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
              ),
              child: Container(
                margin: EdgeInsets.only(left: 8.0),
                width: 38,
                height: 38,
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(right: 1),
              child: GestureDetector(
                onTap: () {
                  {
                    if (context
                        .read<ListProvider>()
                        .theSelectionList
                        .contains(message.text)) {
                      context
                          .read<ListProvider>()
                          .SelectionRemoveString(message.text.toString());
                    } else {
                      context
                          .read<ListProvider>()
                          .SelectionAddString(message.text.toString());
                    }
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(right: 8.0, top: 0),
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(context
                              .watch<ListProvider>()
                              .theSelectionList
                              .contains(message.text)
                          ? "assets/star2.png"
                          : "assets/star.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          Flexible(
            child: Transform.translate(
              offset: Offset(
                  0,
                  message.showUserNameAndPhoto ?? false
                      ? message.showUserNameAndPhoto ?? false
                          ? message.text == "안녕하세요! 채팅에 오신 것을 환영합니다."
                              ? -10
                              : message.isLeft
                                  ? -25
                                  : -18
                          : 0
                      : -40),
              child: Container(
                margin: message.text == "안녕하세요! 채팅에 오신 것을 환영합니다."
                    ? message.initbox == 0
                        ? EdgeInsets.only(right: 8.0, bottom: 6)
                        : EdgeInsets.only(right: 8.0, bottom: 0)
                    : message.isLeft
                        ? EdgeInsets.only(right: 8.0, bottom: 0)
                        : EdgeInsets.only(right: 8.0, bottom: 10),
                child: Column(
                  crossAxisAlignment: message.isLeft
                      ? CrossAxisAlignment.start
                      : CrossAxisAlignment.end,
                  children: [
                    if (message.isLeft)
                      Text(
                        message.showUserNameAndPhoto ?? false ? "가람이" : "",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECF4FF),
                        borderRadius: message.isLeft
                            ? BorderRadius.only(
                                topRight: const Radius.circular(10),
                                bottomLeft: const Radius.circular(10),
                                bottomRight: const Radius.circular(10),
                              )
                            : BorderRadius.only(
                                topLeft: const Radius.circular(
                                    10), // topRight을 topLeft로 변경
                                bottomLeft: const Radius.circular(10),
                                bottomRight: const Radius.circular(10),
                              ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.text,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          if (message.initbox != 0) SizedBox(height: 8.0),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: List.generate(
                              message.initbox,
                              (index) => GestureDetector(
                                onTap: () async {
                                  // 버튼 클릭 이벤트 처리
                                  //print('버튼 $index 클릭됨');

                                  context.read<MainProvider>().addMessage(
                                      Message(
                                          context
                                                      .read<MainProvider>()
                                                      .language ==
                                                  "ENG"
                                              ? context
                                                  .read<ListProvider>()
                                                  .mainEnglish[index]
                                              : context
                                                  .read<ListProvider>()
                                                  .mainKorean[index],
                                          false,
                                          0,
                                          0,
                                          '',
                                          ''));
                                  // context.read<MainProvider>().addMessage(
                                  //     Message(
                                  //         "$str",
                                  //         true,
                                  //         0,
                                  //         0,
                                  //         context
                                  //             .read<ListProvider>()
                                  //             .mainResponsesUrl[index]
                                  //             .toString(),
                                  //         context
                                  //             .read<ListProvider>()
                                  //             .mainResponsesUrlName[index]
                                  //             .toString()));

                                  String responsebody = "";

                                  responsebody = await postChat(context
                                      .read<ListProvider>()
                                      .mainKorean[index]);

                                  print(responsebody);
                                  Map<String, dynamic> result =
                                      parseResponse(responsebody);
                                  // 결과 출력
                                  print('Answer: ${result['answer']}');
                                  print(
                                      'Button Name: ${result['button_name']}');
                                  print('Link: ${result['link']}');
//응답
                                  String ListString = result['link']
                                      .map((item) => item.toString())
                                      .join('|');
                                  String buttonList = result['button_name']
                                      .map((item) => item.toString())
                                      .join('|');
                                  if (context.read<MainProvider>().language ==
                                      "ENG") {
                                    translateKoreanToEnglish(result['answer'])
                                        .then((translatedText) {
                                      context.read<MainProvider>().addMessage(
                                          Message(translatedText, true, 0, 0,
                                              ListString, buttonList));
                                      _controller.clear();
                                      //스크롤 밑으로 내림
                                      _scrollToBottom();
                                      textFocus.unfocus();
                                    }).catchError((error) {
                                      print('번역 실패: $error');
                                    });
                                  } else {
                                    context.read<MainProvider>().addMessage(
                                        Message(result['answer'], true, 0, 0,
                                            ListString, buttonList));
                                  }
//질문

                                  _controller.clear();
                                  //스크롤 밑으로 내림
                                  _scrollToBottom();
                                  textFocus.unfocus();

                                  //우선 임의로 처리 후에 안에 있는 텍스트 내용을 바탕으로 서버에서 데이터 받아오기
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 8.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    // 텍스트를 중앙에 정렬하는 Center 위젯 추가
                                    child: Text(
                                      selectedLag == "KOR"
                                          ? context
                                              .read<ListProvider>()
                                              .mainKorean[index]
                                          : context
                                              .read<ListProvider>()
                                              .mainEnglish[index],
                                      style: TextStyle(
                                        fontSize: context
                                                    .watch<MainProvider>()
                                                    .language ==
                                                "KOR"
                                            ? 14
                                            : 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  height: 45, // 높이 45
                                  width: 78, // 가로 88
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          if (message.boxString != '')
                            Wrap(
                              spacing: 8.0,
                              runSpacing: 8.0,
                              children: List.generate(
                                stringList.length,
                                (index) => GestureDetector(
                                    onTap: () async {
                                      // 버튼 클릭 이벤트 처리
                                      //print('버튼 $index 클릭됨');
                                      if (stringList[index].contains('http')) {
                                        openURL(stringList[index]);
                                      } else {
                                        context.read<MainProvider>().addMessage(
                                            Message(stringListName[index],
                                                false, 0, 0, '', ''));
                                        String responsebody = "";
                                        print('tae$_controller.text');
                                        if (context
                                                .read<MainProvider>()
                                                .language ==
                                            "ENG") {
                                          translateEnglishToKorean(
                                                  stringListName[index])
                                              .then((translatedText) async {
                                            print('번역내용 : $translatedText');
                                            responsebody =
                                                await postChat(translatedText);
                                          }).catchError((error) {
                                            print('번역 실패: $error');
                                          });
                                        } else {
                                          responsebody = await postChat(
                                              stringListName[index]);
                                        }
                                        print('번역이 필요한 내용$responsebody');
                                        print('번역 끝');
                                        Map<String, dynamic> result =
                                            parseResponse(responsebody);
                                        // 결과 출력
                                        print('Answer: ${result['answer']}');
                                        print(
                                            'Button Name: ${result['button_name']}');
                                        print('Link: ${result['link']}');

                                        if (context
                                                .read<MainProvider>()
                                                .language ==
                                            "ENG") {
                                          translateKoreanToEnglish(
                                                  result['answer'])
                                              .then((translatedText) {
                                            result['answer'] = translatedText;
                                          }).catchError((error) {
                                            print('번역 실패: $error');
                                          });
                                        }
//질문

                                        //응답
                                        String ListString = result['link']
                                            .map((item) => item.toString())
                                            .join('|');
                                        String buttonList =
                                            result['button_name']
                                                .map((item) => item.toString())
                                                .join('|');
                                        context.read<MainProvider>().addMessage(
                                            Message(result['answer'], true, 0,
                                                0, ListString, buttonList));

                                        _controller.clear();
                                        //스크롤 밑으로 내림
                                        _scrollToBottom();
                                        textFocus.unfocus();
                                      }

                                      _scrollToBottom();
                                    },
                                    child: Center(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.0,
                                          vertical: 8.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                          // 텍스트를 중앙에 정렬하는 Center 위젯 추가
                                          child: Text(
                                            (stringList[index].contains('http'))
                                                ? (selectedLag == 'KOR')
                                                    ? stringListName[index]
                                                    : "Going to see more details."
                                                : stringList[index],
                                            style: TextStyle(
                                              fontSize: context
                                                          .watch<MainProvider>()
                                                          .language ==
                                                      "KOR"
                                                  ? 14
                                                  : 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        height: 35, // 높이 45
                                        width: 170, // 가로 88
                                      ),
                                    )),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      message.createdAt != null
                          ? (message.showTimestampAndShareIcon
                              ? message.getCreatedAtString()
                              : "")
                          : '',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (message.isLeft && message.showUserNameAndPhoto ?? false)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  // 여기에 원하는 터치 이벤트 처리 코드를 추가하세요.
                  Share.share(message.text);
                  // 예를 들어, 터치 시 어떤 동작을 수행하거나 화면을 변경하는 등의 로직을 추가할 수 있습니다.
                },
                child: Container(
                  margin: message.text == "안녕하세요! 채팅에 오신 것을 환영합니다."
                      ? EdgeInsets.only(left: 1.0, top: 22)
                      : EdgeInsets.only(left: 1.0, top: 10),
                  width: 20,
                  height: 20,
                  decoration: ShapeDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/share.png"), // share.png로 변경
                      fit: BoxFit.fill,
                    ),
                    shape: RoundedRectangleBorder(),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final double containerHeight = screenHeight;
    final double containerWidth = screenWidth;

    context.read<MainProvider>().startInitState();
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
              width: containerWidth,
              height: containerHeight,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white),
              child: Stack(children: [
                Positioned(
                  left: 0,
                  top: containerHeight * 0.034,
                  child: Container(
                    width: containerWidth,
                    height: 55,
                    //상단바
                    decoration: BoxDecoration(color: Color(0xFF00428B)),
                  ),
                ),
                Positioned(
                  left: containerWidth * 0.28,
                  top: containerHeight * 0.034 + 2,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/gachon_mark.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: containerWidth * 0.38,
                  top: containerHeight * 0.034 + 13,
                  child: SizedBox(
                    width: 109,
                    height: 29,
                    child: Text(
                      context.watch<MainProvider>().language == "KOR"
                          ? "가천대학교"
                          : "Gachon",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            context.watch<MainProvider>().language == "KOR"
                                ? 20
                                : 25,
                        fontFamily: 'Inter',
                        fontWeight:
                            context.watch<MainProvider>().language == "KOR"
                                ? FontWeight.w700
                                : FontWeight.w500,
                        height: context.watch<MainProvider>().language == "KOR"
                            ? 1.30
                            : 0,
                        letterSpacing: -0.52,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: containerHeight * 0.053,
                      left: containerWidth * 0.04),
                  child: GestureDetector(
                    onTap: () {
                      final RenderBox renderBox =
                          context.findRenderObject() as RenderBox;
                      final menuPosition = renderBox.localToGlobal(Offset.zero);

                      showMenu<String>(
                        context: context,
                        position: RelativeRect.fromLTRB(
                          menuPosition.dx,
                          menuPosition.dy + renderBox.size.height * 0.11,
                          menuPosition.dx,
                          menuPosition.dy,
                        ),
                        items: [
                          PopupMenuItem<String>(
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 120),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              color:
                                  context.read<MainProvider>().language == 'KOR'
                                      ? Color(0xFFEDF4FF)
                                      : null,
                              child: Text(
                                'KOR',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 1.53,
                                  letterSpacing: -0.44,
                                ),
                              ),
                            ),
                            value: 'KOR',
                          ),
                          PopupMenuItem<String>(
                            child: Container(
                              constraints: BoxConstraints(maxWidth: 120),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              color:
                                  context.read<MainProvider>().language == 'ENG'
                                      ? Color(0xFFEDF4FF)
                                      : null,
                              child: Text(
                                'ENG',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  height: 1.53,
                                  letterSpacing: -0.44,
                                ),
                              ),
                            ),
                            value: 'ENG',
                          ),
                        ],
                        elevation: 16,
                      ).then((value) {
                        if (value != null) {
                          context
                              .read<MainProvider>()
                              ._setSelectedLanguage(value);
                          context.read<MainProvider>()._setListTitle();
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          context.watch<MainProvider>().language,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 1.53,
                            letterSpacing: -0.44,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  // 메뉴바
                  left: containerWidth * 0.9,
                  top: containerHeight * 0.034 + 10,
                  child: GestureDetector(
                    onTap: () {
                      BottomSheetMenu.show(
                          context,
                          context
                              .read<MainProvider>()
                              ._loginState); // loginState 값을 전달 로그인 시 true & 아닐 시 false
                    },
                    child: Container(
                      width: 35,
                      height: 35,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/menu.png"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //메세지 창
                Positioned(
                  top: containerHeight * 0.034 + 54,
                  left: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: context.watch<MainProvider>().isExpanded
                        ? containerHeight * 0.56
                        : containerHeight * 0.8,
                    color: Colors.white,
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount:
                            context.watch<MainProvider>().messages.length,
                        itemBuilder: (context, index) {
                          Message message =
                              context.watch<MainProvider>().messages[index];
                          return _buildMessageItem(context, message);
                        }),
                  ),
                ),

                //if (context.watch<MainProvider>().inputText == "")
                //즐겨찾기& 실시간 top 메뉴
                Positioned(
                  top: context.watch<MainProvider>().isExpanded
                      ? containerHeight - 78 - 169.78285714
                      : containerHeight - 78, // 원하는 위치로 설정
                  child: GestureDetector(
                    onTap: () {
                      {
                        context.read<MainProvider>().setIsExpanded();
                        _scrollToBottom();
                      }
                    },
                    child: Stack(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: containerWidth,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 235, 237, 238),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '    ${context.watch<MainProvider>().listTitle}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF989898),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 12, // 이미지를 우측으로 이동시킬 위치 조정
                          top: 14, // 이미지를 상단으로 이동시킬 위치 조정
                          child: Image.asset(
                            context.watch<MainProvider>().isExpanded
                                ? 'assets/VectorBottom.png'
                                : 'assets/VectorHigh.png', // 이미지 경로 및 파일명
                            width: 12, // 이미지의 가로 크기 설정
                            height: 7, // 이미지의 세로 크기 설정
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // 즐겨찾기 확장창
                if (context.watch<MainProvider>()._isExpanded)
                  // if (context.watch<MainProvider>()._isExpanded &&
                  //     (context.watch<MainProvider>().inputText == ""))
                  Positioned(
                    top: containerHeight - 42 - 169.78285714, // 조정
                    child: Container(
                      color: Colors.white,
                      width: containerWidth, // 리스트뷰의 너비 지정
                      height: 169.78285714, // 리스트뷰의 높이 지정
                      child: ListView.builder(
                        padding: EdgeInsets.zero, // 상단 여백 제거
                        itemCount:
                            context.watch<MainProvider>().language == "KOR"
                                ? context.watch<MainProvider>().star
                                    ? context
                                        .read<ListProvider>()
                                        .theSelectionList
                                        .length
                                    : context
                                        .read<ListProvider>()
                                        .topQuestionsList
                                        .length
                                : context.watch<MainProvider>().star
                                    ? context
                                        .read<ListProvider>()
                                        .theSelectionListEnglish
                                        .length
                                    : context
                                        .read<ListProvider>()
                                        .topQuestionsListEnglish
                                        .length,
                        itemExtent: 35, // 아이템의 높이 지정
                        itemBuilder: (BuildContext context, int index) {
                          final String itemText =
                              context.watch<MainProvider>().language == "KOR"
                                  ? context.watch<MainProvider>().star
                                      ? context
                                          .read<ListProvider>()
                                          .theSelectionList[index]
                                      : context
                                          .read<ListProvider>()
                                          .topQuestionsList[index]
                                  : context.watch<MainProvider>().star
                                      ? context
                                          .read<ListProvider>()
                                          .theSelectionListEnglish[index]
                                      : context
                                          .read<ListProvider>()
                                          .topQuestionsListEnglish[index];
                          return ListTile(
                            title: Text(
                              itemText,
                              style: TextStyle(fontSize: 14), // 글자 크기 지정
                            ),
                            onTap: () async {
                              context.read<MainProvider>().addMessage(
                                  Message(itemText, false, 0, 0, '', ''));

                              String responsebody = "";
                              print('tae$_controller.text');
                              if (context.read<MainProvider>().language ==
                                  "ENG") {
                                translateEnglishToKorean(itemText)
                                    .then((translatedText) async {
                                  responsebody = await postChat(translatedText);
                                  Map<String, dynamic> result =
                                      parseResponse(responsebody);

                                  translateKoreanToEnglish(result['answer'])
                                      .then((translatedText) {
                                    String ListString = result['link']
                                        .map((item) => item.toString())
                                        .join('|');
                                    String buttonList = result['button_name']
                                        .map((item) => item.toString())
                                        .join('|');
                                    context.read<MainProvider>().addMessage(
                                        Message(translatedText, true, 0, 0,
                                            ListString, buttonList));
                                    _controller.clear();
                                    //스크롤 밑으로 내림
                                    _scrollToBottom();
                                    textFocus.unfocus();
                                    context
                                        .read<MainProvider>()
                                        .setIsExpanded();
                                    _scrollToBottom();
                                  }).catchError((error) {
                                    print('번역 실패: $error');
                                  });
                                }).catchError((error) {
                                  print('번역 실패: $error');
                                });
                                print('tae134$_controller.text');
                              } else {
                                responsebody = await postChat(itemText);
                                Map<String, dynamic> result =
                                    parseResponse(responsebody);
                                String ListString = result['link']
                                    .map((item) => item.toString())
                                    .join('|');
                                String buttonList = result['button_name']
                                    .map((item) => item.toString())
                                    .join('|');
                                context.read<MainProvider>().addMessage(Message(
                                    result['answer'],
                                    true,
                                    0,
                                    0,
                                    ListString,
                                    buttonList));
                                _controller.clear();
                                //스크롤 밑으로 내림
                                _scrollToBottom();
                                textFocus.unfocus();
                                context.read<MainProvider>().setIsExpanded();
                                _scrollToBottom();
                              }

                              //응답
                            },
                          );
                        },
                      ),
                    ),
                  ),
                //자동완선 검색창
                // if (MediaQuery.of(context).viewInsets.bottom != 0)
                // if (context.watch<MainProvider>().inputText.length != 0)
                Positioned(
                  top: containerHeight - 42 - 169.78285714,
                  child: Container(
                    color: Colors.white,
                    width: containerWidth, // 리스트뷰의 너비 지정
                    height: (_controller.text.length != 0)
                        ? containerHeight * 0.24
                        : 0, // 리스트뷰의 높이 지정
                    child: ListView.builder(
                      padding: EdgeInsets.zero, // 상단 여백 제거
                      itemCount:
                          (context.watch<MainProvider>().language == "KOR"
                                  ? suggestionsKor
                                  : suggestionsEng)
                              .where((item) => item.contains(
                                  context.watch<MainProvider>().inputText))
                              .toList()
                              .length,

                      itemExtent: 35, // 아이템의 높이 지정
                      itemBuilder: (BuildContext context, int index) {
                        final String itemText =
                            (context.watch<MainProvider>().language == "KOR"
                                    ? suggestionsKor
                                    : suggestionsEng)
                                .where((item) => item.contains(
                                    context.watch<MainProvider>().inputText))
                                .toList()[index];
                        if (_controller.text.length != 0)
                          return ListTile(
                            title: Text(
                              itemText,
                              style: TextStyle(fontSize: 14), // 글자 크기 지정
                            ),
                            onTap: () async {
                              context.read<MainProvider>().addMessage(
                                  Message(itemText, false, 0, 0, '', ''));

                              String responsebody = "";
                              print('tae$_controller.text');
                              if (context.read<MainProvider>().language ==
                                  "ENG") {
                                translateEnglishToKorean(itemText)
                                    .then((translatedText) async {
                                  responsebody = await postChat(translatedText);
                                  Map<String, dynamic> result =
                                      parseResponse(responsebody);

                                  translateKoreanToEnglish(result['answer'])
                                      .then((translatedText) {
                                    String ListString = result['link']
                                        .map((item) => item.toString())
                                        .join('|');
                                    String buttonList = result['button_name']
                                        .map((item) => item.toString())
                                        .join('|');
                                    context.read<MainProvider>().addMessage(
                                        Message(translatedText, true, 0, 0,
                                            ListString, buttonList));
                                    _controller.clear();
                                    //스크롤 밑으로 내림
                                    _scrollToBottom();
                                    textFocus.unfocus();
                                    _controller.text = '';
                                    _scrollToBottom();
                                    textFocus.unfocus();
                                  }).catchError((error) {
                                    print('번역 실패: $error');
                                  });
                                }).catchError((error) {
                                  print('번역 실패: $error');
                                });
                                print('tae134$_controller.text');
                                _controller.clear();
                                //스크롤 밑으로 내림
                                _scrollToBottom();
                                textFocus.unfocus();
                                _controller.text = '';
                                _scrollToBottom();
                                textFocus.unfocus();
                              } else {
                                responsebody = await postChat(itemText);
                                Map<String, dynamic> result =
                                    parseResponse(responsebody);
                                String ListString = result['link']
                                    .map((item) => item.toString())
                                    .join('|');
                                String buttonList = result['button_name']
                                    .map((item) => item.toString())
                                    .join('|');
                                context.read<MainProvider>().addMessage(Message(
                                    result['answer'],
                                    true,
                                    0,
                                    0,
                                    ListString,
                                    buttonList));
                                _controller.clear();
                                //스크롤 밑으로 내림
                                _scrollToBottom();
                                textFocus.unfocus();
                                _controller.text = '';
                                _scrollToBottom();
                                textFocus.unfocus();
                              }
                            },
                          );
                      },
                    ),
                  ),
                ),

                Positioned(
                  top: containerHeight - 42,
                  left: 0,
                  child: Container(
                    width: containerWidth,
                    height: 42,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 3.0, vertical: 2),
                            color: Color(0xFFE2E4E5),
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 40,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 1),
                                    child: InkWell(
                                      onTap: () {
                                        // 버튼이 눌렸을 때 수행할 작업을 여기에 작성하세요.
                                        {
                                          context
                                              .read<MainProvider>()
                                              .initState();
                                        }
                                        ;
                                        _scrollToBottom();
                                      },
                                      child: Image.asset('assets/home.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                Container(
                                  width: containerWidth * 0.8,
                                  height: 30,
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 1),
                                    child: TextField(
                                      focusNode: textFocus,
                                      controller: _controller,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 12.0),
                                        hintText: context
                                                    .watch<MainProvider>()
                                                    .language ==
                                                "KOR"
                                            ? "질문을 입력하세요"
                                            : "Please enter a question",
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        fillColor: Colors.white,
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: BorderSide(
                                              width: 0.8,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: BorderSide(
                                              width: 0.15,
                                              color: Color(0xFFBEBEBE)),
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () async {
                                            if (_controller.text.isNotEmpty) {
                                              context
                                                  .read<MainProvider>()
                                                  .addMessage(Message(
                                                      _controller.text,
                                                      false,
                                                      0,
                                                      0,
                                                      '',
                                                      ''));

                                              String responsebody = "";
                                              print('tae$_controller.text');
                                              if (context
                                                      .read<MainProvider>()
                                                      .language ==
                                                  "ENG") {
                                                translateEnglishToKorean(
                                                        _controller.text)
                                                    .then(
                                                        (translatedText) async {
                                                  responsebody = await postChat(
                                                      translatedText);
                                                  Map<String, dynamic> result =
                                                      parseResponse(
                                                          responsebody);

                                                  translateKoreanToEnglish(
                                                          result['answer'])
                                                      .then((translatedText) {
                                                    String ListString =
                                                        result['link']
                                                            .map((item) =>
                                                                item.toString())
                                                            .join('|');
                                                    String buttonList =
                                                        result['button_name']
                                                            .map((item) =>
                                                                item.toString())
                                                            .join('|');
                                                    context
                                                        .read<MainProvider>()
                                                        .addMessage(Message(
                                                            translatedText,
                                                            true,
                                                            0,
                                                            0,
                                                            ListString,
                                                            buttonList));
                                                    _controller.clear();
                                                    //스크롤 밑으로 내림
                                                    _scrollToBottom();
                                                    textFocus.unfocus();
                                                    context
                                                        .read<MainProvider>()
                                                        .setIsExpanded();
                                                    _scrollToBottom();
                                                  }).catchError((error) {
                                                    print('번역 실패: $error');
                                                  });
                                                }).catchError((error) {
                                                  print('번역 실패: $error');
                                                });
                                                print(
                                                    'tae134$_controller.text');
                                              } else {
                                                responsebody = await postChat(
                                                    _controller.text);
                                                Map<String, dynamic> result =
                                                    parseResponse(responsebody);
                                                String ListString =
                                                    result['link']
                                                        .map((item) =>
                                                            item.toString())
                                                        .join('|');
                                                String buttonList =
                                                    result['button_name']
                                                        .map((item) =>
                                                            item.toString())
                                                        .join('|');
                                                context
                                                    .read<MainProvider>()
                                                    .addMessage(Message(
                                                        result['answer'],
                                                        true,
                                                        0,
                                                        0,
                                                        ListString,
                                                        buttonList));
                                                _controller.clear();
                                                //스크롤 밑으로 내림
                                                _scrollToBottom();
                                                textFocus.unfocus();
                                                context
                                                    .read<MainProvider>()
                                                    .setIsExpanded();
                                                _scrollToBottom();
                                              }
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Transform.translate(
                                              offset: Offset(5,
                                                  0), // 원하는 xOffset 및 yOffset 값으로 변경합니다.
                                              child: Icon(
                                                Icons.send, // 원하는 아이콘으로 변경하세요.
                                                color: const Color.fromARGB(
                                                    255, 1, 86, 156),
                                                size: 24, // 원하는 크기로 변경하세요.
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      onChanged: (text) {
                                        // 입력 값이 변경될 때 수행할 작업을 여기에 작성하세요.

                                        context
                                            .read<MainProvider>()
                                            .setInputText(text);

                                        // _controller.text = text; //역으로 입력
                                      },
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 7.0),
                                    InkWell(
                                      onTap: (context
                                          .read<MainProvider>()
                                          ._toggleStar),
                                      child: AnimatedCrossFade(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        firstChild: Transform.scale(
                                          scale: context
                                                  .watch<MainProvider>()
                                                  ._isStarSelected
                                              ? 1
                                              : 1,
                                          child: SizedBox(
                                            width: 28,
                                            height: 28,
                                            child: Image.asset(
                                              "assets/star.png",
                                            ),
                                          ),
                                        ),
                                        secondChild: Transform.scale(
                                          scale: context
                                                  .watch<MainProvider>()
                                                  ._isStarSelected
                                              ? 1
                                              : 1,
                                          child: SizedBox(
                                            width: 28,
                                            height: 28,
                                            child: Image.asset(
                                              "assets/star2.png",
                                            ),
                                          ),
                                        ),
                                        crossFadeState: context
                                                .watch<MainProvider>()
                                                ._isStarSelected
                                            ? CrossFadeState.showSecond
                                            : CrossFadeState.showFirst,
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
                ),
              ])),
        ])));
  }
}

class MainProvider with ChangeNotifier {
  String _inputText = '';
  String get inputText => _inputText;
  void setInputText(String input) {
    _inputText = input;
    notifyListeners();
  }

  // 입력창 위에 보여줄 자동완성 목록
  bool _loginState = false;

  bool get getLoginState => _loginState;
  void setLogin(bool _state) {
    _loginState = !_state;
    notifyListeners();
  }

  String _accessToken = '';
  String get AToken => _accessToken;
  void setAToken(String token) {
    _accessToken = token;
    notifyListeners();
  }

  String _refreshToken = '';
  String get RToken => _refreshToken;
  void setRToken(String token) {
    _refreshToken = token;
    notifyListeners();
  }

  bool _isExpanded = false; // Define the _isExpanded variable
  bool get isExpanded => _isExpanded;
  void setIsExpanded() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }

  String listTitle = '실시간 TOP 질문';
  String get title => listTitle;
  bool _isStarSelected = false;
  bool get star => _isStarSelected;
  void _toggleStar() {
    _isStarSelected = !_isStarSelected;
    _setListTitle();
    notifyListeners();
  }

  bool showAutocompleteButton = false;
  String _selectedLanguage = 'KOR';
  String get language => _selectedLanguage;

  List<Message> _messages = [];
  List<Message> get messages => _messages;

  void addMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  void serverSendMessage(Message message) {
    _messages.add(message);
    //여기에 서버 응답에 대한 내용을 추가
    _messages.add(message);
    notifyListeners();
  }

  MyApp myAppInstance = MyApp();

  void initState() {
    // 초기 메시지 설정
    if (language == "KOR") {
      addMessage(Message(
          "안녕하세요! 채팅에 오신 것을 환영합니다.",
          true,
          0,
          0,
          '',
          showTimestampAndShareIcon: false,
          ''));
      addMessage(Message(
          "안녕하세요! 채팅에 오신 것을 환영합니다.",
          true,
          9,
          0,
          '',
          showUserNameAndPhoto: false,
          ''));
    } else {
      addMessage(Message(
          "Hello! Welcome to the chat.",
          true,
          0,
          0,
          '',
          showTimestampAndShareIcon: false,
          ''));
      addMessage(Message(
          "Hello! Welcome to the chat.",
          true,
          9,
          0,
          '',
          showUserNameAndPhoto: false,
          ''));
    }
  }

  bool isInitialized = false;

  void startInitState() {
    if (language == "KOR") {
      if (!isInitialized) {
        _messages.add(Message(
            "안녕하세요! 채팅에 오신 것을 환영합니다.",
            true,
            0,
            0,
            '',
            showTimestampAndShareIcon: false,
            ''));
        _messages.add(Message(
            "안녕하세요! 채팅에 오신 것을 환영합니다.",
            true,
            9,
            0,
            '',
            showUserNameAndPhoto: false,
            ''));
        isInitialized = true;
      }
    } else {
      if (!isInitialized) {
        _messages.add(Message(
            "Hello! Welcome to the chat.",
            true,
            0,
            0,
            '',
            showTimestampAndShareIcon: false,
            ''));
        _messages.add(Message(
            "Hello! Welcome to the chat.",
            true,
            9,
            0,
            '',
            showUserNameAndPhoto: false,
            ''));
        isInitialized = true;
      }
    }
  }

  void _setListTitle() {
    if (_selectedLanguage == 'KOR') {
      listTitle = _isStarSelected ? '즐겨찾기' : '실시간 TOP 질문';
    } else {
      listTitle = _isStarSelected ? 'Bookmark' : 'Top real-time questions';
    }
  }

  void _setSelectedLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }

  void _sendMessage(String text, bool isLeft,
      {int box = 0,
      bool showTimestampAndShareIcon = true,
      bool showUserNameAndPhoto = true}) {
    _messages.add(Message(
        text,
        isLeft,
        box,
        0,
        '',
        showTimestampAndShareIcon: showTimestampAndShareIcon,
        showUserNameAndPhoto: showUserNameAndPhoto,
        ''));
    //myAppInstance._scrollToBottom();
    notifyListeners();
  }
}

class ListProvider with ChangeNotifier {
  // ++여기 인덱스를 하나의 질문에 대한 하나의 인덱스를 가지게 설정
  List<String> mainResponsesUrlName = [
    '자세한 내용 보러가기|알빠노',
    '자세한 내용 보러가기',
    '',
    '',
    '자세한 내용 보러가기',
    '',
    '',
    '자세한 내용 보러가기',
    '',
  ];
  List<String> mainResponsesUrl = [
    'https://www.gachon.ac.kr/kor/1148/subview.do|알빠노',
    'https://www.gachon.ac.kr/kor/1148/subview.do',
    '',
    '',
    'https://www.gachon.ac.kr/kor/1156/subview.do',
    '',
    '',
    'https://www.gachon.ac.kr/kor/1075/subview.do',
    '',
  ];
  List<String> mainEnglishResponse = [
    'Club',
    '''I'll tell you about the employment notice.
- Information on recruiting additional overseas internship (Australia) students for the semester 2024-1 (re-application for students who fail the screening is possible)
-2023-List of companies participating in short-term field training in winter (4th) (Application period: ~12.17)
-Information on the closing of application for the Jump-up Project Allowance for 2023
-Information on the schedule of the Gachon University Job Plus Center (employment career center) program in December 2023
-2023-Winter (short-term) field training semester system implementation guide (+extended document submission deadline)''',
    '''The shaman will tell you about the information.

◆ Operation Overview
- Operating hours: 08:30 to 17:30
- Dispatch interval: 10 minutes
- IT Convergence University → Student Life Center, Student Life Center → IT Convergence University Starts at the same time
- Route:
· IT Convergence University → Graduate School of Education → Student Center → Student Living Center
· Student Living Center → Student Center → Central Library → College of Arts and Sports 1 → Global Center → IT Convergence University
◆ Other matters
-12:00 to 13:00: Business hours
-08:30 to 09:00 : Additional bus input elasticity operation depending on the situation
- Non-operating during vacation or rainy weather ''',
    '''The menu at the cafeteria is different for each student.
Can you choose the restaurant you want to know?''',
    '''Let me tell you about the library.

Gachon University Library consists of Global Campus Central Library, Electronic Information Library, and Medical Campus Central Library.
Find more information on our website!''',
    'Lecture',
    'University Graduate',
    '''I'll let you know about my academic schedule.

-11.24 to 12.21 P - Working Project (4 weeks)
-12.08 to 12.14 Final exams
-12.15 to 12.21 reinforcement period
-12.18 to 12.29 Re-entry application period
-12.22~02.29 Unregistered leave of absence period
-12.22 Winter vacation
-12.26~12.28 Report and correction
''',
    '''Let me introduce Garam.

🤖"Garam" is a combination of Gachon University and the school's symbol, the pinwheel, and means Gachon University's only chatbot.

Garam's Whale 🐳 character symbolizes freedom in clear water and features a gachon pinwheel in the form of a water fountain above the head.''',
  ];
  List<String> mainKoreanResponse = [
    '동아리',
    '''취업공지에 대해 알려드릴게요.
-2024-1학기 해외인턴십(호주) 학생 추가 모집 안내(심사 탈락학생 재지원 가능)
-2023-동계 단기 현장실습 참여 기업 리스트(4차)( 모집기한 : ~12.17)
-2023년도 점프업 프로젝트 수당신청 마감 안내
-2023년 12월 가천대 일자리플러스센터(취업진로처) 프로그램 일정 안내
-2023-동계(단기)현장실습학기제 시행 안내(+서류 제출 기한 연장)''',
    '''무당이 정보에 관해 알려드릴게요.

◆ 운영개요
- 운영시간 : 08:30 ~ 17:30
- 배차간격 : 10분
- IT융합대학 → 학생생활관, 학생생활관 → IT융합대학 동시출발
- 노선 :
· IT융합대학 → 교육대학원 → 학생회관 → 학생생활관
· 학생생활관 → 학생회관 → 중앙도서관 → 예술·체육대학1 →글로벌센터 → IT융합대학
◆ 기타사항
-12:00 ~ 13:00 : 운휴시간
-08:30 ~ 09:00 : 상황에 따라 추가버스 투입 탄력 운영
-방학, 우천시 미운영''',
    '''학식 메뉴는 학생식당마다 달라요.
알고 싶은 식당을 선택해줄래요?''',
    '''도서관에 대해 알려드릴게요.
    
가천대학교 도서관은 글로벌캠퍼스 중앙도서관, 전자정보도서관, 메디컬캠퍼스 중앙도서관으로 구성되어 있어요.
홈페이지에서 더 자세한 정보를 찾아보세요!''',
    '''바이오나노대학은 나노과학기술을 물리, 화학, 바이오, 생명과학 그리고 식품생명공학 및 영양학 분야에 적용하여 미래사회의 에너지, 전기전자, 재료, 환경, 의료, 식품분야에서 기술적 혁신을 도모하는 전문지식 배양과 인류의 지적자산에 기여할 수 있는 실무 연구능력을 양성하는 데에 교육목표를 둔다. 산업과 과학기술분야의 토대가 되는 창조적이고 폭 넓은 과학기술 인력을 양성함과 동시에 미래형 최첨단 학문의 전문가를 양성하기 위해 본 대학에서는 물리, 화학, 바이오나노, 생명과학 그리고 식품생명공학 및 영양학분야를 바탕으로 융합 교육과정을 구축하고 있다.

위치: 예술·체육대학1
☎ 031-750-5381''',
    '''대학 대학원''',
    '''학사일정에 대해 알려드릴게요.
    
-11.24 ~ 12.21 P-실무프로젝트(4주)
-12.08 ~ 12.14 기말고사
-12.15 ~ 12.21 보강기간
-12.18 ~ 12.29 재입학 신청기간
-12.22 ~ 02.29 미등록 휴학기간
-12.22	동계방학
-12.26 ~ 12.28 성적공시 및 정정''',
    '''가람이에 대해 소개해드릴게요.

🤖”가람이”는 가천대학교와 학교 상징인 바람개비의 합성어로 가천대학교 유일무이의 챗봇을 의미합니다.

가람이의 고래🐳 캐릭터는 맑은 물에서의 자유로움을 상징으로 하며 머리 위 물분수의 형태를 가천 바람개비로 하는 것이 가람이만의 특징입니다.''',
  ];
  List<String> mainEnglish = [
    'Club',
    'Job Posting',
    'mudang-i',
    'Campus menu',
    'Library',
    'Lecture',
    'University Graduate',
    'Calendar',
    'Garame ?',
  ];
  List<String> mainKorean = [
    '동아리',
    '채용공고',
    '무당이',
    '학식',
    '도서관',
    '강의',
    '대학교',
    '학사일정',
    '가람이',
  ];
  List<String> topQuestionsListEnglish = [
    '1. How can I apply for a scholarship?',
    "2. Please provide the contact information for the university's support team",
    '3.',
    '4.',
    '5.',
    '6.',
    '7.',
    '8.',
    '9.',
    '10.',
  ];
  List<String> theSelectionListEnglish = [
    '1. ',
    '2. ',
    '3.',
    '4.',
    '5.',
    '6.',
    '7.',
    '8.',
    '9.',
    '10.',
  ];
  void SelectionAddStringEnglish(String str) {
    theSelectionListEnglish.add(str);
    notifyListeners();
  }

  void SelectionRemoveStringEnglish(String str) {
    theSelectionListEnglish.remove(str);
    notifyListeners();
  }

  void QuestionAddStringEnglish(String str) {
    topQuestionsListEnglish.add(str);
    notifyListeners();
  }

  void QuestionRemoveStringEnglish(String str) {
    topQuestionsListEnglish.remove(str);
    notifyListeners();
  }

  List<String> topQuestionsList = [
    '1. 장학금 신청을 하려면 어떻게 하나요?',
    '2. 대학별 교학지원팀 연락처 알려주세요',
    '질문 3',
    '질문 4',
    '질문 5',
    '질문 6',
    '질문 7',
    '질문 8',
    '질문 9',
    '질문 10',
  ];
  List<String> theSelectionList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];
  void SelectionAddString(String str) {
    theSelectionList.add(str);
    notifyListeners();
  }

  void SelectionRemoveString(String str) {
    theSelectionList.remove(str);
    notifyListeners();
  }

  void QuestionAddString(String str) {
    topQuestionsList.add(str);
    notifyListeners();
  }

  void QuestionRemoveString(String str) {
    topQuestionsList.remove(str);
    notifyListeners();
  }
}
