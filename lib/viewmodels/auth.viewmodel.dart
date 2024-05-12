import 'package:flutter/material.dart';
import '../services/auth.service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;

  User? get user => _authService.user;
  bool get isAuthenticated => user != null;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<String?> login(String email, String password) async {
    _startLoading();
    final result = await _authService.login(email, password);
    if (!result.success) {
      _handleError(result.errorMessage!);
    }
    _stopLoading();
    return result.errorMessage;
  }

  Future<String?> register(String email, String password) async {
    _startLoading();
    final result = await _authService.register(email, password);
    if (!result.success) {
      _handleError(result.errorMessage!);
    }
    _stopLoading();
    return result.errorMessage;
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  AuthViewModel(this._authService);

  void _startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void _stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void _handleError(String message) {
    _errorMessage = message;
    _stopLoading();
  }

  void clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }
}
