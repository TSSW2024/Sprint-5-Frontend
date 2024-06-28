class AuthService {
  // Simulated delay for network call
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    // Simulated authentication logic
    return email == 'admin@utem.cl' && password == '12345';
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 2));
    // Simulated sign-out logic
  }
}
