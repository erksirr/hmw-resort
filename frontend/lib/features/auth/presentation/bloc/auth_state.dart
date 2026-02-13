import 'package:equatable/equatable.dart';
import 'package:hemawan_resort/features/auth/data/models/resp/auth_resp.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  final AuthStatus status;
  final AuthResp? authResp;
  final String? errorMessage;

  const AuthState({
    this.status = AuthStatus.initial,
    this.authResp,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    AuthResp? authResp,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      authResp: authResp ?? this.authResp,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, authResp, errorMessage];
}