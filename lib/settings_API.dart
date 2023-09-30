import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'setting.dart';

//사용자 정보 재설정 API//
Future<void> updateUserInfo(String newNickname, String newPassword) async {
  try {
    var response = await http.patch(
      Uri.parse('http://158.180.79.131:8080/api/user/update'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": "1234@gachon.ac.kr", // 서버에 저장된 이메일 정보 가져오게 하기
        "newPassword": newPassword,
        "newNickname": newNickname,
      }),
    );

    // 서버 응답 처리 함수 호출
    await handleServerResponse(response);
  } catch (error) {
    // 오류 처리 로직 추가
    print("Error updating user info: $error");
  }
}

//문의 내용 처리 API
Future<Map<String, dynamic>> sendInquiry(
    String title, String content, String email) async {
  try {
    final response = await http.post(
      Uri.parse('http://158.180.79.131:8080/api/user/inquiry'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "title": title,
        "content": content,
        "email": email,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['isSucceed'] == true) {
        return responseBody;
      } else {
        print('Inquiry failed: ${responseBody['message']}');
        return {}; // 빈 맵 반환 또는 적절한 값 반환
      }
    } else if (response.statusCode == 403) {
      print('ERROR 403: 문의 메시지 전달 오류 발생');
      return {}; // 빈 맵 반환 또는 적절한 값 반환
    } else {
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception(
          'Failed to send inquiry. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to send inquiry: $e');
  }
}

//로그아웃 API
Future<Map<String, dynamic>> sendLogout(
    String userId, String password, String nickname) async {
  try {
    final response = await http.patch(
      Uri.parse('http://158.180.79.131:8080/api/user'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "userId": userId,
        "password": password,
        "nickname": nickname,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody;
    } else {
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to logout. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to logout: $e');
  }
}

//비밀번호 재설정 인증요청 기능 API
class resetPasswordAPI {
  static Future<Map<String, dynamic>> checkEmailAvailability(
      String email) async {
    try {
      final response = await http.get(
        Uri.parse('http://158.180.79.131:8080/api/auth/$email'),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        return responseBody;
      } else {
        throw Exception('Failed to check email availability');
      }
    } catch (e) {
      throw Exception('Failed to check email availability: $e');
    }
  }

  static Future<Map<String, dynamic>> sendEmailVerification(
      String email, String code) async {
    try {
      final response = await http.patch(
        Uri.parse('http://158.180.79.131:8080/api/auth/email'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": email,
          "code": code,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        return responseBody;
      } else {
        throw Exception('Failed to send email verification');
      }
    } catch (e) {
      throw Exception('Failed to send email verification: $e');
    }
  }
}

// 비밀번호 재설정 인증번호 확인 API
Future<Map<String, dynamic>> verifyEmail(String email, String code) async {
  try {
    final response = await http.patch(
      Uri.parse('http://your-api-url-here/api/auth/email'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "code": code,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody;
    } else {
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception(
          'Failed to verify email. Status Code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to verify email: $e');
  }
}

//비밀번호 재설정 확인버튼 API
Future<Map<String, dynamic>> resetPassword(
    String email, String newPassword, String newNickname) async {
  try {
    final response = await http.patch(
      Uri.parse('http://your-api-url-here/api/user/update'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "newPassword": newPassword,
        "newNickname": newNickname,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody;
    } else {
      throw Exception('Failed to reset password');
    }
  } catch (e) {
    throw Exception('Failed to reset password: $e');
  }
}

//서버 응답 처리 로직
Future<void> handleServerResponse(http.Response response) async {
  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = jsonDecode(response.body);
    bool isSucceed = responseData['isSucceed'];
    String message = responseData['message'];

    // 서버 응답에 따른 처리 로직 추가
    if (isSucceed) {
      // 성공 처리 로직
    } else {
      // 실패 처리 로직
    }
  } else {
    // 서버 응답이 실패인 경우의 처리 로직
    print("Server responded with status code ${response.statusCode}");
  }
}
