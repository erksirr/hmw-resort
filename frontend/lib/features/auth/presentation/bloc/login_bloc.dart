import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hemawan_resort/features/auth/data/models/req/login_params.dart';
import 'package:hemawan_resort/features/auth/data/repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class AuthBloc extends Bloc<AuthEvent, LoginState> {
  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(const LoginState()) {
    on<AuthLoginRequested>(_onLogin);
    on<AuthGoogleSignInRequested>(_onGoogleSignIn);
    on<AuthLogoutRequested>(_onLogout);
  }

  Future<void> _onLogin(
    AuthLoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final authResp = await repository.login(
        LoginParams(email: event.email, password: event.password),
      );
      emit(state.copyWith(status: LoginStatus.success, authResp: authResp));
    } catch (e) {
      print( "=== Login failed: $e ===");
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'อีเมลหรือรหัสผ่านไม่ถูกต้อง',
      ));
    }
  }

  Future<void> _onGoogleSignIn(
    AuthGoogleSignInRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

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

      emit(state.copyWith(status: LoginStatus.success, authResp: authResp));
    } catch (e) {
      print("=== Google Sign-In failed: $e ===");
      emit(state.copyWith(
        status: LoginStatus.failure,
        errorMessage: 'เข้าสู่ระบบด้วย Google ไม่สำเร็จ',
      ));
    }
  }

  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<LoginState> emit,
  ) async {
    await repository.logout();
    print("=== Logged out ===");
    emit(const LoginState());
  }
}
