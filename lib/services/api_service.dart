import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_profile.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  static const String _baseUrl = 'https://mocki.io/v1';
  static const String _profileEndpoint = '968771e1-87c6-40a5-83c8-77d2b5aa040a';

  // Fetch user profile from API
  Future<UserProfile> getUserProfile() async {
    try {
      final url = Uri.parse('$_baseUrl/$_profileEndpoint');

      final response = await http
          .get(url, headers: {'Content-Type': 'application/json'})
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw Exception(
                'Request timeout. Please check your internet connection.',
              );
            },
          );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return UserProfile.fromJson(jsonData);
      } else if (response.statusCode == 404) {
        throw Exception('Profile not found.');
      } else if (response.statusCode >= 500) {
        throw Exception('Server error. Please try again later.');
      } else {
        throw Exception(
          'Failed to load profile. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e.toString().contains('SocketException') ||
          e.toString().contains('NetworkException')) {
        throw Exception('No internet connection. Please check your network.');
      }
      rethrow;
    }
  }
}
