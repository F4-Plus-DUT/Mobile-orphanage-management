import 'package:http/http.dart' as http;
import 'dart:convert' show json, jsonEncode;

Future<bool> loginToServer(username, password) async {
  bool isSucessfully = false;
  await http
      .post(
          // Uri.parse('https://vietdevshop-be.herokuapp.com/api/v1/account/login/'),
          Uri.parse(
              'https://dd90-116-110-95-159.ap.ngrok.io/api/v1/user/action/login'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(
              <String, String>{'email': username, 'password': password}))
      .then((response) {
    // var body = json.decode(response.body);
    print(response.statusCode);
    // print(body);
    if (response.statusCode == 200) {
      isSucessfully = true;
    }
  });
  return isSucessfully;
}

void main() async {
  if (await loginToServer('dinhgiabao2807@gmail.com', 'Abc@12345')) {
    print("Login successfully!");
  } else {
    print("Unsuccessfully!");
  }
}
