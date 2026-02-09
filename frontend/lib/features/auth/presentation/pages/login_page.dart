import 'package:flutter/material.dart';
import 'package:hemawan_resort/features/auth/presentation/pages/register_page.dart';
import 'package:hemawan_resort/features/auth/presentation/widgets/button/auth_button.dart';
import 'package:hemawan_resort/features/auth/presentation/widgets/button/auth_text_field.dart';
import 'package:hemawan_resort/shared/widgets/layout/home_shell.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    setState(() => _isLoading = true);

    // Implement actual login API call
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeShell()),
        );
      }
    });
  }
    void _register() {
    setState(() => _isLoading = true);

    // Implement actual login API call
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const RegisterPage()),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              const Text(
                'Hemawan Resort',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lexend',
                ),
              ),
              const SizedBox(height: 48),

              // Email Field
              AuthTextField(
                controller: _emailController,
                labelText: 'อีเมล',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Password Field
              AuthTextField(
                controller: _passwordController,
                labelText: 'รหัสผ่าน',
                prefixIcon: Icons.lock,
                obscureText: true,
              ),
              const SizedBox(height: 24),

              // Login Button
              AuthButton(
                text: 'เข้าสู่ระบบ',
                onPressed: _login,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 16),

              // Register Link
              TextButton(
                onPressed: _register,
                child: const Text(
                  'ยังไม่มีบัญชี? สมัครสมาชิก',
                  style: TextStyle(fontFamily: 'NotoSansThai'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
