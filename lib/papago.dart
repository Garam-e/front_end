import "package:http/http.dart" as http;
import 'dart:convert';

Future<String> getTranslation_papagoEnglish(String text) async {
  String _client_id = "qOQkwWaz62efFo6e36tS";
  String _client_secret = "0J_FUcU3UU";
  String _content_type = "application/x-www-form-urlencoded; charset=UTF-8";
  String _url = "https://openapi.naver.com/v1/papago/n2mt";

  http.Response trans = await http.post(
    Uri.parse(_url),
    headers: {
      'Content-Type': _content_type,
      'X-Naver-Client-Id': _client_id,
      'X-Naver-Client-Secret': _client_secret
    },
    body: {
      'source': 'en', //위에서 언어 판별 함수에서 사용한 language 변수
      'target': "ko", //원하는 언어를 선택할 수 있다.
      'text': text,
    },
  );

  if (trans.statusCode == 200) {
    String translatedText =
        json.decode(trans.body)['message']['result']['translatedText'];
    return translatedText;
  } else {
    throw Exception('Failed to translate text.');
  }
}

Future<String> getTranslation_papagoKorea(String text) async {
  String _client_id = "qOQkwWaz62efFo6e36tS";
  String _client_secret = "0J_FUcU3UU";
  String _content_type = "application/x-www-form-urlencoded; charset=UTF-8";
  String _url = "https://openapi.naver.com/v1/papago/n2mt";

  http.Response trans = await http.post(
    Uri.parse(_url),
    headers: {
      'Content-Type': _content_type,
      'X-Naver-Client-Id': _client_id,
      'X-Naver-Client-Secret': _client_secret
    },
    body: {
      'source': 'ko', //위에서 언어 판별 함수에서 사용한 language 변수
      'target': "en", //원하는 언어를 선택할 수 있다.
      'text': text,
    },
  );

  if (trans.statusCode == 200) {
    String translatedText =
        json.decode(trans.body)['message']['result']['translatedText'];
    return translatedText;
  } else {
    throw Exception('Failed to translate text.');
  }
}
