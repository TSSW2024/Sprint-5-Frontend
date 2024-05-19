import 'package:ejemplo_1/services/profile.service.dart';
import 'package:flutter/material.dart';
import '../models/profile.model.dart';
//import '../services/profile.service.dart';


class ProfileViewModel extends ChangeNotifier {
  Profile _profile = Profile(name: 'Aburik',
   email: 'babarca@utem.cl', 
   imageUrl: 'https://pbs.twimg.com/media/GKQGCy7W8AAzYXT?format=png&name=small', 
   discordLink: 'https://discord.com/usuario', 
   githubLink: 'https://github.com/TSSW2024', 
   facebookLink: 'https://facebook.com/usuario',
   saldototal: 1000.0,
  monedas: {
    'Bitcoin': 5,
    'Ethereum': 3,
    'Litecoin': 2,
  }
   );
    var iconMap = {
      'Bitcoin': 'assets/images/bitcoin.png',
      'Ethereum': 'assets/images/etherum.png',
      'Litecoin': 'assets/images/litecoin.png',
    };

  ProfileViewModel(ProfileService profileService);

  Profile get profile => _profile;

  get errorMessage => null;

  bool? get isLoading => null;

  void updateProfile(Profile profile) {
    _profile = profile;
    notifyListeners();
  }
}


// class ProfileViewModel extends ChangeNotifier {
//   final ProfileService _profileService;

//   ProfileViewModel(this._profileService);

//   Profile? _currentProfile;
//   bool _isLoading = false;
//   String? _errorMessage;

//   bool get isLoading => _isLoading;
//   String? get errorMessage => _errorMessage;
//   Profile? get profile => _currentProfile;

//   Future<void> loadProfile() async {
//     _startLoading();

//     try {
//       _currentProfile = await _profileService.fetchUserProfile();
//       _errorMessage = null;
//     } catch (e) {
//       _handleError('Error al cargar el perfil');
//     } finally {
//       _stopLoading();
//     }
//   }

//   void _startLoading() {
//     _isLoading = true;
//     notifyListeners();
//   }

//   void _stopLoading() {
//     _isLoading = false;
//     notifyListeners();
//   }

//   void _handleError(String message) {
//     _errorMessage = message;
//     _stopLoading();
//   }
// }
