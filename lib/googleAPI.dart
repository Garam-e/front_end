import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> translateText(String text, String targetLanguage) async {
  String apiKey = 'example';
  String apiUrl = 'https://translation.googleapis.com/language/translate/v2';
  String encodedText = Uri.encodeComponent(text);
  String encodedTargetLanguage = Uri.encodeComponent(targetLanguage);

  String requestUrl =
      '$apiUrl?key=$apiKey&q=$encodedText&target=$encodedTargetLanguage';

  try {
    var response = await http.get(Uri.parse(requestUrl));

    if (response.statusCode == 200) {
      var decodedResponse = json.decode(response.body);
      String translatedText =
          decodedResponse['data']['translations'][0]['translatedText'];
      print('번역된 내용 : $translatedText');
      return translatedText;
    } else {
      print('Failed to translate text. Error: ${response.statusCode}');
      return 'error';
    }
  } catch (e) {
    print('Exception caught during translation: $e');
    return 'exception error';
  }
}
