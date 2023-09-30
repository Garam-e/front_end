import 'package:http/http.dart' as http;
import 'dart:convert';

class sign {
  String email;
  sign(this.email);
}

sign test = sign('');

Future<http.Response> sendDataToServer(String email) async {
  final response = await http.post(
    Uri.parse('http://158.180.79.131:8080/api/auth/${email}'),
  );
  test = sign(email);
  return response;
}

Future<http.Response> sendSignNumber(String number) async {
  var data = {"code": number, "email": test.email};
  final response = await http.patch(
    Uri.parse('http://158.180.79.131:8080/api/auth/email'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );

  print(data);

  return response;
}

Future<http.Response> sendSignUp(String name, String pass) async {
  var data = {"userId": test.email, "password": pass, "nickname": name};
  final response = await http.post(
    Uri.parse('http://158.180.79.131:8080/api/user/join'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );

  print(data);

  return response;
}
