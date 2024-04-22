class Profile {
  final String? name;
  final String? email;
  final String? phone;
  final String? photoUrl;
  final String role;

  // Constructores
  Profile({
    String? name,
    String? email,
    String? phone,
    String? photoUrl,
  })  : email = email ?? 'No disponible',
        name = name ?? 'No disponible',
        phone = phone ?? 'No disponible',
        photoUrl = photoUrl ??
            'https://firebasestorage.googleapis.com/v0/b/lumo-ghub.appspot.com/o/users_profile%2Fb0fpiXJ9qhYywvKd5AOHehw2WwU2%2FimgProfile.gif?alt=media',
        role = 'client';

  // Método para convertir un documento de Firestore en un objeto Profile
  factory Profile.fromFirestore(Map<String, dynamic> data) {
    return Profile(
      name: data['name'],
      email: data['email'],
      phone: data['phone'],
      photoUrl: data['photoUrl'],
    );
  }

  // Convertir un objeto Profile a un documento de Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
    };
  }

  @override
  String toString() {
    return 'Profile(name: $name \n, email: $email \n, phone: $phone \n, photoUrl: $photoUrl \n, role: $role)';
  }
}
