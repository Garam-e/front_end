import 'package:shared_preferences/shared_preferences.dart';

class TokenStore {
  static final TokenStore _instance = TokenStore._internal();

  factory TokenStore() {
    return _instance;
  }

  TokenStore._internal();

  String accessToken = '';
  String refreshToken = '';
  String userID = '';

  //배포 시 삭제할 것.
  void printTokens() {
    print('Access 토큰: $accessToken');
    print('Refresh 토큰: $refreshToken');
  }

  Future<void> saveUserID(String id) async {
    // 아이디 저장 메소드
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userID', id);
    userID = id;
  }

  Future<void> loadUserID() async {
    // 아이디 불러오는 메소드
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userID') ?? '';
  }
}
