// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
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
        child: buildProfileSection(profileViewModel),
      ),
    );
  }

  Widget buildBody(AuthViewModel authViewModel, ProfileViewModel profileViewModel) {
    return Column(
      children: <Widget>[
        Text('Nombre: ${profileViewModel.profile.name}'),
        Text('Email: ${profileViewModel.profile.email}'),
        Image.network(profileViewModel.profile.imageUrl),
      ],
    );
  }
  }

Widget buildProfileSection(ProfileViewModel profileViewModel) {
  if (profileViewModel.isLoading != null && profileViewModel.isLoading!) {
    // Show a loading spinner while profile is loading
    return const CircularProgressIndicator();
  } else if (profileViewModel.errorMessage != null) {
    // Display the profile error message
    return Text(profileViewModel.errorMessage!);
  } else if (profileViewModel.profile != null) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        profileViewModel.profile.name,
        style: const TextStyle(fontSize: 24),
      ),
      const SizedBox(height: 10),
      Row(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(profileViewModel.profile.imageUrl),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              profileViewModel.profile.email,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      Expanded(
        child: Container(
          color: Colors.grey[200],
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => launchUrlString(profileViewModel.profile.discordLink),
                child: const Text('Discord'),
              ),
              ElevatedButton(
                onPressed: () => launchUrlString(profileViewModel.profile.githubLink),
                child: const Text('GitHub'),
              ),
              ElevatedButton(
                onPressed: () => launchUrlString(profileViewModel.profile.facebookLink),
                child: const Text('Facebook'),
              ),
            ],
          ),
        ),
      ),
    ],
  );
} else {
  // Display a message if the profile is not available
  return const Text('Perfil no disponible');
}
}