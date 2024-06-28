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
        _errorMessage = "Credenciales incorrectas";
        _isAuthenticated = false;
      }
    } catch (e) {
      _errorMessage = "Error al iniciar sesión";
    } finally {
      _stopLoading();
    }
  }

  Future<void> Register(String email, String password) async {
    _startLoading();
    try {
      if (await _authService.register(email, password)) {
        _errorMessage = "Usuario registrado";
      } else {
        _errorMessage = "Error al registrar usuario";
      }
    } catch (e) {
      _errorMessage = "Error al registrar usuario";
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
      _errorMessage = "Error al cerrar sesión";
    } finally {
      _stopLoading();
    }
  }

  Future<void> validateToken() async {
    _startLoading();
    try {
      if (await _authService.validateToken()) {
        _isAuthenticated = true;
        _errorMessage = null;
      } else {
        _isAuthenticated = false;
        _errorMessage = "Token inválido";
        _authService.signOut();
      }
    } catch (e) {
      _errorMessage = "Error al validar token";
    } finally {
      _stopLoading();
    }
  }

  Future<void> forgotPassword(String email) async {
    _startLoading();
    try {
      await _authService.forgotPassword(email);
      _errorMessage = "Correo de recuperacion enviado";
    } catch (e) {
      _errorMessage = "Error al enviar correo de recuperacion";
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

  void _handlerError(String mensaje) {
    _errorMessage = mensaje;
    _stopLoading();
  }

   void clearErrorMessage() {
    _errorMessage = null;
  }
}
