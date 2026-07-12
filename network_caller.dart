import 'dart:convert';

import 'package:http/http.dart' as http;

import '../controllers/auth_controller.dart';

class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? responseData;
  final String? errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.errorMessage,
  });
}

class NetworkCaller {
  static Future<NetworkResponse> getRequest(
    String url,
  ) async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      if (AuthController.accessToken != null &&
          AuthController.accessToken!.isNotEmpty) {
        headers["token"] = AuthController.accessToken!;
      }

      final response = await http
          .get(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(
            const Duration(seconds: 30),
          );

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      }

      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: jsonDecode(response.body),
        errorMessage: "Request Failed",
      );
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      if (AuthController.accessToken != null &&
          AuthController.accessToken!.isNotEmpty) {
        headers["token"] = AuthController.accessToken!;
      }

      final response = await http
          .post(
            Uri.parse(url),
            headers: headers,
            body: jsonEncode(body),
          )
          .timeout(
            const Duration(seconds: 30),
          );

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: jsonDecode(response.body),
        );
      }

      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
        responseData: jsonDecode(response.body),
        errorMessage: "Request Failed",
      );
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }
}
