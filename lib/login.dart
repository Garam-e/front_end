import 'package:flutter/material.dart';
import 'sign.dart' as sign;
import 'reset_password.dart';

class loginPage extends StatelessWidget {
  final TextEditingController _firstTextEditingController = TextEditingController();
  final TextEditingController _secondTextEditingController = TextEditingController();

  loginPage({super.key});
  Route _customPageRoute(Widget child) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
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
    return Column(
      children: [
        Container(
          width: containerWidth,
          height: containerHeight,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: containerWidth * 0.01,
                top: containerHeight * 0.05,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
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
                            decoration: const BoxDecoration(
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
                  child: SizedBox(
                    width: containerWidth * 0.88,
                    height: 49,
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      controller:
                          _firstTextEditingController, // 해당 입력창에 TextEditingController 연결
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0x192E5A9C),
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
                child: const SizedBox(
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
                  child: SizedBox(
                    width: containerWidth * 0.88,
                    height: 49,
                    child: TextField(
                      controller:
                          _secondTextEditingController, // 해당 입력창에 TextEditingController 연결
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0x192E5A9C),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.black), // 글자색을 검은색으로 변경
                      obscureText: true,
                    ),
                  ),
                ),
              ),
              const Positioned(
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
              const Positioned(
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
              const Positioned(
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
                top: 360,
                child: SizedBox(
                  width: containerWidth * 0.88,
                  height: 43,
                  child: ElevatedButton(
                    onPressed: () {
                      var ID = _firstTextEditingController.text;
                      print(ID);
                      var password = _secondTextEditingController.text;
                      print(password);
                    }, // 기능을 공백으로 변경
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xFF00428B)),
                    ),
                    child: const Text(
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
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
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white, padding: const EdgeInsets.all(0),
                    ),
                    child: const Text(
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
                        _customPageRoute(const resetPassword()),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, // 버튼 내부 패딩을 0으로 설정
                    ),
                    child: const Text(
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
                  ),
                ),
              ),
              const Positioned(
                left: 31,
                top: 420,
                child: Text(
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
              ),
            ],
          ),
        ),
      ],
    );
  }
}
