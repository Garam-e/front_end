import 'package:flutter/material.dart';

class resetPassword extends StatefulWidget {
  const resetPassword({Key? key}) : super(key: key);

  @override
  _PasswordPageState createState() => _PasswordPageState();
}

class _PasswordPageState extends State<resetPassword> {
  double screenWidth = 0.0; // 적절한 초기 값으로 변경
  double buttonWidth = 0.0; // 적절한 초기 값으로 변경
  bool isPasswordValid = true; // 비밀번호 유효성 여부를 나타내는 변수
  bool isPasswordConfirmationValid = true; // 비밀번호 확인 유효성 여부를 나타내는 변수

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    buttonWidth = screenWidth * 0.83;

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
        alignment: Alignment.topLeft,
        children: [
          Positioned(
            top: 100,
            left: 20, // 왼쪽 여분 추가
            child: Text(
              "비밀번호 재설정",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2F5B9C),
                fontFamily: 'Inter',
              ),
            ),
          ),
          Positioned(
            top: 150,
            left: 20, // 왼쪽 여분 추가
            child: Text(
              "ID",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Color(0xFF888888),
                fontFamily: 'Inter',
              ),
            ),
          ),
          Positioned(
            top: 180,
            left: 20,
            child: Container(
              width: buttonWidth * 1.105,
              child: TextField(
                decoration: InputDecoration(
                  labelText: '이메일',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Color(0xFFEAEFF5),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white), // 테두리 색상을 흰색으로 설정
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // 포커스된 상태의 테두리 색상을 흰색으로 설정
                  ),
                ),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF888888),
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
          Positioned(
            top: 200, // 적절한 위치로 조정
            right: buttonWidth * 0.32,
            child: Container(
              width: buttonWidth * 0.3,
              child: Text(
                '@gachon.ac.kr', // 버튼 텍스트
                style: TextStyle(color: Color(0xFF888888)),
              ),
            ),
          ),
          Positioned(
            top: 185, // 적절한 위치로 조정
            right: buttonWidth * 0.08,
            child: Container(
              width: buttonWidth * 0.25,
              child: ElevatedButton(
                onPressed: () {
                  // 인증 요청 로직을 추가하세요
                },
                child: Text(
                  '인증요청', // 버튼 텍스트
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF2F5B9C), // 버튼의 배경색
                ),
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: 20,
            child: Container(
              width: buttonWidth * 1.105,
              child: TextField(
                decoration: InputDecoration(
                  labelText: '인증번호',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Color(0xFFEAEFF5),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.white), // 테두리 색상을 흰색으로 설정
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.white), // 포커스된 상태의 테두리 색상을 흰색으로 설정
                  ),
                ),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF888888),
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
          Positioned(
            top: 255, // 적절한 위치로 조정
            right: buttonWidth * 0.08,
            child: Container(
              width: buttonWidth * 0.2,
              child: ElevatedButton(
                onPressed: () {
                  // 인증 요청 로직을 추가하세요
                },
                child: Text(
                  '확인', // 버튼 텍스트
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF2F5B9C), // 버튼의 배경색
                ),
              ),
            ),
          ),
          Positioned(
            top: 350,
            left: 20, // 왼쪽 여분 추가
            child: Text(
              "Password",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Color(0xFF888888),
                fontFamily: 'Inter',
              ),
            ),
          ),
          Positioned(
            top: 380,
            left: 20,
            child: Container(
              width: buttonWidth * 1.105,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    if (value.length >= 6) {
                      isPasswordValid = true;
                    } else {
                      isPasswordValid = false;
                    }
                  });
                },
                decoration: InputDecoration(
                  labelText: '6자리 이상',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Color(0xFFEAEFF5),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  errorText: !isPasswordValid ? '' : null,
                ),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF888888),
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
          Positioned(
            top: 450,
            left: 20,
            child: Container(
              width: buttonWidth * 1.105,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    if (value.length >= 6) {
                      // 비밀번호가 6자리 이상일 경우 유효성을 true로 설정
                      isPasswordValid = true;
                    } else {
                      // 비밀번호가 6자리 미만일 경우 유효성을 false로 설정
                      isPasswordValid = false;
                    }
                  });
                },
                decoration: InputDecoration(
                  labelText: '비밀번호 재입력',
                  labelStyle: TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Color(0xFFEAEFF5),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  errorText: !isPasswordValid ? '' : null,
                ),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF888888),
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ),
          if (!isPasswordValid || !isPasswordConfirmationValid)
            Positioned(
              top: 530,
              right: 20,
              child: Row(
                children: [
                  Image.asset(
                    'assets/Warning.png',
                    width: 16,
                    height: 16,
                    color: Colors.red,
                  ),
                  SizedBox(width: 5),
                  Text(
                    '비밀번호를 6자 이상 입력해주세요',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
          Positioned(
            top: 580,
            left: 20,
            child: Container(
              width: buttonWidth * 1.1,
              height: 46,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: 비밀번호 재설정 로직 추가
                },
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF2F5B9C),
                  side: BorderSide(color: Colors.white),
                ),
                child: Text(
                  '재설정하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
