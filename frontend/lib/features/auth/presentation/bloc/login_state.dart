import 'package:equatable/equatable.dart';
import 'package:hemawan_resort/features/auth/data/models/resp/login_resp.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final LoginResp? authResp;
  final String? errorMessage;

  const LoginState({
    this.status = LoginStatus.initial,
    this.authResp,
    this.errorMessage,
  });

  LoginState copyWith({
    LoginStatus? status,
    LoginResp? authResp,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      authResp: authResp ?? this.authResp,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, authResp, errorMessage];
}
