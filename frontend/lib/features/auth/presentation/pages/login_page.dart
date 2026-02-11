import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hemawan_resort/features/auth/data/repositories/auth_repository.dart';
import 'package:hemawan_resort/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hemawan_resort/features/auth/presentation/bloc/login_event.dart';
import 'package:hemawan_resort/features/auth/presentation/bloc/login_state.dart';
import 'package:hemawan_resort/features/auth/presentation/pages/register_page.dart';
import 'package:hemawan_resort/features/auth/presentation/widgets/box/border_for_icon.dart';
import 'package:hemawan_resort/features/auth/presentation/widgets/button/auth_button.dart';
import 'package:hemawan_resort/features/auth/presentation/widgets/button/auth_text_field.dart';
import 'package:hemawan_resort/shared/widgets/dialog/error_dialog.dart';
import 'package:hemawan_resort/shared/widgets/layout/home_shell.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        repository: AuthRepository(client: http.Client()),
      ),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      showErrorDialog(context, 'กรุณากรอกอีเมลและรหัสผ่าน');
      return;
    }

    context.read<AuthBloc>().add(
      AuthLoginRequested(email: email, password: password),
    );
  }

  void _signInWithGoogle() {
    context.read<AuthBloc>().add(const AuthGoogleSignInRequested());
  }

  void _register() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.success) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomeShell()),
            (route) => false,
          );
        } else if (state.status == LoginStatus.failure) {
          showErrorDialog(context, state.errorMessage ?? 'เกิดข้อผิดพลาด');
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
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
                  BlocBuilder<AuthBloc, LoginState>(
                    builder: (context, state) {
                      return AuthButton(
                        text: 'เข้าสู่ระบบ',
                        onPressed: _login,
                        isLoading: state.status == LoginStatus.loading,
                      );
                    },
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
                        onPressed: _signInWithGoogle,
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
      ),
    );
  }
}
