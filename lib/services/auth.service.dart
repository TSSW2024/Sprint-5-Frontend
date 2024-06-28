import "dart:convert";
import "package:http/http.dart" as http;
import "package:shared_preferences/shared_preferences.dart";

class AuthService{
  final String baseURL = "https://backend-test-sepia.vercel.app";

  Future <bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseURL/login"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data["token"];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", token);

      return true;
    } else {
      return false;
    }
  }

  Future <void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

  Future<bool> register(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseURL/register"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> validateToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token == null) {
      return false;
    }

    final response = await http.get(
      Uri.parse("$baseURL/validateToken"),
      headers: <String, String>{
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse("$baseURL/forgotPassword"),
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncode(<String, String>{
        "email": email,
      }),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception("Error al enviar el correo");
    }
  }

 
}
