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
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      // ChangeNotifierProvider 사용
      create: (context) => SelectionProvider(),
      child: MyApp(),
    ),
  );
}
// 입력창 위에 보여줄 자동완성 목록

String listTitle = '실시간 TOP 질문';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isStarSelected = false;
  bool showAutocompleteButton = false;
  String _selectedLanguage = 'KOR';
  List<Message> _messages = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  void initState() {
    super.initState();
    // 초기 메시지 설정
    _messages.add(Message("안녕하세요! 채팅에 오신 것을 환영합니다.", true, 0,
        showTimestampAndShareIcon: false));
    _messages.add(Message("안녕하세요! 채팅에 오신 것을 환영합니다.", true, 9,
        showUserNameAndPhoto: false));
  }

  void _sendMessage(String text, bool isLeft, {int box = 0}) {
    setState(() {
      _messages.add(Message(text, isLeft, box));
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void _toggleStar() {
    setState(() {
      _isStarSelected = !_isStarSelected;
    });
  }

  String _getListTitle() {
    return _isStarSelected ? '즐겨찾기' : '실시간 TOP 질문';
  }

  void _setSelectedLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
    });
  }

  bool loginState = false;

  Widget _buildMessageItem(Message message) {
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
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                margin: EdgeInsets.only(left: 8.0),
                width: 38,
                height: 38,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/mark.png"),
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
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                margin: EdgeInsets.only(left: 8.0),
                width: 38,
                height: 38,
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(right: 1, top: 8),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (theSelectionList.contains(message.text)) {
                      theSelectionList.remove(message.text);
                    } else {
                      theSelectionList.add(message.text);
                    }
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 8.0),
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(theSelectionList.contains(message.text)
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
                          ? -10
                          : 0
                      : -40),
              child: Container(
                margin: EdgeInsets.only(right: 8.0),
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
                                  setState(() {
                                    _messages
                                        .add(Message("버튼 $index 클릭됨", true, 0));
                                  });
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
                  margin: EdgeInsets.only(left: 8.0, top: 25),
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

    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: [
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
                  "가천대학교",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 1.30,
                    letterSpacing: -0.52,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: containerHeight * 0.053, left: containerWidth * 0.04),
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
                          color: _selectedLanguage == 'KOR'
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
                          color: _selectedLanguage == 'ENG'
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
                      _setSelectedLanguage(value);
                    }
                  });
                },
                child: Row(
                  children: [
                    Text(
                      _selectedLanguage,
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
                // onTap: () {
                //   Navigator.push(
                //     context,
                //     PageRouteBuilder(
                //       pageBuilder: (context, animation, secondaryAnimation) =>
                //           menu.menuPage(),
                //       transitionsBuilder:
                //           (context, animation, secondaryAnimation, child) {
                //         const begin = Offset(1.0, 0.0);
                //         const end = Offset.zero;
                //         final tween = Tween(begin: begin, end: end);
                //         final offsetAnimation = animation.drive(tween);

                //         return SlideTransition(
                //           position: offsetAnimation,
                //           child: child,
                //         );
                //       },
                //     ),
                //   );
                // },
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15)),
                    ),
                    builder: (BuildContext context) {
                      return Container(
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => loginState
                                                ? setting()
                                                : menu.menuPage(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 62,
                                        height: 62,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEDF4FF),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.settings,
                                          color: Color(0xFF2F5B9C),
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      '설정',
                                      style: TextStyle(
                                        color: Color(0xFF2F5B9C),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          // TODO: 비밀번호 재설정 임시로 지정 추후에 FAQ 창으로 설정 예정
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                resetPassword(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 62,
                                        height: 62,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEDF4FF),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.help,
                                          color: Color(0xFF2F5B9C),
                                          size: 32,
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
                                Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // TODO: 공지사항 페이지로 이동하는 코드 추가
                                      },
                                      child: Container(
                                        width: 62,
                                        height: 62,
                                        decoration: BoxDecoration(
                                          color: Color(0xFFEDF4FF),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.notifications,
                                          color: Color(0xFF2F5B9C),
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      '공지사항',
                                      style: TextStyle(
                                        color: Color(0xFF2F5B9C),
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                // 나머지 버튼들도 동일한 방식으로 구현
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
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
                height: MediaQuery.of(context).size.height * 0.88,
                color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _messages.length,
                        itemBuilder: (context, index) =>
                            _buildMessageItem(_messages[index]),
                      ),
                    ),
                    ExpandableListExample(
                      onExpand: () {
                        setState(() {});
                      },
                      listTitle: _getListTitle(),
                      onSendMessage: _sendMessage,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.0, vertical: 2),
                      color: Color(0xFFE2E4E5),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 40,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1),
                              child: InkWell(
                                onTap: () {
                                  // 버튼이 눌렸을 때 수행할 작업을 여기에 작성하세요.
                                  setState(() {
                                    _messages.add(Message(
                                        "안녕하세요! 채팅에 오신 것을 환영합니다.", true, 0,
                                        showTimestampAndShareIcon: false));
                                    _messages.add(Message(
                                        "안녕하세요! 채팅에 오신 것을 환영합니다.", true, 9,
                                        showUserNameAndPhoto: false));
                                  });
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    _scrollController.animateTo(
                                      _scrollController
                                          .position.maxScrollExtent, // 맨 밑으로 이동
                                      duration: Duration(milliseconds: 200),
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
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1),
                              child: TextField(
                                controller: _controller,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 12.0),
                                  hintText: "질문을 입력하세요",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        width: 0.8,
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    borderSide: BorderSide(
                                        width: 0.15, color: Color(0xFFBEBEBE)),
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      if (_controller.text.isNotEmpty) {
                                        _sendMessage(_controller.text, false);
                                        _controller.clear();
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
                                onTap: _toggleStar,
                                child: AnimatedCrossFade(
                                  duration: const Duration(milliseconds: 300),
                                  firstChild: Transform.scale(
                                    scale: _isStarSelected ? 1 : 1,
                                    child: SizedBox(
                                      width: 28,
                                      height: 28,
                                      child: Image.asset(
                                        "assets/star.png",
                                      ),
                                    ),
                                  ),
                                  secondChild: Transform.scale(
                                    scale: _isStarSelected ? 1 : 1,
                                    child: SizedBox(
                                      width: 28,
                                      height: 28,
                                      child: Image.asset(
                                        "assets/star2.png",
                                      ),
                                    ),
                                  ),
                                  crossFadeState: _isStarSelected
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 하단바 코드
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
      ),
      builder: (BuildContext context) {
        return Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 62, // 버튼의 너비 조정
                        height: 62, // 버튼의 높이 조정
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const setting()),
                            );
                          },
                          backgroundColor: Color(0xFFEDF4FF),
                          mini: false,
                          heroTag: null,
                          child: Image.asset('assets/settings.png'),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '설정',
                        style: TextStyle(
                          color: Color(0xFF2F5B9C),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        width: 62, // 버튼의 너비 조정
                        height: 62, // 버튼의 높이 조정
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const resetPassword()),
                            );
                          },
                          backgroundColor: Color(0xFFEDF4FF),
                          mini: false,
                          heroTag: null,
                          child: Image.asset('assets/campaign.png'),
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
                  Column(
                    children: [
                      Container(
                        width: 62, // 버튼의 너비 조정
                        height: 62, // 버튼의 높이 조정
                        child: FloatingActionButton(
                          onPressed: () {
                            // 공지사항 추가 예정
                          },
                          backgroundColor: Color(0xFFEDF4FF),
                          mini: false,
                          heroTag: null,
                          child: Image.asset('assets/Vector.png'),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        '공지사항',
                        style: TextStyle(
                          color: Color(0xFF2F5B9C),
                          fontSize: 18,
                        ),
                      ),
                    ],
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
