import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/profile.viewmodel.dart';
import '../../viewmodels/auth.viewmodel.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // Access the ProfileViewModel and AuthViewModel from the context
    final profileViewModel = Provider.of<ProfileViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: authViewModel.signOut,
          ),
        ],
      ),
      body: Center(
        child: buildBody(authViewModel, profileViewModel),
      ),
    );
  }

  Widget buildBody(
      AuthViewModel authViewModel, ProfileViewModel profileViewModel) {
    if (authViewModel.isLoading) {
      // Show a loading spinner while authentication is in progress
      return const CircularProgressIndicator();
    } else if (authViewModel.errorMessage != null) {
      // Display the authentication error message
      return Text(authViewModel.errorMessage!);
    } else {
      // Authentication is successful
      return buildProfileSection(profileViewModel);
    }
  }

  Widget buildProfileSection(ProfileViewModel profileViewModel) {
    if (profileViewModel.isLoading) {
      // Show a loading spinner while profile is loading
      return const CircularProgressIndicator();
    } else if (profileViewModel.errorMessage != null) {
      // Display the profile error message
      return Text(profileViewModel.errorMessage!);
    } else if (profileViewModel.profile != null) {
      // Display profile information
      return Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(profileViewModel.profile!.photoUrl!),
          ),
          const SizedBox(height: 10), // Space between elements
          Text('Nombre: ${profileViewModel.profile!.name}'),
          Text('Email: ${profileViewModel.profile!.email}'),
          Text('Teléfono: ${profileViewModel.profile!.phone}'),
        ],
      );
    } else {
      // Display a message if the profile is not available
      return const Text('Perfil no disponible');
    }
  }
}
