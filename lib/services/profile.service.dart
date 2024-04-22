import '../models/profile.model.dart';

class ProfileService {
  // Simulated delay for network call
  Future<Profile> fetchUserProfile() async {
    await Future.delayed(const Duration(seconds: 2));

    // Simulated successful response
    return Profile(
      name: 'Admin',
      email: 'admin@utem.cl',
      phone: '123456789',
      photoUrl: 'https://example.com/profile_photo.jpg', // Sample photo URL
    );
  }
}
