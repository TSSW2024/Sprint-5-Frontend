import 'package:flutter/material.dart';
import '../models/profile.model.dart';
import '../services/profile.service.dart';

class ProfileViewModel extends ChangeNotifier {
  final ProfileService _profileService;

  ProfileViewModel(this._profileService);

  Profile? _currentProfile;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Profile? get profile => _currentProfile;

  Future<void> loadProfile() async {
    _startLoading();

    try {
      _currentProfile = await _profileService.fetchUserProfile();
      _errorMessage = null;
    } catch (e) {
      _handleError('Error al cargar el perfil');
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
}
