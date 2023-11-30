import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
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
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  Widget _buildMessageItem(BuildContext context, Message message) {
    Color _unselectedTextColor = Colors.black;
    Color _selectedTextColor = Colors.white;
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
                    ? message.box == 0
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
                          if (message.box != 0) SizedBox(height: 8.0),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: List.generate(
                              message.box,
                              (index) => GestureDetector(
                                onTap: () {
                                  // 버튼 클릭 이벤트 처리
                                  //print('버튼 $index 클릭됨');
                                  context.read<MainProvider>().addMessage(
                                      Message("버튼 $index 클릭됨", true, 0));

                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent, // 맨 밑으로 이동
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                    );
                                  });
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
                                  child: Text(
                                    '버튼 $index',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  height: 45, // 높이 45
                                  width: 78, // 가로 88
                                ),
                              ),
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
                Positioned(
                  top: context.watch<MainProvider>().isExpanded
                      ? containerHeight * 0.65
                      : containerHeight * 0.89, // 원하는 위치로 설정
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
                          height: 35,
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
                if (context.watch<MainProvider>()._isExpanded)
                  Positioned(
                    top: containerHeight * 0.699,
                    child: Container(
                      color: Colors.white,
                      width: containerWidth, // 리스트뷰의 너비 지정
                      height: containerHeight * 0.24, // 리스트뷰의 높이 지정
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
                            onTap: () {
                              context
                                  .read<MainProvider>()
                                  .addMessage(Message(itemText, false, 0));
                              context.read<MainProvider>().setIsExpanded();
                              _scrollToBottom();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                Positioned(
                  top: containerHeight * 0.94,
                  left: 0,
                  child: Container(
                    width: containerWidth,
                    height: containerHeight * 0.5,
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
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          _scrollController.animateTo(
                                            _scrollController.position
                                                .maxScrollExtent, // 맨 밑으로 이동
                                            duration:
                                                Duration(milliseconds: 200),
                                            curve: Curves.easeInOut,
                                          );
                                        });
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
                                          onTap: () {
                                            if (_controller.text.isNotEmpty) {
                                              context
                                                  .read<MainProvider>()
                                                  .addMessage(Message(
                                                      _controller.text,
                                                      false,
                                                      0));
                                              WidgetsBinding.instance
                                                  .addPostFrameCallback((_) {
                                                _scrollController.animateTo(
                                                  _scrollController.position
                                                      .maxScrollExtent, // 맨 밑으로 이동
                                                  duration: Duration(
                                                      milliseconds: 200),
                                                  curve: Curves.easeInOut,
                                                );
                                              });
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

  MyApp myAppInstance = MyApp();

  void initState() {
    // 초기 메시지 설정
    addMessage(Message("안녕하세요! 채팅에 오신 것을 환영합니다.", true, 0,
        showTimestampAndShareIcon: false));
    addMessage(Message("안녕하세요! 채팅에 오신 것을 환영합니다.", true, 9,
        showUserNameAndPhoto: false));
  }

  bool isInitialized = false;

  void startInitState() {
    if (!isInitialized) {
      _messages.add(Message("안녕하세요! 채팅에 오신 것을 환영합니다.", true, 0,
          showTimestampAndShareIcon: false));
      _messages.add(Message("안녕하세요! 채팅에 오신 것을 환영합니다.", true, 9,
          showUserNameAndPhoto: false));
      isInitialized = true;
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
    _messages.add(Message(text, isLeft, box,
        showTimestampAndShareIcon: showTimestampAndShareIcon,
        showUserNameAndPhoto: showUserNameAndPhoto));
    //myAppInstance._scrollToBottom();
    notifyListeners();
  }
}

class ListProvider with ChangeNotifier {
  List<String> topQuestionsListEnglish = [
    '1. How can I apply for a scholarship?',
    "2. Please provide the contact information for the university's support team",
    '질문 3',
    '질문 4',
    '질문 5',
    '질문 6',
    '질문 7',
    '질문 8',
    '질문 9',
    '질문 10',
  ];
  List<String> theSelectionListEnglish = [
    '1. asdfasdf',
    '2. fdsafdsa',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
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
