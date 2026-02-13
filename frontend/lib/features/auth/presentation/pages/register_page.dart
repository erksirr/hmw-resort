import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hemawan_resort/features/auth/data/repositories/auth_repository.dart';
import 'package:hemawan_resort/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:hemawan_resort/features/auth/presentation/bloc/auth_event.dart';
import 'package:hemawan_resort/features/auth/presentation/bloc/auth_state.dart';
import 'package:hemawan_resort/features/auth/presentation/widgets/button/auth_button.dart';
import 'package:hemawan_resort/features/auth/presentation/widgets/button/auth_text_field.dart';
import 'package:hemawan_resort/shared/widgets/button/press_to_back.dart';
import 'package:hemawan_resort/shared/widgets/dialog/error_dialog.dart';
import 'package:hemawan_resort/shared/widgets/layout/home_shell.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        repository: AuthRepository(client: http.Client()),
      ),
      child: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatefulWidget {
  const _RegisterView();

  @override
  State<_RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<_RegisterView> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || phone.isEmpty) {
      showErrorDialog(context, 'กรุณากรอกข้อมูลให้ครบ');
      return;
    }

    if (password.isEmpty || confirmPassword.isEmpty) {
      showErrorDialog(context, 'กรุณากรอกรหัสผ่าน');
      return;
    }

    if (password != confirmPassword) {
      showErrorDialog(context, 'รหัสผ่านไม่ตรงกัน');
      return;
    }

    context.read<AuthBloc>().add(
      AuthRegisterRequested(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phone,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const HomeShell()),
            (route) => false,
          );
        } else if (state.status == AuthStatus.failure) {
          showErrorDialog(context, state.errorMessage ?? 'เกิดข้อผิดพลาด');
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
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
                AuthTextField(
                  controller: _emailController,
                  labelText: 'อีเมล',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 24),
                AuthTextField(
                  controller: _phoneController,
                  labelText: 'เบอร์โทรศัพท์',
                  prefixIcon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 24),
                AuthTextField(
                  controller: _passwordController,
                  labelText: 'รหัสผ่าน',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                ),
                SizedBox(height: 24),
                AuthTextField(
                  controller: _confirmPasswordController,
                  labelText: 'ยืนยันรหัสผ่าน',
                  prefixIcon: Icons.lock_outline,
                  obscureText: true,
                ),
                SizedBox(height: 32),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return AuthButton(
                      text: 'สมัครสมาชิก',
                      onPressed: _register,
                      isLoading: state.status == AuthStatus.loading,
                    );
                  },
                ),
                SizedBox(height: 16),
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
      ),
    );
  }
}