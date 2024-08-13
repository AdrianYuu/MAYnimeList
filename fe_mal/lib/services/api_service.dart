import "dart:convert";
import "package:http/http.dart" as http;

class ApiService {
  static final baseUrl = "http://localhost:3000";

  static Future<Map<String, dynamic>> get(String endpoint) async {
    final url = baseUrl + endpoint;

    try {
      final response = await http.get(Uri.parse(url));
      return {
        "statusCode": response.statusCode,
        "body": json.decode(response.body),
      };
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  static Future<Map<String, dynamic>> post(
      String endpoint, Map<String, dynamic> data) async {
    final url = baseUrl + endpoint;

    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode(data));
      return {
        "statusCode": response.statusCode,
        "body": json.decode(response.body),
      };
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  static Future<Map<String, dynamic>> put(
      String endpoint, Map<String, dynamic> data) async {
    final url = baseUrl + endpoint;

    try {
      final response = await http.put(Uri.parse(url),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode(data));
      return {
        "statusCode": response.statusCode,
        "body": json.decode(response.body),
      };
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  static Future<Map<String, dynamic>> del(String endpoint) async {
    final url = baseUrl + endpoint;

    try {
      final response = await http.delete(Uri.parse(url));
      return {
        "statusCode": response.statusCode,
        "body": json.decode(response.body),
      };
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
