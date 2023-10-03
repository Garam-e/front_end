import 'package:flutter/material.dart';
import 'dart:convert';
import 'serverFunction.dart';

class signPage extends StatelessWidget {
  final TextEditingController _idController =
      TextEditingController(); // 컨트롤러 생성
  final TextEditingController _singNumberController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _pass2Controller = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool certificationState = false;

  signPage({super.key});
  Route _customPageRoute(Widget child) {
    return MaterialPageRoute(builder: (context) => child);
  }

  bool isSuccess = false;
  String checkInconsistency() {
    if (_idController.text.isEmpty ||
        _singNumberController.text.isEmpty ||
        _passController.text.isEmpty ||
        _pass2Controller.text.isEmpty ||
        _nameController.text.isEmpty) {
      return "모든 입력란을 채워주세요.";
    }
    if (_passController.text != _pass2Controller.text) {
      return "비밀번호가 일치하지 않습니다.";
    }
    if (!certificationState) {
      return "인증이 필요합니다.";
    }
    return '202';
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final double containerHeight = screenHeight;
    final double containerWidth = screenWidth;

    void signUpAndHandleResponse(String name, String pass) async {
      var response = await sendSignUp(name, pass);

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        // 회원가입 성공
        var jsonResponse = jsonDecode(response.body);
        var isSucceed = jsonResponse['isSuccess'];
        var message = jsonResponse['message'];
        var succeed = jsonResponse['result']['succeed'];
        String stateSign;
        print(succeed);
        if (isSucceed) {
          stateSign = '가입 성공';
          if (!succeed) {
            stateSign = '중복 가입';
          }
        } else {
          stateSign = '가입 실패';
        }

        showDialog(
          context: context,
          builder: (BuildContext dialogContext) => AlertDialog(
            content: Text(stateSign),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('확인'),
              ),
            ],
          ),
        );
        if (stateSign == '가입 성공') {
          Navigator.pop(context);
        }
      } else {
        // 회원가입 실패
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) => AlertDialog(
              title: const Text('가입 실패33'),
              content: const Text('101'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext);
                    },
                    child: const Text("확인"))
              ]),
        );
      }
    }

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
                top: containerHeight * 0.11,
                child: const SizedBox(
                  width: 168,
                  height: 26,
                  child: Text(
                    '회원가입',
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
                left: 25,
                top: containerHeight * 0.18,
                child: const SizedBox(
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
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              Positioned(
                //id 입력창
                left: 25,
                top: containerHeight * 0.22,
                child: Material(
                  // Material 위젯 추가
                  type: MaterialType.transparency,
                  child: SizedBox(
                    width: containerWidth * 0.88,
                    height: 49,
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      controller:
                          _idController, // 해당 입력창에 TextEditingController 연결
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0x192E5A9C),
                        hintText: " 이메일",
                        hintStyle: const TextStyle(color: Colors.grey),
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
                //인증번호 입력창
                left: 25,
                top: containerHeight * 0.32,
                child: Material(
                  // Material 위젯 추가
                  type: MaterialType.transparency,
                  child: SizedBox(
                    width: containerWidth * 0.88,
                    height: 49,
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      controller:
                          _singNumberController, // 해당 입력창에 TextEditingController 연결
                      decoration: InputDecoration(
                        filled: true,
                        hintText: " 인증번호",
                        hintStyle: const TextStyle(color: Colors.grey),
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
                left: 196,
                top: containerHeight * 0.235,
                child: const SizedBox(
                  width: 90,
                  height: 23,
                  child: Text(
                    '@gachon.ac.kr',
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.83,
                      letterSpacing: -0.41,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 286,
                top: containerHeight * 0.23,
                child: SizedBox(
                  width: 87,
                  height: 37,
                  child: ElevatedButton(
                    onPressed: () async {
                      String email = "${_idController.text}@gachon.ac.kr";

                      final response = await sendDataToServer(email);

                      if (response.statusCode == 200) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                              title: const Text("알림"),
                              content: const Text("인증번호가 전송되었습니다."),
                              actions: [
                                TextButton(
                                    child: const Text("확인"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ]),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext contex) => const AlertDialog(
                              title: Text("알림"),
                              content: Text("이메일 형식이 일치하지 않습니다."),
                              actions: [
                                TextButton(onPressed: null, child: Text("확인"))
                              ]),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E5A9C)),
                    child: const Text(
                      '인증요청',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1.73,
                        letterSpacing: -0.39,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 286,
                top: containerHeight * 0.33,
                child: SizedBox(
                  width: 87,
                  height: 37,
                  child: ElevatedButton(
                    onPressed: () async {
                      final response =
                          await sendSignNumber(_singNumberController.text);
                      print('Status code: ${response.statusCode}');
                      print('Response body: ${response.body}');

                      if (response.statusCode == 200) {
                        certificationState = true;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                              title: const Text("알림"),
                              content: const Text("인증번호가 일치합니다"),
                              actions: [
                                TextButton(
                                    child: const Text("확인"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ]),
                        );
                      } else {
                        certificationState = false;
                        showDialog(
                          context: context,
                          builder: (BuildContext contex) => const AlertDialog(
                              title: Text("알림"),
                              content: Text("인증번호가 일치하지 않습니다."),
                              actions: [
                                TextButton(onPressed: null, child: Text("확인"))
                              ]),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF2E5A9C), // 버튼 배경색을 설정합니다.
                    ), // 이벤트 기능을 공백으로 설정합니다.
                    child: const Text(
                      '확인',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1.73,
                        letterSpacing: -0.39,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: containerHeight * 0.425,
                child: const SizedBox(
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
                //password 입력창
                left: 25,
                top: containerHeight * 0.47,
                child: Material(
                  // Material 위젯 추가
                  type: MaterialType.transparency,
                  child: SizedBox(
                    width: containerWidth * 0.88,
                    height: 49,
                    child: TextField(
                      obscureText: true,
                      style: const TextStyle(color: Colors.black),
                      controller:
                          _passController, // 해당 입력창에 TextEditingController 연결
                      decoration: InputDecoration(
                        hintText: " 비밀번호",
                        hintStyle: const TextStyle(color: Colors.grey),
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
                left: 25,
                top: containerHeight * 0.57,
                child: Material(
                  // Material 위젯 추가
                  type: MaterialType.transparency,
                  child: SizedBox(
                    width: containerWidth * 0.88,
                    height: 49,
                    child: TextField(
                      obscureText: true,
                      style: const TextStyle(color: Colors.black),
                      controller:
                          _pass2Controller, // 해당 입력창에 TextEditingController 연결
                      decoration: InputDecoration(
                        filled: true,
                        hintText: " 비밀번호 재입력",
                        hintStyle: const TextStyle(color: Colors.grey),
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
                left: 120,
                top: containerHeight * 0.64,
                child: SizedBox(
                  width: 246,
                  height: 21,
                  child: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _passController,
                    builder: (BuildContext context, TextEditingValue value,
                        Widget? _) {
                      final bool isLengthValid = value.text.length >= 6;
                      final String displayText =
                          isLengthValid ? '통과' : '6자리 이상 입력해 주세요';
                      final Color textColor = isLengthValid
                          ? const Color(0xFF00FF00) // 초록색으로 변경하세요.
                          : const Color(0xFFF16E6E);

                      return Text(
                        displayText,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1.47,
                          letterSpacing: -0.41,
                          decoration: TextDecoration.none,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: containerHeight * 0.7,
                child: const SizedBox(
                  width: 246,
                  height: 23,
                  child: Text(
                    '닉네임',
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
                left: 25,
                top: containerHeight * 0.87,
                child: SizedBox(
                  width: containerWidth * 0.88,
                  height: 47,
                  child: TextButton(
                    onPressed: () {
                      String memo = checkInconsistency();
                      print('asdfasdfsdffffffasdfasdfasd$memo');
                      if (memo == '202') {
                        signUpAndHandleResponse(
                            _nameController.text, _passController.text);
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String? inconsistency = checkInconsistency();
                            isSuccess = inconsistency == null;

                            return AlertDialog(
                              title: const Text('가입 실패11'),
                              content: Text('오류: $inconsistency'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('확인'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }, // 공백 이벤트로 설정
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF2E5A9C),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text(
                      '가입하기',
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
                //닉네임 입력창
                left: 25,
                top: containerHeight * 0.75,
                child: Material(
                  // Material 위젯 추가
                  type: MaterialType.transparency,
                  child: SizedBox(
                    width: containerWidth * 0.88,
                    height: 49,
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      controller:
                          _nameController, // 해당 입력창에 TextEditingController 연결
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
            ],
          ),
        ),
      ],
    );
  }
}
