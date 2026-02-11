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
      final account = await GoogleSignIn.instance.authenticate();
      final idToken = account.authentication.idToken;

      final credential = GoogleAuthProvider.credential(idToken: idToken);
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;
      print("=== Google Sign-In success ===");
      print("Firebase uid: ${user?.uid}");
      print("Firebase email: ${user?.email}");
      print("Firebase displayName: ${user?.displayName}");

      emit(state.copyWith(status: LoginStatus.success));
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
