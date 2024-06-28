import '../models/profile.model.dart';

class ProfileService {
  // Simulated delay for network call
  Future<Profile> fetchUserProfile() async {
    await Future.delayed(const Duration(seconds: 2));

    // Simulated successful response
    return Profile(
      name: 'Admin',
      email: 'admin@utem.cl',
      imageUrl: 'https://example.com/profile_photo.jpg', discordLink: '', githubLink: '', facebookLink: '',  // Sample photo URL
      monedas: {'amount': {'value': 0.0}},
      saldototal: 0.0,
    );
  }
}
