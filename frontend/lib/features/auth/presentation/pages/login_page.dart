import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hemawan_resort/features/auth/presentation/pages/register_page.dart';
import 'package:hemawan_resort/features/auth/presentation/widgets/box/border_for_icon.dart';
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
  bool _rememberMe = false;

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
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => const HomeShell()));
      }
    });
  }

  void _register() {
    
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         width: double.infinity,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //     colors: [
             
        //       Theme.of(context).colorScheme.secondary,
        //        Colors.white,
        //     ],
        //   ),
        // ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ยินดีต้อนรับสู่รีสอร์ทของเรา!",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(height: 48),
                // Email Field
                AuthTextField(
                  controller: _emailController,
                  labelText: 'ชื่อผู้ใช้หรืออีเมล',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 32),
                // Password Field
                AuthTextField(
                  controller: _passwordController,
                  labelText: 'รหัสผ่าน',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                          
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() => _rememberMe = value ?? false);
                            },
                            activeColor: Theme.of(context).primaryColor,
                            side: BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'จดจำรหัสผู้ใช้',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w400,
                          )
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: navigate to forgot password page
                      },
                      child: Text(
                        'ลืมรหัสผ่าน?',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                // Login Button
                AuthButton(
                  text: 'เข้าสู่ระบบ',
                  onPressed: _login,
                  isLoading: _isLoading,
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'หรือ',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400
                        )
                      ),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BorderForIcon(
                      icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
                      onPressed: () {},
                    ),
                    SizedBox(width: 24),
                    BorderForIcon(
                      icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                      onPressed: () {},
                    ),
                  ],
                ),
                // Register Link
                SizedBox(height: 16),
                TextButton(
                  onPressed: _register,
                  child: Text(
                    'ยังไม่มีบัญชี? สมัครสมาชิก',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
