// file: lib/controller/sign_in_controller.dart

import 'package:dio/dio.dart';
import 'package:frontend/model/sign_in_model.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  final Dio _dio = Dio();
  var isLoading = false.obs;

  Future<bool> signin(User user) async {
    isLoading.value = true;

    try {
      final response = await _dio.post(
        'http://localhost:3000/api/auth/signin',
        data: user.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        // Handle success (store token, navigate, etc.)
        Get.snackbar("Success", "Login successful!");
        return true;
      } else {
        Get.snackbar("Error", response.data["message"] ?? "Signin failed");
        return false;
      }
    } catch (e) {
      Get.snackbar("Error", "Network error: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}