import 'package:flutter/material.dart';
import '../services/auth.service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;

  AuthViewModel(this._authService);

  bool _isLoading = false;
  String? _errorMessage;
  bool _isAuthenticated = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> login(String email, String password) async {
    _startLoading();
    try {
      if (await _authService.login(email, password)) {
        _isAuthenticated = true;
        _errorMessage = null;
      } else {
        _errorMessage = 'Credenciales incorrectas';
        _isAuthenticated = false;
      }
    } catch (e) {
      _handleError('Error al iniciar sesión');
    } finally {
      _stopLoading();
    }
  }

  Future<void> signOut() async {
    _startLoading();
    try {
      await _authService.signOut();
      _isAuthenticated = false;
      _errorMessage = null;
    } catch (e) {
      _handleError('Error al cerrar sesión');
    } finally {
      _stopLoading();
    }
  }

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
