import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sidang/model/login.dart';
import 'package:sidang/model/detail.dart';
import 'package:sidang/model/profile.dart';
import 'package:sidang/model/theses.dart';
import 'package:sidang/model/seminar.dart';
import 'package:sidang/service/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://backend-pmp.unand.dev';

  Future<Login?> login(String email, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final authorizationData = responseData['data']['authorization'];
      final loginData = Login.fromJson(authorizationData);

      final profileData = responseData['data']['profile'];
      final userId = profileData['id'];
      await saveUserId(userId);

      return loginData;
    } else {
      print('Failed to login: ${response.statusCode}');
      print('Response body: ${response.body}');
      return null;
    }
  } catch (e) {
    print('Exception occurred: $e');
    return null;
  }
}

  Future<List<Theses>> fetchTheses(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/my-theses'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)['theses'];
        return responseData.map((data) => Theses.fromJson(data)).toList();
      } else {
        throw Exception('Failed to load theses');
      }
    } catch (e) {
      throw Exception('Exception occurred: $e');
    }
  }

  Future<Thesis> fetchThesisDetail(String authToken, String thesisId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/my-theses/$thesisId'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('thesis')) {
          return Thesis.fromJson(responseData['thesis']);
        } else {
          throw Exception('Thesis data not found');
        }
      } else {
        throw Exception('Failed to load thesis detail: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception occurred: $e');
    }
  }

  Future<List<Seminar>> fetchThesisSeminar(String authToken, String thesisId, String seminarId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/my-thesis/$thesisId/seminars/$seminarId'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        return List<Seminar>.from(responseData.map((x) => Seminar.fromJson(x)));
      } else if (response.statusCode == 404) {
        throw Exception('Seminar not found. Check your seminarId.');
      } else {
        throw Exception('Failed to load thesis seminar: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Exception occurred: $e');
    }
  }

  Future<bool> registerSeminar(String thesisId, Map<String, dynamic> data, String authToken) async {
    try {
      final url = Uri.parse('$baseUrl/api/my-thesis/$thesisId/seminars');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print('Seminar registered successfully');
        return true;
      } else {
        print('Failed to register seminar: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return false;
    }
  }

  Future<bool> registerDefense(String thesisId, Map<String, dynamic> data, String authToken) async {
    try {
      final url = Uri.parse('$baseUrl/api/my-thesis/$thesisId/defenses');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print('Defense registered successfully');
        return true;
      } else {
        print('Failed to register defense: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return false;
    }
  }

  Future<Profile> fetchProfile(String authToken) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/me'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body)['data'];
        return Profile.fromJson(responseData);
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      throw Exception('Exception occurred: $e');
    }
  }

  Future<bool> logout(String authToken) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/logout'),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}



