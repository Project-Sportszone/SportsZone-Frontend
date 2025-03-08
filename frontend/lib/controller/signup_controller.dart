import 'package:dio/dio.dart';
import 'package:frontend/model/sign_up_model.dart';
import 'package:get/get.dart';


class SignupController extends GetxController {
  final Dio _dio = Dio();
  final String apiUrl = "http://localhost:3000/api/auth/signup";

  var isLoading = false.obs;

  Future<void> signup(UserModel user) async {
    isLoading.value = true;

    try {
      final response = await _dio.post(
        apiUrl,
        data: user.toJson(),
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      if (response.statusCode == 201) {
        Get.snackbar("Success", "Signup successful! Please verify your email.");
        Get.offAllNamed('/login');
      } else {
        Get.snackbar("Error", response.data["message"] ?? "Signup failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Network error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
