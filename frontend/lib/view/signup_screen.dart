import 'package:flutter/material.dart';
import 'package:frontend/controller/signup_controller.dart';
import 'package:frontend/model/sign_up_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupController _signupController = Get.put(SignupController());

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  
  DateTime? _selectedDate;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _signup() {
    if (!_formKey.currentState!.validate()) return;

    final user = UserModel(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      location: _locationController.text.trim(),
      dateOfBirth: _dobController.text,
    );

    _signupController.signup(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.sports, size: 80, color: Theme.of(context).primaryColor),
                  const SizedBox(height: 16),
                  const Text('Create Account', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                  const SizedBox(height: 8),
                  const Text('Join our sports community', style: TextStyle(fontSize: 16, color: Colors.grey), textAlign: TextAlign.center),
                  const SizedBox(height: 32),

                  // Name Field
                  _buildTextField(controller: _nameController, label: 'Full Name', icon: Icons.person, validator: (value) {
                    return value!.trim().isEmpty ? 'Please enter your name' : null;
                  }),

                  // Email Field
                  _buildTextField(controller: _emailController, label: 'Email', icon: Icons.email, keyboardType: TextInputType.emailAddress, validator: (value) {
                    return value!.trim().isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value) ? 'Enter a valid email' : null;
                  }),

                  // Password Field
                  _buildPasswordField(controller: _passwordController, label: 'Password', obscureText: _obscurePassword, onTap: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  }),

                  // Confirm Password Field
                  _buildPasswordField(controller: _confirmPasswordController, label: 'Confirm Password', obscureText: _obscureConfirmPassword, onTap: () {
                    setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                  }, validator: (value) {
                    return value != _passwordController.text ? 'Passwords do not match' : null;
                  }),

                  // Location Field
                  _buildTextField(controller: _locationController, label: 'Location', icon: Icons.location_on, validator: (value) {
                    return value!.trim().isEmpty ? 'Enter your location' : null;
                  }),

                  // Date of Birth
                  GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: _buildTextField(controller: _dobController, label: 'Date of Birth', icon: Icons.calendar_today, validator: (value) {
                        return value!.isEmpty ? 'Select your date of birth' : null;
                      }),
                    ),
                  ),

                  const SizedBox(height: 32),
                  Obx(() => ElevatedButton(
                        onPressed: _signupController.isLoading.value ? null : _signup,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color(0xFF3949AB),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: _signupController.isLoading.value
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Sign Up', style: TextStyle(fontSize: 16)),
                      )),
                  const SizedBox(height: 24),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('Already have an account?'),
                    TextButton(onPressed: () => Get.toNamed('/login'), child: const Text('Log In', style: TextStyle(color: Color(0xFF3949AB), fontWeight: FontWeight.bold))),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({required TextEditingController controller, required String label, required bool obscureText, required VoidCallback onTap, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: onTap,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: validator,
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String label, required IconData icon, TextInputType? keyboardType, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
