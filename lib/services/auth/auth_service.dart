import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:game_demos/config/api_config.dart';

class AuthService {
  /// Creates a new user with the provided data.
  /// Automatically attaches Android device properties.
  Future<String> createUser(Map<String, dynamic> userData) async {
    // Extract 'user' and 'password' from userData
    final authCredentials = {
      'user': userData['user'],
      'password': userData['password']
    };
    // Remove these keys from userData
    userData.remove('user');
    userData.remove('password');
    
    // New print statements for logging POST request details
    final url = '${ApiConfig.baseUrl}/create_user';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      ...authCredentials,
    };
    final body = jsonEncode(userData);
    print('POST Request to $url');
    print('Headers: $headers');
    print('Body: $body');
    
    // Make the REST call to create the user
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to create user: ${response.statusCode}');
    }
  }

  /// Logs in the user using provided credentials.
  Future<String> login(Map<String, dynamic> credentials) async {
    final url = '${ApiConfig.baseUrl}/login';
    // New print statements for logging POST request details
    print('POST Request to $url');
    print('Headers: ${{'Content-Type': 'application/json', ...credentials}}');
    
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        ...credentials, // credentials in header
      },
      // body removed
    );
    
    if (response.statusCode == 200) {
      ApiConfig.token = jsonDecode(response.body)["token"];
      ApiConfig.user = credentials['user'];
      return ApiConfig.token;
    } else {
      throw Exception('Failed to login: ${response.statusCode}');
    }
  }
}