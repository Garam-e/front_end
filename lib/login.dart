import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'sign.dart' as sign;
import 'reset_password.dart';
import 'serverFunction.dart';
import 'main.dart' as main;
import 'setting.dart';
import 'token_store.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

bool _loginState = false;

String _accessToken = '';

String _refreshToken = '';

class _LoginPageState extends State<LoginPage> {
  bool _isSwitched = false;
  TextEditingController _firstTextEditingController = TextEditingController();
  TextEditingController _secondTextEditingController = TextEditingController();
  void handleLogin(String id, String password) async {
    // 로그인 처리 로직 구현
    // API 요청 보내기, 응답 받기 등

    // 예시: API 요청 보내고 응답 처리
    try {
      LoginResponse loginResponse = await sendLogin(id, password);
      bool isSuccess = loginResponse.isSuccess;
      String accessToken = loginResponse.accessToken;
      String refreshToken = loginResponse.refreshToken;

      _loginState = isSuccess;
      _refreshToken = refreshToken;
      _accessToken = accessToken;

      // 응답 처리 로직 작성
      if (isSuccess) {
        // 로그인 성공
        TokenStore tokenStore = TokenStore();
        tokenStore.accessToken = _accessToken;
        tokenStore.refreshToken = _refreshToken;
        tokenStore.saveUserID(id);

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('로그인 성공'),
              content: Text('로그인에 성공했습니다.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 알림창 닫기
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text('확인'),
                ),
              ],
            );
          },
        );
      } else {
        // 로그인 실패
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('로그인 실패'),
              content: Text('로그인에 실패했습니다.'),
              actions: [
                TextButton(
                  onPressed: () {
                    // 필요한 동작 수행
                    Navigator.of(context).pop(); // 알림창 닫기
                  },
                  child: Text('확인'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // 예외 처리
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('에러'),
            content: Text('로그인 중에 오류가 발생했습니다.'),
            actions: [
              TextButton(
                onPressed: () {
                  // 필요한 동작 수행
                  Navigator.of(context).pop(); // 알림창 닫기
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }

  Route _customPageRoute(Widget child) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final double containerHeight = screenHeight;
    final double containerWidth = screenWidth;
    var mainProvider = context.read<main.MainProvider>();

    return Column(
      children: [
        Container(
          width: containerWidth,
          height: containerHeight,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: containerWidth * 0.01,
                top: containerHeight * 0.05,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 40,
                    height: 31,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 40,
                            height: 31,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/back.png"),
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
                left: 25,
                top: 189,
                child: Material(
                  // Material 위젯 추가
                  type: MaterialType.transparency,
                  child: Container(
                    width: containerWidth * 0.88,
                    height: 49,
                    child: TextField(
                      style: TextStyle(color: Colors.black),
                      controller:
                          _firstTextEditingController, // 해당 입력창에 TextEditingController 연결
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0x192E5A9C),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: containerWidth * 0.71,
                top: 202,
                child: SizedBox(
                  width: 90,
                  height: 23,
                  child: Text(
                    '@gachon.ac.kr',
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 13,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.69,
                      letterSpacing: -0.41,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: 278,
                child: Material(
                  // Material 위젯 추가
                  type: MaterialType.transparency,
                  child: Container(
                    width: containerWidth * 0.88,
                    height: 49,
                    child: TextField(
                      controller:
                          _secondTextEditingController, // 해당 입력창에 TextEditingController 연결
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0x192E5A9C),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: Colors.black), // 글자색을 검은색으로 변경
                      obscureText: true,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: 118,
                child: SizedBox(
                  width: 168,
                  height: 26,
                  child: Text(
                    'Member Login',
                    style: TextStyle(
                      color: Color(0xFF2E5A9C),
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 0.92,
                      letterSpacing: -0.41,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 31,
                top: 166,
                child: SizedBox(
                  width: 246,
                  height: 23,
                  child: Text(
                    'ID',
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 17,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.29,
                      letterSpacing: -0.41,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 31,
                top: 254,
                child: SizedBox(
                  width: 246,
                  height: 23,
                  child: Text(
                    'Password',
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 17,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.29,
                      letterSpacing: -0.41,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: containerWidth * 0.063,
                top: 355,
                child: SizedBox(
                  width: containerWidth * 0.88,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      String ID = _firstTextEditingController.text;
                      ID = ID + '@gachon.ac.kr';
                      String password = _secondTextEditingController.text;

                      handleLogin(ID, password);
                      mainProvider.setLogin(_loginState);
                      mainProvider.setAToken(_accessToken);
                      mainProvider.setRToken(_refreshToken);
                    }, // 기능을 공백으로 변경
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF00428B)),
                    ),
                    child: Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1.53,
                        letterSpacing: -0.44,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: containerWidth * 0.81,
                top: 420,
                child: SizedBox(
                  width: 54,
                  height: 23,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        _customPageRoute(sign.signPage()),
                      );
                    },
                    child: Text(
                      '회원가입',
                      style: TextStyle(
                        color: Color(0xFF2E5A9C),
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 2,
                        letterSpacing: -0.34,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.all(0),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: containerWidth * 0.59,
                top: 420,
                child: SizedBox(
                  width: 87,
                  height: 23,
                  child: TextButton(
                    onPressed: () {
                      // 여기에 버튼 클릭 시 실행할 코드 작성

                      Navigator.of(context).push(
                        _customPageRoute(resetPassword()),
                      );
                    },
                    child: Text(
                      '비밀번호 찾기  |',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF2E5A9C),
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 2,
                        letterSpacing: -0.34,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, // 버튼 내부 패딩을 0으로 설정
                    ),
                  ),
                ),
              ),
              Positioned(
                  left: 31,
                  top: 414,
                  child: Row(
                    children: [
                      Text(
                        '자동 로그인',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF2E5A9C),
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 2,
                          letterSpacing: -0.34,
                          decoration: TextDecoration.none,
                        ),
                      ),

                      SizedBox(width: 3), // 여기서 간격을 조정합니다.

                      Transform.scale(
                          scale: 0.6, // 여기서 버튼의 크기를 조정합니다.
                          child: CupertinoSwitch(
                            value: _isSwitched,
                            onChanged: (value) {
                              setState(() {
                                _isSwitched = value;
                              });
                            },
                            activeColor:
                                Color(0xFF2E5A9C), // 여기서 버튼의 색상을 조정합니다.
                          ))
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
