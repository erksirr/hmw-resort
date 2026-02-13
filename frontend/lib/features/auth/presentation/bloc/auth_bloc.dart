import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hemawan_resort/features/auth/data/models/req/login_params.dart';
import 'package:hemawan_resort/features/auth/data/models/req/register_params.dart';
import 'package:hemawan_resort/features/auth/data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(const AuthState()) {
    on<AuthLoginRequested>(_onLogin);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthGoogleSignInRequested>(_onGoogleSignIn);
    on<AuthLogoutRequested>(_onLogout);
  }

  Future<void> _onLogin(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final authResp = await repository.login(
        LoginParams(email: event.email, password: event.password),
      );
      emit(state.copyWith(status: AuthStatus.success, authResp: authResp));
    } catch (e) {
      print("=== Login failed: $e ===");
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'อีเมลหรือรหัสผ่านไม่ถูกต้อง',
      ));
    }
  }

  Future<void> _onRegister(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final authResp = await repository.register(
        RegisterParams(
          email: event.email,
          password: event.password,
          firstName: event.firstName,
          lastName: event.lastName,
          phoneNumber: event.phoneNumber,
        ),
      );
      emit(state.copyWith(status: AuthStatus.success, authResp: authResp));
    } catch (e) {
      print("=== Register failed: $e ===");
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'สมัครสมาชิกไม่สำเร็จ',
      ));
    }
  }

  Future<void> _onGoogleSignIn(
    AuthGoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      // 1. Google Sign-In → get Google OAuth token
      final account = await GoogleSignIn.instance.authenticate();
      final googleIdToken = account.authentication.idToken;

      // 2. Firebase Auth → get Firebase ID token
      final credential = GoogleAuthProvider.credential(idToken: googleIdToken);
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // 3. get Firebase ID token (audience = hmw-resort)
      final firebaseIdToken = await userCredential.user!.getIdToken();

      // 4. pass Firebase ID token to Spring Boot → get access_token
      final authResp = await repository.loginWithGoogle(firebaseIdToken!);

      print("=== Google Sign-In success ===");
      print("Firebase email: ${FirebaseAuth.instance.currentUser?.email}");
      print("Spring Boot token: ${authResp.accessToken}");

      emit(state.copyWith(status: AuthStatus.success, authResp: authResp));
    } catch (e) {
      print("=== Google Sign-In failed: $e ===");
      emit(state.copyWith(
        status: AuthStatus.failure,
        errorMessage: 'เข้าสู่ระบบด้วย Google ไม่สำเร็จ',
      ));
    }
  }

  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await repository.logout();
    print("=== Logged out ===");
    emit(const AuthState());
  }
}