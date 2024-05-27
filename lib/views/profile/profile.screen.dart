// ignore_for_file: unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      const SizedBox(height: 10),
      Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Cambiar foto de perfil'),
                    content: const Text('¿Quieres cambiar tu foto de perfil?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Aceptar'),
                        onPressed: () {
                          // aaaaaaaaaaaaaaaaaaaaaa
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profileViewModel.profile.imageUrl),
            ),
          );
        },
      ),
      Container(
        width: double.infinity,
        margin: const EdgeInsets.all(15), 
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 194, 194, 194),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
        const SizedBox(height: 10),
        Text(
          profileViewModel.profile.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          profileViewModel.profile.email,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
          ],
        ),
      ),
      Expanded(
        child: Padding (
        padding: const EdgeInsets.all(15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),  
          child: Container(
          color: Colors.blueAccent[200],
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 350,
                margin: const EdgeInsets.only(bottom: 50.0),
                child: ElevatedButton(
                onPressed: () => launchUrlString(profileViewModel.profile.discordLink),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12.0), 
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), 
                  ),
                  backgroundColor: Colors.white,
                ),
                 child: Row(
                      children: <Widget>[
                        SvgPicture.asset('assets/images/discord.svg', height: 90, width: 90),
                        const Expanded(
                          child: Center(
                            child: Text('Discord', style: TextStyle(color: Colors.black, fontSize: 30)),
                          ),
                        ),
                      ],
                    ),
                ),
              ),
                Container(
                  height: 100,
                  width: 350,
                  margin: const EdgeInsets.only(bottom: 50.0),
                  child: ElevatedButton(
                    onPressed: () => launchUrlString(profileViewModel.profile.githubLink),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: Row(
                      children: <Widget>[
                        SvgPicture.asset('assets/images/github.svg', height: 90, width: 90),
                        const Expanded(
                          child: Center(
                            child: Text('GitHub', style: TextStyle(color: Colors.black, fontSize: 30)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Container(
                height: 100,
                width: 350,
                margin: const EdgeInsets.only(bottom: 50.0),
                child: ElevatedButton(
                  onPressed: () => launchUrlString(profileViewModel.profile.facebookLink),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      SvgPicture.asset('assets/images/facebook2.svg', height: 80, width: 80),
                      const Expanded(
                        child: Center(
                          child: Text('Facebook', style: TextStyle(color: Colors.black, fontSize: 30)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    ), 
      )
    ],
  );
} else {
  // Display a message if the profile is not available
  return const Text('Perfil no disponible');
}
}