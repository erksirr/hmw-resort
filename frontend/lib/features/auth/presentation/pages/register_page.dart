import 'package:flutter/material.dart';
import 'package:hemawan_resort/features/auth/presentation/pages/login_page.dart';
import 'package:hemawan_resort/features/auth/presentation/widgets/button/auth_button.dart';
import 'package:hemawan_resort/features/auth/presentation/widgets/button/auth_text_field.dart';
import 'package:hemawan_resort/shared/widgets/button/press_to_back.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    setState(() => _isLoading = true);

    // TODO: Implement actual register API call
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              // Back button
              Align(
                alignment: Alignment.centerLeft,
                child: PressToBack(),
              ),
              SizedBox(height: 24),

              Text(
                'สร้างบัญชีใหม่',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 8),
              Text(
                'กรอกข้อมูลด้านล่างเพื่อสมัครสมาชิก',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 32),

              // ชื่อ + นามสกุล
              Row(
                children: [
                  Expanded(
                    child: AuthTextField(
                      controller: _firstNameController,
                      labelText: 'ชื่อ',
                      prefixIcon: Icons.person,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: AuthTextField(
                      controller: _lastNameController,
                      labelText: 'นามสกุล',
                      prefixIcon: Icons.person_outline,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // อีเมล
              AuthTextField(
                controller: _emailController,
                labelText: 'อีเมล',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24),

              // เบอร์โทร
              AuthTextField(
                controller: _phoneController,
                labelText: 'เบอร์โทรศัพท์',
                prefixIcon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 24),

              // รหัสผ่าน
              AuthTextField(
                controller: _passwordController,
                labelText: 'รหัสผ่าน',
                prefixIcon: Icons.lock,
                obscureText: true,
              ),
              SizedBox(height: 24),

              // ยืนยันรหัสผ่าน
              AuthTextField(
                controller: _confirmPasswordController,
                labelText: 'ยืนยันรหัสผ่าน',
                prefixIcon: Icons.lock_outline,
                obscureText: true,
              ),
              SizedBox(height: 32),

              // Register Button
              AuthButton(
                text: 'สมัครสมาชิก',
                onPressed: _register,
                isLoading: _isLoading,
              ),
              SizedBox(height: 16),

              // Login Link
              Center(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'มีบัญชีอยู่แล้ว? เข้าสู่ระบบ',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
