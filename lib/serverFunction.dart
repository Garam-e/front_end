import 'package:http/http.dart' as http;
import 'dart:convert';

String httpServer = 'example';

class sign {
  String email;
  sign(this.email);
}

sign test = sign('');

Future<http.Response> sendDataToServer(String email) async {
  final response = await http.post(
    Uri.parse('$httpServer/auth/${email}'),
  );
  test = sign(email);
  return response;
}

Future<http.Response> sendSignNumber(String number) async {
  var data = {"code": number, "email": test.email};
  final response = await http.patch(
    Uri.parse('$httpServer/auth/email'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );

  print(data);

  return response;
}

Future<http.Response> sendSignUp(String name, String pass) async {
  var data = {"userId": test.email, "password": pass, "nickname": name};
  final response = await http.post(
    Uri.parse('$httpServer/user/join'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );

  return response;
}

class LoginResponse {
  final bool isSuccess;
  final String accessToken;
  final String refreshToken;

  LoginResponse({
    required this.isSuccess,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      isSuccess: json['isSuccess'],
      accessToken: json['result']['accessToken'],
      refreshToken: json['result']['refreshToken'],
    );
  }
}

Future<LoginResponse> sendLogin(String id, String pass) async {
  var data = {"password": pass, "userId": id};
  final response = await http.post(
    Uri.parse('$httpServer/auth/login'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );
  print('asdf  ${response}');
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    final loginResponse = LoginResponse.fromJson(jsonResponse);
    return loginResponse;
  } else {
    throw Exception('Failed to send login request');
  }
}
